/// Accurate Vedic tithi, lunar month, and festival date calculator.
///
/// The public surface mirrors the Java `tithi-engine` library: a single
/// entry point ([Panchang]) plus immutable value types. The astronomy engine,
/// tithi-number utilities, month converter, and festival-finder functions are
/// internal (`src/`) and intentionally not exported — drive everything through
/// [Panchang].
///
/// ```dart
/// import 'package:tithi_engine/tithi_engine.dart';
///
/// final panchang = Panchang(MonthSystem.purnimant);
/// final info = panchang.forDate(DateTime(2026, 2, 15), City.ujjain);
/// print(info.displayName); // "Phalguna Krishna Trayodashi"
///
/// final diwali = panchang.dateFor(festivals.firstWhere((f) => f.id == 'diwali'),
///     2026, City.seattle);
/// ```
library;

// ── Single public entry point ────────────────────────────────────────────
export 'src/panchang.dart' show Panchang;

// ── Value types (the "model") ────────────────────────────────────────────
export 'src/tithi_calculator.dart' show TithiInfo;
export 'src/lunar_month.dart' show LunarMonth, MonthSystem;
export 'src/tithi.dart' show Paksha, tithiNames;
export 'src/festival_def.dart' show FestivalDef, MuhurtaRule, festivals;
export 'src/festival_finder.dart' show FestivalDate;

// ── City registry / location data ────────────────────────────────────────
export 'src/cities.dart' show City;
export 'src/astronomy.dart'
    show CityLocation, supportedCities, defaultCity, getLocationForCity;

// NOTE (Phase 1 of the engine refactor): the following were previously
// exported and are now internal. Use [Panchang] / the model types instead:
//   - TithiCalculator            → use Panchang
//   - getTithiName/getPaksha/tithiInPaksha/calculateTithi
//                                → read TithiInfo fields, or TithiInfo.fromStored(...)
//   - convertMonth               → TithiInfo.fromStored(..., displaySystem:)
//   - findFestivalDate           → Panchang.dateFor
//   - findRecurringDates         → Panchang.recurringDates
//   - TithiCalculator.findTransitionTime → Panchang.transitionTime
