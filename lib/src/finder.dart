import 'astronomy.dart';
import 'ayanamsha.dart';
import 'lunar_month.dart';
import 'lunar_month_resolver.dart';
import 'tithi.dart';

/// A raw tithi match with its span context.
class TithiMatch {
  final DateTime date;
  final MonthSpan span;
  TithiMatch(this.date, this.span);
}

/// Find ALL raw matches for a tithi+month in a given year.
/// Returns unfiltered results with span context for downstream filtering.
List<TithiMatch> findTithiRaw({
  required LunarMonth month,
  required Paksha paksha,
  required int tithiInPakshaNum,
  required int year,
  required LunarMonthResolver resolver,
  bool isAdhika = false,
  SunriseFn? sunriseFn,
}) {
  final targetTithi =
      paksha == Paksha.shukla ? tithiInPakshaNum : tithiInPakshaNum + 15;
  final sunrise = sunriseFn ?? _defaultSunrise;
  final spans = resolver.getSpansForYear(year);
  // Also include previous year's spans (for months straddling year boundary)
  final prevSpans = resolver.getSpansForYear(year - 1);
  final allMatchingSpans = <MonthSpan>[
    ...spans.where((s) => s.month == month),
    ...prevSpans.where((s) => s.month == month),
  ];
  // Deduplicate by start date
  final seen = <String>{};
  final matchingSpans =
      allMatchingSpans.where((s) => seen.add(s.start.toString())).toList();

  final results = <TithiMatch>[];
  for (final span in matchingSpans) {
    // "Tithi ends on date" rule:
    // - If target tithi is present: pick the LAST day it appears (handles double tithi)
    // - If target tithi is skipped (kshaya): pick the day before the higher tithi
    DateTime? lastSeen;
    int? prevTithi;
    for (var dt = span.start;
        dt.isBefore(span.end);
        dt = dt.add(const Duration(days: 1))) {
      final sr = sunrise(dt);
      final sunLong = toSidereal(sunLongitude(sr), sr);
      final moonLong = toSidereal(moonLongitude(sr), sr);
      final currentTithi = calculateTithi(moonLong, sunLong);

      if (currentTithi == targetTithi) {
        lastSeen = dt; // keep updating — last one wins
      } else if (lastSeen != null) {
        // Target tithi ended on lastSeen
        break;
      } else if (prevTithi != null &&
          prevTithi < targetTithi &&
          currentTithi > targetTithi) {
        // Kshaya: tithi was skipped, it ended on previous day
        lastSeen = dt.subtract(const Duration(days: 1));
        break;
      }
      prevTithi = currentTithi;
    }
    if (lastSeen != null) {
      results.add(TithiMatch(lastSeen, span));
    }
  }
  return results;
}

// ─── Filter functions (composable, applied in sequence) ───

/// Remove the far-off span for year-boundary months.
/// Only discards matches from a different year when the same month also
/// appears in the target year. Keeps both adhika and nij spans for filterAdhikaMasa.
List<TithiMatch> filterDiscardFarSpan(List<TithiMatch> matches, int year) {
  if (matches.length <= 1) return matches;

  // Keep matches whose date falls in the target year (Dec prev → Dec current)
  final earliest = DateTime.utc(year - 1, 12, 1);
  final latest = DateTime.utc(year + 1, 1, 1);
  final inYear = matches
      .where((m) => !m.date.isBefore(earliest) && m.date.isBefore(latest))
      .toList();

  // If we have both in-year and out-of-year matches, prefer in-year
  if (inYear.isNotEmpty && inYear.length < matches.length) {
    return inYear;
  }

  // If all are in-year (adhika + nij), keep all — filterAdhikaMasa will choose
  // If all are out-of-year, pick closest to expected center
  if (inYear.isEmpty) {
    final month = matches.first.span.month;
    final expectedCenter = DateTime.utc(year, _expectedMonth(month), 15);
    final sorted = [...matches]..sort((a, b) => a.date
        .difference(expectedCenter)
        .inDays
        .abs()
        .compareTo(b.date.difference(expectedCenter).inDays.abs()));
    return [sorted.first];
  }

  return matches;
}

/// Expected Gregorian month center for each lunar month in a given year.
/// Returns month number (1-12) representing when this lunar month typically falls.
int _expectedMonth(LunarMonth month) {
  switch (month) {
    case LunarMonth.chaitra:
      return 4; // Mar-Apr → center Apr
    case LunarMonth.vaishakha:
      return 5; // Apr-May → center May
    case LunarMonth.jyeshtha:
      return 6; // May-Jun → center Jun
    case LunarMonth.ashadha:
      return 7; // Jun-Jul → center Jul
    case LunarMonth.shravana:
      return 8; // Jul-Aug → center Aug
    case LunarMonth.bhadrapada:
      return 9; // Aug-Sep → center Sep
    case LunarMonth.ashvina:
      return 10; // Sep-Oct → center Oct
    case LunarMonth.kartika:
      return 11; // Oct-Nov → center Nov
    case LunarMonth.margashirsha:
      return 12; // Nov-Dec → center Dec
    case LunarMonth.pausha:
      return 1; // Dec-Jan → center Jan
    case LunarMonth.magha:
      return 2; // Jan-Feb → center Feb
    case LunarMonth.phalguna:
      return 3; // Feb-Mar → center Mar
  }
}

/// Apply adhika/nij preference.
/// If isAdhika=true, prefer adhika span match; otherwise prefer nij.
/// Falls back to whatever is available.
List<TithiMatch> filterAdhikaMasa(List<TithiMatch> matches, bool isAdhika) {
  if (matches.length <= 1) return matches;

  final preferred = matches.where((m) => m.span.isAdhika == isAdhika).toList();
  if (preferred.isNotEmpty) return preferred;

  // Fallback: return nij if adhika not found, or vice versa
  return matches;
}

// ─── Public API (backward compatible) ───

/// Find when a tithi falls in a given year, with all filters applied.
List<DateTime> findTithiInYear({
  required LunarMonth month,
  required Paksha paksha,
  required int tithiInPakshaNum,
  required int year,
  required LunarMonthResolver resolver,
  MonthSystem system = MonthSystem.purnimant,
  bool isAdhika = false,
  SunriseFn? sunriseFn,
}) {
  var matches = findTithiRaw(
    month: month,
    paksha: paksha,
    tithiInPakshaNum: tithiInPakshaNum,
    year: year,
    resolver: resolver,
    isAdhika: isAdhika,
    sunriseFn: sunriseFn,
  );

  // Apply filters in order
  matches = filterDiscardFarSpan(matches, year);
  matches = filterAdhikaMasa(matches, isAdhika);

  // Year boundary filter: only return dates from Dec 1 (year-1) through Dec 31 (year).
  // Reject any date in year+1 or later — it belongs to the next year's query.
  final earliest = DateTime.utc(year - 1, 12, 1);
  final latest = DateTime.utc(year + 1, 1, 1);
  return matches
      .map((m) => m.date)
      .where((d) => !d.isBefore(earliest) && d.isBefore(latest))
      .toList();
}

/// Find the next occurrence of a tithi from a given date.
DateTime? findNextOccurrence({
  required LunarMonth month,
  required Paksha paksha,
  required int tithiInPakshaNum,
  required LunarMonthResolver resolver,
  DateTime? from,
  MonthSystem system = MonthSystem.purnimant,
  SunriseFn? sunriseFn,
}) {
  final start = from ?? DateTime.now();
  final targetTithi =
      paksha == Paksha.shukla ? tithiInPakshaNum : tithiInPakshaNum + 15;
  final sunrise = sunriseFn ?? _defaultSunrise;

  for (var i = 0; i < 400; i++) {
    final dt = start.add(Duration(days: i));
    final sr = sunrise(dt);
    final sunLong = toSidereal(sunLongitude(sr), sr);
    final moonLong = toSidereal(moonLongitude(sr), sr);
    final currentTithi = calculateTithi(moonLong, sunLong);
    final currentMonth = resolver.getMonth(dt);

    if (currentTithi == targetTithi && currentMonth == month) {
      return dt;
    }
  }
  return null;
}

DateTime _defaultSunrise(DateTime date) {
  return defaultSunrise(date);
}
