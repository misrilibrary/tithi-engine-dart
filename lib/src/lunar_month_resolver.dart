import 'astronomy.dart';
import 'ayanamsha.dart';
import 'lunar_month.dart';
import 'regions/registry.dart';
import 'tithi.dart';

/// A lunar month span: from one boundary to the next, with its month name.
class MonthSpan {
  final DateTime start;
  final DateTime end;
  final LunarMonth month;
  final bool
      isAdhika; // true = adhika (extra/leap) month, false = nij (regular)
  MonthSpan(this.start, this.end, this.month, {this.isAdhika = false});
}

/// Determines the correct lunar month for any date.
///
/// Naming uses the sankranti rule:
///   - Count Sun sign transitions (sankrantis) within each Amant span
///   - 1 sankranti → normal month, named by the sign Sun enters
///   - 0 sankrantis → adhika (leap) month, takes name of next normal month
///   - 2 sankrantis → kshaya (dropped) month
///
/// Purnimant names are derived from Amant: Amant month + 1 in cycle.
class LunarMonthResolver {
  final MonthSystem system;
  final String city;

  /// Sunrise convention for the boundary scan and corrections. Defaults to
  /// [SunriseConvention.upperLimb] (original behavior).
  final SunriseConvention convention;
  final Map<int, List<MonthSpan>> _cache = {};

  LunarMonthResolver({
    this.system = MonthSystem.purnimant,
    this.city = defaultCity,
    this.convention = SunriseConvention.upperLimb,
  });

  /// Get the lunar month for a given date.
  LunarMonth getMonth(DateTime date) => getMonthInfo(date).month;

  /// Get the lunar month and adhika status for a given date.
  ({LunarMonth month, bool isAdhika}) getMonthInfo(DateTime date) {
    final spans = getSpansForYear(date.year);
    for (final span in spans) {
      if (!date.isBefore(span.start) && date.isBefore(span.end)) {
        return (month: span.month, isAdhika: span.isAdhika);
      }
    }
    final prevSpans = getSpansForYear(date.year - 1);
    for (final span in prevSpans) {
      if (!date.isBefore(span.start) && date.isBefore(span.end)) {
        return (month: span.month, isAdhika: span.isAdhika);
      }
    }
    return (month: LunarMonth.chaitra, isAdhika: false);
  }

  List<MonthSpan> getSpansForYear(int year) {
    if (_cache.containsKey(year)) return _cache[year]!;

    // Find all Amavasya (T30) and Purnima (T15) dates
    final amavasyas = <DateTime>[];
    final purnimas = <DateTime>[];

    final scanStart = DateTime.utc(year - 1, 10, 1);
    final scanEnd = DateTime.utc(year + 1, 3, 1);

    // Meeus scan for boundaries, with corrections applied
    final tithiCorr = getTithiCorrections(city, convention);
    int? prevTithi;
    for (var dt = scanStart;
        dt.isBefore(scanEnd);
        dt = dt.add(const Duration(days: 1))) {
      final sunrise =
          computeSunrise(dt, lookupCityLocation(city), convention: convention);
      final sunLong = toSidereal(sunLongitude(sunrise), sunrise);
      final moonLong = toSidereal(moonLongitude(sunrise), sunrise);
      final tithiNum = calculateTithi(moonLong, sunLong);
      // Effective tithi: correction table overrides Meeus
      final dayIdx = dt.difference(_epoch).inDays;
      final effTithi = tithiCorr[dayIdx] ?? tithiNum;

      if (prevTithi != null) {
        if (effTithi == 30 && prevTithi != 30) {
          amavasyas.add(dt);
        } else if (effTithi == 30 && prevTithi == 30) {
          // Double Amavasya: use the last day directly — it IS the boundary.
          if (amavasyas.isNotEmpty) amavasyas[amavasyas.length - 1] = dt;
        } else if (prevTithi >= 28 && prevTithi < 30 && effTithi <= 2) {
          amavasyas.add(dt.subtract(const Duration(days: 1)));
        }
        if (effTithi == 15 && prevTithi != 15) {
          purnimas.add(dt);
        } else if (effTithi == 15 && prevTithi == 15) {
          // Double Purnima: use the last day directly — it IS the boundary.
          if (purnimas.isNotEmpty) purnimas[purnimas.length - 1] = dt;
        } else if (prevTithi >= 13 &&
            prevTithi < 15 &&
            effTithi > 15 &&
            effTithi <= 17) {
          purnimas.add(dt.subtract(const Duration(days: 1)));
        }
      }
      prevTithi = effTithi;
    }

    // Step 1: Build Amant spans, named by MOMENT-based sankranti assignment.
    // An amanta month runs from one new-moon MOMENT to the next. A sankranti
    // belongs to the month whose moment-interval contains it. Comparing the
    // exact sankranti moment (the sign at the new-moon moment) resolves the
    // boundary case where a sankranti falls on the same day as the amavasya.
    final newMoons = [for (final a in amavasyas) _newMoonMoment(a)];
    final amantSpans = <MonthSpan>[];

    for (var i = 0; i < amavasyas.length - 1; i++) {
      final spanStart = amavasyas[i].add(const Duration(days: 1));
      final spanEnd = amavasyas[i + 1].add(const Duration(days: 1));

      // Sun sign at each bounding new-moon moment. The number of sign
      // boundaries crossed in between is the sankranti count for this month.
      final signStart = _siderealSunSign(newMoons[i]);
      final signEnd = _siderealSunSign(newMoons[i + 1]);
      final crossings = (signEnd - signStart + 12) % 12;

      if (crossings == 0) {
        // No sankranti → adhika (name assigned below from next nij month).
        amantSpans.add(
            MonthSpan(spanStart, spanEnd, LunarMonth.chaitra, isAdhika: true));
      } else {
        // 1 sankranti (nij) or 2 (kshaya) → named by the FIRST sankranti,
        // i.e. the next sign the Sun enters after the starting new moon.
        amantSpans.add(MonthSpan(
            spanStart, spanEnd, _signToMonthAmant((signStart + 1) % 12)));
      }
    }

    // Adhika takes the name of the NEXT regular (nij) month (forward naming).
    // Drik uses the same adhika name in both amanta and purnimant systems.
    for (var i = 0; i < amantSpans.length; i++) {
      if (!amantSpans[i].isAdhika) continue;
      for (var j = i + 1; j < amantSpans.length; j++) {
        if (!amantSpans[j].isAdhika) {
          amantSpans[i] = MonthSpan(
              amantSpans[i].start, amantSpans[i].end, amantSpans[j].month,
              isAdhika: true);
          break;
        }
      }
    }

    // Step 2: Build final spans based on system
    final spans = <MonthSpan>[];

    if (system == MonthSystem.purnimant) {
      // Purnimant: regular (nij) months run Purnima-to-Purnima, while an adhika
      // month is inserted whole (Amavasya-to-Amavasya, amanta-style). Realize
      // this per-paksha by splitting each amanta month at its inner Purnima:
      //   shukla paksha of month M      → (M, same adhika flag)
      //   krishna paksha of nij month M → (M+1, nij)   [Krishna belongs to next]
      //   krishna paksha of adhika M    → (M, adhika)   [adhika keeps its name]
      for (final am in amantSpans) {
        DateTime? purnima;
        for (final p in purnimas) {
          if (!p.isBefore(am.start) && p.isBefore(am.end)) {
            purnima = p;
            break;
          }
        }
        if (purnima == null) {
          spans.add(am); // degrade gracefully at window edges
          continue;
        }
        final krishnaStart = purnima.add(const Duration(days: 1));
        spans.add(
            MonthSpan(am.start, krishnaStart, am.month, isAdhika: am.isAdhika));
        final krishnaMonth = am.isAdhika
            ? am.month
            : LunarMonth.values[(LunarMonth.values.indexOf(am.month) + 1) % 12];
        spans.add(MonthSpan(krishnaStart, am.end, krishnaMonth,
            isAdhika: am.isAdhika));
      }
    } else {
      // Amant: use the spans we already built
      spans.addAll(amantSpans);
    }

    // Filter to spans that overlap with the target year
    final yearStart = DateTime.utc(year, 1, 1);
    final yearEnd = DateTime.utc(year + 1, 1, 1);
    final filtered = spans
        .where((s) => s.start.isBefore(yearEnd) && s.end.isAfter(yearStart))
        .toList();

    _cache[year] = filtered;
    return filtered;
  }

  /// Amant: sankranti sign → month name
  static LunarMonth _signToMonthAmant(int sign) {
    const map = [
      LunarMonth.chaitra, // 0: Sun enters Mesha
      LunarMonth.vaishakha, // 1: Sun enters Vrishabha
      LunarMonth.jyeshtha, // 2: Sun enters Mithuna
      LunarMonth.ashadha, // 3: Sun enters Karka
      LunarMonth.shravana, // 4: Sun enters Simha
      LunarMonth.bhadrapada, // 5: Sun enters Kanya
      LunarMonth.ashvina, // 6: Sun enters Tula
      LunarMonth.kartika, // 7: Sun enters Vrischika
      LunarMonth.margashirsha, // 8: Sun enters Dhanu
      LunarMonth.pausha, // 9: Sun enters Makara
      LunarMonth.magha, // 10: Sun enters Kumbha
      LunarMonth.phalguna, // 11: Sun enters Meena
    ];
    return map[sign];
  }

  static final _epoch = DateTime.utc(1900, 1, 1);
}

/// Sidereal Sun sign (0=Mesha .. 11=Meena) at an exact moment.
int _siderealSunSign(DateTime dt) =>
    (toSidereal(sunLongitude(dt), dt) / 30).floor() % 12;

/// Signed Moon-Sun elongation in degrees, normalized to (-180, 180].
/// Zero at the new moon (and increasing through it).
double _signedElongation(DateTime dt) {
  final sun = toSidereal(sunLongitude(dt), dt);
  final moon = toSidereal(moonLongitude(dt), dt);
  var e = (moon - sun) % 360;
  if (e < 0) e += 360;
  return e > 180 ? e - 360 : e;
}

/// Exact UTC new-moon moment for the given Amavasya day. The astronomical new
/// moon occurs at or shortly after the Amavasya sunrise, so bracket [day-1, day+2]
/// (only one new moon can lie in that window) and bisect the elongation zero.
DateTime _newMoonMoment(DateTime amavasyaDay) {
  var lo = DateTime.utc(amavasyaDay.year, amavasyaDay.month, amavasyaDay.day)
      .subtract(const Duration(days: 1));
  var hi = lo.add(const Duration(days: 3));
  for (var i = 0; i < 44; i++) {
    final mid =
        lo.add(Duration(milliseconds: hi.difference(lo).inMilliseconds ~/ 2));
    if (_signedElongation(mid) < 0) {
      lo = mid;
    } else {
      hi = mid;
    }
  }
  return lo.add(Duration(milliseconds: hi.difference(lo).inMilliseconds ~/ 2));
}
