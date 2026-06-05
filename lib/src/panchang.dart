import 'festival_def.dart';
import 'festival_finder.dart';
import 'tithi.dart' as tithi_core;
import 'tithi_calculator.dart';

/// Primary entry point for the tithi engine.
///
/// Mirrors the Java `Panchang` API for cross-platform consistency.
///
/// ```dart
/// final panchang = Panchang(MonthSystem.purnimant);
/// final info = panchang.forDate(DateTime(2026, 2, 15), City.ujjain);
/// print(info); // "Phalguna Krishna Trayodashi"
/// ```
class Panchang {
  final MonthSystem monthSystem;
  late final TithiCalculator _calc;

  Panchang([this.monthSystem = MonthSystem.purnimant]) {
    _calc = TithiCalculator(monthSystem: monthSystem);
  }

  /// Gregorian date → full TithiInfo for the given city.
  TithiInfo forDate(DateTime date, String city) {
    return _calc.getTithi(date, timezone: city);
  }

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
