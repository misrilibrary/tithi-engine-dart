import 'festival_def.dart';
import 'festival_finder.dart';
import 'tithi.dart' as tithi_core;
import 'tithi_calculator.dart';

/// Primary entry point for the tithi engine.
///
/// Mirrors the Java `Panchang` API for cross-platform consistency.
///
/// ```dart
/// final panchang = Panchang([registerAllCities]);
/// final info = panchang.tithiOnDate(DateTime.utc(2026, 2, 15), 'Ujjain');
/// print(info); // "Phalguna Krishna Trayodashi"
/// ```
class Panchang {
  final MonthSystem monthSystem;
  late final TithiCalculator _calc;

  /// Construct a Panchang, registering the city data it will use.
  ///
  /// You MUST supply at least one data-pack registrar — there is no zero-arg
  /// constructor — so the cities you query have correction tables loaded:
  /// ```dart
  /// import 'package:tithi_engine/data/all.dart';
  /// final p = Panchang([registerAllCities]);
  /// // or a region pack (links only that region's data):
  /// import 'package:tithi_engine/data/india.dart';
  /// final p = Panchang([registerIndia]);
  /// ```
  /// Registrars are idempotent, so constructing repeatedly is cheap. Choosing
  /// which packs to import is also what lets the tree-shaker drop unused cities.
  Panchang(List<void Function()> data,
      {MonthSystem system = MonthSystem.purnimant})
      : monthSystem = system {
    for (final register in data) {
      register();
    }
    _calc = TithiCalculator(monthSystem: monthSystem);
  }

  /// Sunrise tithi for the panchang day of [date] at [city] (observance/display).
  ///
  /// Only [date]'s calendar fields select the day; time-of-day is ignored and no
  /// offset is needed (sunrise is astronomical). Use this for "the tithi of the
  /// day" — calendars, festival display, day observance.
  TithiInfo tithiOnDate(DateTime date, String city) =>
      _calc.tithiOnDate(date, city);

  /// Tithi active at the exact UTC [utcInstant] at [city] (birth-time precision).
  ///
  /// [utcInstant] must be a true UTC instant. [offset] is the DST-aware UTC
  /// offset in effect at that instant in [city] (resolved by the caller); it is
  /// used only to derive the civil date for correction-table selection.
  TithiInfo tithiAtInstant(DateTime utcInstant, String city,
          {required Duration offset}) =>
      _calc.tithiAtInstant(utcInstant, city, offset: offset);

  /// All tithi segments within `[windowStartUtc, windowEndUtc)` at [city]; N
  /// transitions → N+1 segments, each with its own resolved [TithiInfo] and
  /// bounding instants.
  ///
  /// For a date-only birthday, the caller frames the window as that civil day's
  /// local-midnight→midnight converted to UTC (DST-aware, so 23h/25h on a DST
  /// changeover) and supplies [offset] (the offset in effect during the window)
  /// for correction-table selection. Zero transitions → a single segment.
  List<TithiSegment> tithiSegments(
          DateTime windowStartUtc, DateTime windowEndUtc, String city,
          {required Duration offset}) =>
      _calc.tithiSegments(windowStartUtc, windowEndUtc, city, offset: offset);

  /// Tithi spec → first matching Gregorian date in the given year.
  /// Returns `null` if no match found (e.g., kshaya tithi in a given year).
  DateTime? getDate(
    LunarMonth month,
    tithi_core.Paksha paksha,
    int tithiInPaksha,
    int year,
    String city, {
    bool isAdhika = false,
  }) {
    final dates =
        getDates(month, paksha, tithiInPaksha, year, city, isAdhika: isAdhika);
    return dates.isEmpty ? null : dates.first;
  }

  /// Tithi spec → all matching Gregorian dates in the given year (adhika-aware).
  List<DateTime> getDates(
    LunarMonth month,
    tithi_core.Paksha paksha,
    int tithiInPaksha,
    int year,
    String city, {
    bool isAdhika = false,
  }) {
    final info = TithiInfo(
      tithiNumber: paksha == tithi_core.Paksha.shukla
          ? tithiInPaksha
          : tithiInPaksha + 15,
      tithiName: tithi_core.getTithiName(paksha == tithi_core.Paksha.shukla
          ? tithiInPaksha
          : tithiInPaksha + 15),
      paksha: paksha,
      tithiInPaksha: tithiInPaksha,
      month: month,
      isAdhika: isAdhika,
      displayName: '',
    );
    return _calc.findInYear(info, year, celebrationCity: city);
  }

  /// Festival → date with muhurta rules applied for the given year and city.
  /// Returns `null` if the festival doesn't occur in the given year.
  FestivalDate? dateFor(FestivalDef festival, int year, String city) {
    return findFestivalDate(festival, year, city, _calc);
  }

  /// Recurring festival (e.g. monthly Ekadashi/Purnima) → all occurrences in
  /// the given year and city, each with its tithi span.
  List<FestivalDate> recurringDates(
      FestivalDef festival, int year, String city) {
    return findRecurringDates(festival, year, city, _calc);
  }

  /// Find the next occurrence of a tithi from a given date.
  DateTime? findNext(
    LunarMonth month,
    tithi_core.Paksha paksha,
    int tithiInPaksha,
    String city, {
    DateTime? from,
  }) {
    final info = TithiInfo(
      tithiNumber: paksha == tithi_core.Paksha.shukla
          ? tithiInPaksha
          : tithiInPaksha + 15,
      tithiName: tithi_core.getTithiName(paksha == tithi_core.Paksha.shukla
          ? tithiInPaksha
          : tithiInPaksha + 15),
      paksha: paksha,
      tithiInPaksha: tithiInPaksha,
      month: month,
      isAdhika: false,
      displayName: '',
    );
    return _calc.findNext(info, from: from, celebrationCity: city);
  }
}
