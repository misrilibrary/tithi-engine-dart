import 'astronomy.dart';
import 'ayanamsha.dart';
import 'finder.dart';
import 'lunar_month.dart';
import 'lunar_month_resolver.dart';
import 'month_converter.dart';
import 'regions/registry.dart';
import 'tithi.dart' as tithi_core;

export 'lunar_month.dart' show LunarMonth, MonthSystem;
export 'tithi.dart' show Paksha;

/// Complete tithi information for a date.
class TithiInfo {
  final int tithiNumber; // 1-30
  final String tithiName; // e.g. "Chaturdashi"
  final tithi_core.Paksha paksha;
  final int tithiInPaksha; // 1-15
  final LunarMonth month;
  final bool isAdhika; // true = adhika (leap) month
  final String displayName; // e.g. "Phalguna Krishna Chaturdashi"

  const TithiInfo({
    required this.tithiNumber,
    required this.tithiName,
    required this.paksha,
    required this.tithiInPaksha,
    required this.month,
    this.isAdhika = false,
    required this.displayName,
  });

  /// Build a [TithiInfo] for a STORED tithi spec (number + month + the system
  /// it was recorded in), deriving paksha/name/position and the display string.
  ///
  /// If [displaySystem] differs from [storedSystem], the month name is converted
  /// between Purnimant/Amant for display (the tithi itself is unchanged).
  /// This is pure naming/rendering — no astronomy — and is the single source of
  /// truth for turning a saved tithi into a labelled [TithiInfo].
  factory TithiInfo.fromStored({
    required int tithiNumber,
    required LunarMonth month,
    required MonthSystem storedSystem,
    bool isAdhika = false,
    MonthSystem? displaySystem,
  }) {
    final paksha = tithi_core.getPaksha(tithiNumber);
    final name = tithi_core.getTithiName(tithiNumber);
    final inPaksha = tithi_core.tithiInPaksha(tithiNumber);
    final target = displaySystem ?? storedSystem;
    final displayMonth = target == storedSystem
        ? month
        : convertMonth(month, paksha, from: storedSystem, to: target);
    final pakshaStr = paksha == tithi_core.Paksha.shukla ? 'Shukla' : 'Krishna';
    final adhikaPrefix = isAdhika ? 'Adhika ' : '';
    final display = '$adhikaPrefix${displayMonth.displayName} $pakshaStr $name';
    return TithiInfo(
      tithiNumber: tithiNumber,
      tithiName: name,
      paksha: paksha,
      tithiInPaksha: inPaksha,
      month: displayMonth,
      isAdhika: isAdhika,
      displayName: display,
    );
  }

  @override
  String toString() => displayName;
}

/// A contiguous span of a single tithi within an enumeration window.
///
/// Returned by [TithiCalculator.tithiSegments] / `Panchang.tithiSegments`. The
/// window is partitioned by every tithi transition inside it, so N transitions
/// yield N+1 segments. [startUtc]/[endUtc] are clipped to the window edges;
/// [startIsTransition]/[endIsTransition] indicate whether that edge is a real
/// tithi boundary (true) or just the window clip (false).
class TithiSegment {
  final DateTime startUtc; // UTC, inclusive
  final DateTime endUtc; // UTC, exclusive
  final TithiInfo tithi;
  final bool startIsTransition;
  final bool endIsTransition;

  const TithiSegment({
    required this.startUtc,
    required this.endUtc,
    required this.tithi,
    required this.startIsTransition,
    required this.endIsTransition,
  });

  @override
  String toString() =>
      '${tithi.displayName} [${startUtc.toIso8601String()} → ${endUtc.toIso8601String()}]';
}

/// Pure Dart tithi calculator. No external dependencies.
///
/// Time inputs are **UTC instants**; the calculator performs no wall-clock or
/// DST conversion. Where a civil-day mapping is needed (correction-table row
/// selection), the caller supplies the `offset` in effect at that instant and
/// the calculator derives the civil date via [_civilDayIndex]. Resolving the
/// DST-correct offset is the caller's responsibility.
class TithiCalculator {
  final MonthSystem monthSystem;
  late final LunarMonthResolver _monthResolver;

  /// Per-city resolver cache. The default city uses [_monthResolver]; every
  /// other city's resolver is built once and reused, so its per-year month-span
  /// cache survives across calls.
  final Map<String, LunarMonthResolver> _resolverCache = {};

  TithiCalculator({this.monthSystem = MonthSystem.purnimant}) {
    _monthResolver = LunarMonthResolver(system: monthSystem);
  }

  /// Returns the (cached) resolver for [city].
  LunarMonthResolver _resolverFor(String city) {
    if (city == defaultCity) return _monthResolver;
    return _resolverCache[city] ??=
        LunarMonthResolver(system: monthSystem, city: city);
  }

  // ── Public API ───────────────────────────────────────────────────────────

  /// Sunrise tithi for the panchang day of [date] at [city] (observance/display).
  ///
  /// Only [date]'s calendar fields (year/month/day) select the day; time-of-day
  /// is ignored. No offset is required — sunrise is astronomical (from lat/lon).
  /// Uses the corrected sunrise tithi when tabled, Meeus fallback otherwise.
  TithiInfo tithiOnDate(DateTime date, String city) {
    final civilDate = DateTime.utc(date.year, date.month, date.day);
    final dayIndex = civilDate.difference(_epoch).inDays;
    final loc = getLocationForCity(city);
    final tithiNum = getTithiCorrections(city)[dayIndex] ??
        _meeusTithiAt(computeSunrise(date, loc));
    return _buildInfo(tithiNum, civilDate, city);
  }

  /// Tithi active at the exact UTC [utcInstant] at [city] (birth-time precision).
  ///
  /// [offset] is the actual (DST-aware) UTC offset in effect at that instant in
  /// [city]; its only job is to derive the civil date for correction-table row
  /// selection (see [_civilDayIndex]). The astronomy uses [utcInstant] directly.
  TithiInfo tithiAtInstant(DateTime utcInstant, String city,
      {required Duration offset}) {
    assert(utcInstant.isUtc, 'tithiAtInstant requires a UTC instant');
    final dayIndex = _civilDayIndex(utcInstant, offset);
    final transMinute = getTransitionMinutes(city)[dayIndex];
    final int tithiNum;
    if (transMinute != null) {
      final mins = _standardLocalMinutes(utcInstant, city);
      final sunriseTithi = getTithiCorrections(city)[dayIndex]!;
      tithiNum = mins >= transMinute
          ? sunriseTithi
          : (sunriseTithi - 1 == 0 ? 30 : sunriseTithi - 1);
    } else {
      tithiNum = _meeusTithiAt(utcInstant);
    }
    final civil = utcInstant.add(offset);
    return _buildInfo(
        tithiNum, DateTime.utc(civil.year, civil.month, civil.day), city);
  }

  /// Enumerate every tithi segment within `[windowStartUtc, windowEndUtc)` at
  /// [city]. N transitions inside the window → N+1 segments.
  ///
  /// The caller frames the window — e.g. a civil day's local-midnight→midnight
  /// converted to UTC (DST-aware) — and supplies [offset] (the offset in effect
  /// during the window) used only for correction-table row selection.
  ///
  /// Hybrid accuracy (Phase 1): transition *instants* are found by astronomy and
  /// the table-known boundary is snapped to its corrected instant; segment tithi
  /// *labels* are anchored to the corrected sunrise tithi and stepped ±1 across
  /// each boundary, so labels stay Swiss-accurate even where Meeus alone is off.
  List<TithiSegment> tithiSegments(
      DateTime windowStartUtc, DateTime windowEndUtc, String city,
      {required Duration offset}) {
    assert(windowStartUtc.isUtc && windowEndUtc.isUtc,
        'tithiSegments requires UTC window bounds');
    final loc = getLocationForCity(city);
    final dayIndex = _civilDayIndex(windowStartUtc, offset);
    final civil = windowStartUtc.add(offset);
    final civilDate = DateTime.utc(civil.year, civil.month, civil.day);

    // 1. All transition instants inside the window (astronomy).
    final transitions = _findAllTransitions(windowStartUtc, windowEndUtc);

    // 2. Snap the table-known boundary to its corrected instant (Swiss-exact).
    final transMinute = getTransitionMinutes(city)[dayIndex];
    if (transMinute != null && transitions.isNotEmpty) {
      final correctedUtc = _stdLocalMinutesToUtc(civilDate, transMinute, city);
      if (correctedUtc.isAfter(windowStartUtc) &&
          correctedUtc.isBefore(windowEndUtc)) {
        var bestI = 0;
        var bestDelta = transitions[0].difference(correctedUtc).abs();
        for (var i = 1; i < transitions.length; i++) {
          final d = transitions[i].difference(correctedUtc).abs();
          if (d < bestDelta) {
            bestDelta = d;
            bestI = i;
          }
        }
        if (bestDelta <= const Duration(minutes: 45)) {
          transitions[bestI] = correctedUtc;
        }
      }
    }

    // 3. Anchor labels to the corrected sunrise tithi, step ±1 across boundaries.
    final anchorTithi = getTithiCorrections(city)[dayIndex] ??
        _meeusTithiAt(computeSunrise(civilDate, loc));
    final sunriseUtc = computeSunrise(civilDate, loc);
    final bounds = <DateTime>[windowStartUtc, ...transitions, windowEndUtc];

    var sunriseSeg = 0;
    for (var i = 0; i < bounds.length - 1; i++) {
      if (!sunriseUtc.isBefore(bounds[i]) &&
          sunriseUtc.isBefore(bounds[i + 1])) {
        sunriseSeg = i;
        break;
      }
    }

    final segments = <TithiSegment>[];
    final last = bounds.length - 2;
    for (var i = 0; i <= last; i++) {
      final tnum = _wrap30(anchorTithi + (i - sunriseSeg));
      final mid = bounds[i].add(Duration(
          milliseconds:
              bounds[i + 1].difference(bounds[i]).inMilliseconds ~/ 2));
      segments.add(TithiSegment(
        startUtc: bounds[i],
        endUtc: bounds[i + 1],
        tithi: _buildInfo(tnum, mid, city),
        startIsTransition: i > 0,
        endIsTransition: i < last,
      ));
    }
    return segments;
  }

  /// Find when a tithi falls in a given year for a celebration city.
  /// Returns all occurrences (usually 1, sometimes 2).
  List<DateTime> findInYear(TithiInfo info, int year,
      {String? celebrationCity}) {
    final city = celebrationCity ?? defaultCity;
    final resolver = _resolverFor(city);
    return findTithiInYear(
      month: info.month,
      paksha: info.paksha,
      tithiInPakshaNum: info.tithiInPaksha,
      year: year,
      resolver: resolver,
      system: monthSystem,
      isAdhika: info.isAdhika,
      sunriseFn: (dt) => computeSunrise(dt, getLocationForCity(city)),
    );
  }

  /// Find the next occurrence of a tithi from today (or a given date).
  DateTime? findNext(TithiInfo info,
      {DateTime? from, String? celebrationCity}) {
    final city = celebrationCity ?? defaultCity;
    final resolver = _resolverFor(city);
    return findNextOccurrence(
      month: info.month,
      paksha: info.paksha,
      tithiInPakshaNum: info.tithiInPaksha,
      resolver: resolver,
      from: from,
      system: monthSystem,
      sunriseFn: (dt) => computeSunrise(dt, getLocationForCity(city)),
    );
  }

  // ── Internal helpers ───────────────────────────────────────────────────────

  static final _epoch = DateTime.utc(1900, 1, 1);

  /// Correction-table row index for [utcInstant], keyed by its **civil date**
  /// (instant + the caller's DST-aware [offset]). This is the single indexing
  /// path: never derive the day from the raw UTC instant, or an evening birth
  /// that crosses UTC midnight would select the wrong day's corrections.
  static int _civilDayIndex(DateTime utcInstant, Duration offset) {
    final civil = utcInstant.add(offset);
    return DateTime.utc(civil.year, civil.month, civil.day)
        .difference(_epoch)
        .inDays;
  }

  /// [utcInstant] expressed as minute-of-day in the city's **fixed standard**
  /// local time — the frame the transition-minute table is stored in. Uses the
  /// city's standard offset (a location constant), never DST.
  static int _standardLocalMinutes(DateTime utcInstant, String city) {
    final stdMin = (getLocationForCity(city).utcOffset * 60).round();
    final local = utcInstant.add(Duration(minutes: stdMin));
    return (local.hour * 60 + local.minute) % 1440;
  }

  /// Inverse of [_standardLocalMinutes]: a standard-local minute-of-day on
  /// [civilDate] back to a UTC instant (for snapping a corrected boundary).
  static DateTime _stdLocalMinutesToUtc(
      DateTime civilDate, int minutes, String city) {
    final stdMin = (getLocationForCity(city).utcOffset * 60).round();
    return DateTime.utc(civilDate.year, civilDate.month, civilDate.day)
        .subtract(Duration(minutes: stdMin))
        .add(Duration(minutes: minutes));
  }

  /// Pure-astronomy tithi number (1-30) at an absolute UTC instant.
  static int _meeusTithiAt(DateTime utcInstant) {
    final sun = toSidereal(sunLongitude(utcInstant), utcInstant);
    final moon = toSidereal(moonLongitude(utcInstant), utcInstant);
    return tithi_core.calculateTithi(moon, sun);
  }

  /// Map any integer to the 1-30 tithi cycle.
  static int _wrap30(int n) => ((n - 1) % 30 + 30) % 30 + 1;

  /// All tithi transition instants in `[start, end)`, in chronological order.
  /// Coarse 1-hour scan (tithis are ≥~19.5h, so no transition is skipped) then
  /// 30-second bisection of each detected change.
  static List<DateTime> _findAllTransitions(DateTime start, DateTime end) {
    final out = <DateTime>[];
    const step = Duration(hours: 1);
    var segLo = start;
    var loTithi = _meeusTithiAt(start);
    var probe = start.add(step);
    while (true) {
      final cur = probe.isAfter(end) ? end : probe;
      final t = _meeusTithiAt(cur);
      if (t != loTithi) {
        final b = _bisect(segLo, cur, loTithi);
        if (b.isAfter(start) && b.isBefore(end)) out.add(b);
        loTithi = t;
      }
      segLo = cur;
      if (!cur.isBefore(end)) break;
      probe = probe.add(step);
    }
    return out;
  }

  /// Bisect `[lo, hi]` for the first instant whose tithi differs from
  /// [startTithi] (30-second precision).
  static DateTime _bisect(DateTime lo, DateTime hi, int startTithi) {
    while (hi.difference(lo).inSeconds > 30) {
      final mid = lo.add(Duration(seconds: hi.difference(lo).inSeconds ~/ 2));
      if (_meeusTithiAt(mid) == startTithi) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    return hi;
  }

  /// Shared labeling: tithi number + month-resolution instant → full [TithiInfo].
  /// Month/adhika are resolved at [monthAtInstant] (day-granular spans); paksha
  /// and name derive from [tithiNum].
  TithiInfo _buildInfo(int tithiNum, DateTime monthAtInstant, String city) {
    final paksha = tithi_core.getPaksha(tithiNum);
    final name = tithi_core.getTithiName(tithiNum);
    final inPaksha = tithi_core.tithiInPaksha(tithiNum);
    final monthInfo = _resolverFor(city).getMonthInfo(monthAtInstant);
    final pakshaStr = paksha == tithi_core.Paksha.shukla ? 'Shukla' : 'Krishna';
    final adhikaPrefix = monthInfo.isAdhika ? 'Adhika ' : '';
    final display =
        '$adhikaPrefix${monthInfo.month.displayName} $pakshaStr $name';
    return TithiInfo(
      tithiNumber: tithiNum,
      tithiName: name,
      paksha: paksha,
      tithiInPaksha: inPaksha,
      month: monthInfo.month,
      isAdhika: monthInfo.isAdhika,
      displayName: display,
    );
  }
}
