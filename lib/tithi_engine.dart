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
/// import 'package:tithi_engine/data/all.dart';
///
/// final panchang = Panchang([registerAllCities]);
/// final info = panchang.tithiOnDate(DateTime.utc(2026, 2, 15), 'Ujjain');
/// print(info.displayName); // "Phalguna Krishna Trayodashi"
///
/// final diwali = panchang.dateFor(festivals.firstWhere((f) => f.id == 'diwali'),
///     2026, 'Seattle');
/// ```
library;

// ── Single public entry point ────────────────────────────────────────────
export 'src/panchang.dart' show Panchang;

// ── Value types (the "model") ────────────────────────────────────────────
export 'src/tithi_calculator.dart' show TithiInfo, TithiSegment;
export 'src/lunar_month.dart' show LunarMonth, MonthSystem;
export 'src/tithi.dart' show Paksha, tithiNames;
export 'src/festival_def.dart' show FestivalDef, MuhurtaRule, festivals;
export 'src/festival_finder.dart' show FestivalDate;

// ── City registry / location data ────────────────────────────────────────
export 'src/cities.dart' show City;
export 'src/astronomy.dart'
    show CityLocation, supportedCities, defaultCity, getLocationForCity;

// NOTE (3.0): the time-aware API is UTC-instant based. The caller resolves the
// DST-correct offset and passes UTC instants; the library does no timezone work.
//   - forDate(wallClock, city, {utcOffset})  → tithiOnDate(date, city)         [sunrise/observance]
//                                            → tithiAtInstant(utcInstant, city, {offset})  [birth-time]
//   - transitionTime(date, {utcOffset})      → tithiSegments(windowStartUtc, windowEndUtc, city, {offset})
//                                              (enumerates ALL transitions, not just one)
// Engine internals remain unexported — drive everything through [Panchang].
