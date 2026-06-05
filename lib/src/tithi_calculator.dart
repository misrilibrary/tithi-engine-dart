import 'astronomy.dart';
import 'ayanamsha.dart';
import 'finder.dart';
import 'lunar_month.dart';
import 'lunar_month_resolver.dart';
import 'regions/corrections_registry.dart';
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

  @override
  String toString() => displayName;
}

/// Pure Dart tithi calculator. No external dependencies.
class TithiCalculator {
  final MonthSystem monthSystem;
  late final LunarMonthResolver _monthResolver;

  TithiCalculator({this.monthSystem = MonthSystem.purnimant}) {
    _monthResolver = LunarMonthResolver(system: monthSystem);
  }

  /// Convert a Gregorian date to its Hindu lunar tithi.
  /// Uses precomputed corrections (1900-2100) when available, Meeus fallback otherwise.
  ///
  /// If time is provided, calculates tithi at that exact moment.
  /// If date-only (hour=0, minute=0), uses sunrise tithi for the given timezone.
  /// If [utcOffset] is provided, converts to UTC for accurate calculation.
  /// If [timezone] is provided (IANA name), uses location-appropriate sunrise.
  TithiInfo getTithi(DateTime date, {Duration? utcOffset, String? timezone}) {
    final hasTime = date.hour != 0 || date.minute != 0;
    final dayIndex = date.difference(_indiaEpoch).inDays;
    final city = timezone ?? defaultCity;
    final tithiCorr = getTithiCorrections(city);
    final transCorr = getTransitionMinutes(city);

    // Compute tithi number: check corrections first, Meeus fallback
    final int tithiNum;
    if (!hasTime) {
      tithiNum =
          tithiCorr[dayIndex] ?? _meeusCalcTithi(date, null, false, city);
    } else {
      final transMinute = transCorr[dayIndex];
      if (transMinute != null) {
        final userIstMinutes = _toLocalMinutes(date, utcOffset, city);
        final sunriseTithi = tithiCorr[dayIndex]!;
        tithiNum = userIstMinutes >= transMinute
            ? sunriseTithi
            : (sunriseTithi - 1 == 0 ? 30 : sunriseTithi - 1);
      } else {
        tithiNum = _meeusCalcTithi(date, utcOffset, true, city);
      }
    }
    final paksha = tithi_core.getPaksha(tithiNum);
    final name = tithi_core.getTithiName(tithiNum);
    final inPaksha = tithi_core.tithiInPaksha(tithiNum);
    final resolver = city == defaultCity
        ? _monthResolver
        : LunarMonthResolver(system: monthSystem, city: city);
    final monthInfo = resolver.getMonthInfo(date);

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

  /// Find when a tithi falls in a given year. Returns all occurrences (usually 1, sometimes 2).
  /// Find when a tithi falls in a given year for a celebration city.
  List<DateTime> findInYear(TithiInfo info, int year,
      {String? celebrationCity}) {
    final city = celebrationCity ?? defaultCity;
    final resolver = city == defaultCity
        ? _monthResolver
        : LunarMonthResolver(system: monthSystem, city: city);
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
    final resolver = city == defaultCity
        ? _monthResolver
        : LunarMonthResolver(system: monthSystem, city: city);
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

  /// Approximate reference (Ujjain) sunrise as UTC DateTime.
  static DateTime _refSunrise(DateTime date) => defaultSunrise(date);

  /// Find the transition time between two adjacent tithis on a given date.
  /// Returns the UTC DateTime when tithi changes from [fromTithi] to [toTithi],
  /// or null if the transition doesn't occur on that day.
  /// Binary search: ~11 iterations for 1-minute precision.
  static DateTime? findTransitionTime(DateTime date, {Duration? utcOffset}) {
    // Search window: sunrise to next sunrise (~24h)
    final sunrise = _refSunrise(date);
    final nextSunrise = _refSunrise(date.add(const Duration(days: 1)));

    final startTithi = _tithiAt(sunrise);
    final endTithi = _tithiAt(nextSunrise);

    if (startTithi == endTithi) return null; // no transition this day

    // Binary search for the transition point
    var lo = sunrise;
    var hi = nextSunrise;
    while (hi.difference(lo).inMinutes > 1) {
      final mid = lo.add(Duration(minutes: hi.difference(lo).inMinutes ~/ 2));
      if (_tithiAt(mid) == startTithi) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    return hi; // moment when new tithi begins (UTC)
  }

  static int _tithiAt(DateTime utcTime) {
    final sunLong = toSidereal(sunLongitude(utcTime), utcTime);
    final moonLong = toSidereal(moonLongitude(utcTime), utcTime);
    return tithi_core.calculateTithi(moonLong, sunLong);
  }

  // ─── India precomputed data helpers ───

  static final _indiaEpoch = DateTime.utc(1900, 1, 1);

  static int _toLocalMinutes(DateTime date, Duration? utcOffset, String city) {
    final cityOffset = getLocationForCity(city).utcOffset;
    final cityOffsetMinutes = (cityOffset * 60).round();
    // Convert user's time to UTC minutes, then to city local minutes
    final utcMinutes = date.hour * 60 +
        date.minute -
        (utcOffset?.inMinutes ?? cityOffsetMinutes);
    final localMinutes = utcMinutes + cityOffsetMinutes;
    return localMinutes % 1440;
  }

  static int _meeusCalcTithi(DateTime date, Duration? utcOffset, bool hasTime,
      [String? timezone]) {
    DateTime calcTime;
    if (hasTime && utcOffset != null) {
      calcTime =
          DateTime.utc(date.year, date.month, date.day, date.hour, date.minute)
              .subtract(utcOffset);
    } else if (hasTime) {
      // Time provided, use timezone offset or default IST
      final loc = getLocationForCity(timezone ?? "Delhi");
      final offset = Duration(minutes: (loc.utcOffset * 60).round());
      calcTime =
          DateTime.utc(date.year, date.month, date.day, date.hour, date.minute)
              .subtract(offset);
    } else {
      // Date-only: use sunrise for the timezone
      final loc = getLocationForCity(timezone ?? "Delhi");
      calcTime = computeSunrise(date, loc);
    }
    final sunLong = toSidereal(sunLongitude(calcTime), calcTime);
    final moonLong = toSidereal(moonLongitude(calcTime), calcTime);
    return tithi_core.calculateTithi(moonLong, sunLong);
  }
}
