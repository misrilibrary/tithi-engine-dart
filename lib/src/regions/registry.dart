// Mutable city-correction registry.
//
// The engine ships with NO city data linked by default. Consumers register the
// cities they need so the tree-shaker can drop the rest:
//   - everything:  package:tithi_engine/data/all.dart   → registerAllCities()
//   - a region:    package:tithi_engine/data/india.dart → registerIndia()
//
// A city that is never registered resolves to empty corrections, i.e. the Meeus
// astronomical fallback (slightly less precise than the per-city Swiss-Ephemeris
// tables). Register the cities you use at startup, before calling Panchang.

import '../astronomy.dart' show SunriseConvention;
import '../cities.dart' show resolveCityName;

// Tithi / boundary corrections are convention-specific (they patch the
// sunrise-tithi, which shifts when the convention changes). They are stored in
// per-convention maps. Tithi transition *times* are an astronomical elongation
// event (geocentric, observer-independent), so they are not stored per city —
// the engine applies a single global Swiss correction (see
// transitions/global_transition_corrections.g.dart).
final Map<String, Map<int, int>> _tithi = {}; // upperLimb (default)
final Map<String, Map<int, int>> _tithiCenter = {}; // centerDisc

/// Register one city's correction tables. Invoked by the generated data packs;
/// not normally called directly.
///
/// [convention] selects which tithi table set the corrections belong to
/// (default [SunriseConvention.upperLimb]). Tithi transition times are corrected
/// globally, and new-moon/full-moon boundary DAYS are derived from the corrected
/// day-tithi — neither needs a per-city table.
void registerCity(
  String city, {
  Map<int, int>? tithi,
  SunriseConvention convention = SunriseConvention.upperLimb,
}) {
  final center = convention == SunriseConvention.centerDisc;
  if (tithi != null) (center ? _tithiCenter : _tithi)[city] = tithi;
}

/// Whether any city data has been registered (useful to detect missing setup).
bool get hasRegisteredCities => _tithi.isNotEmpty;

/// City names with registered tithi corrections.
Iterable<String> get registeredCities => _tithi.keys;

Map<int, int> getTithiCorrections(String city,
    [SunriseConvention convention = SunriseConvention.upperLimb]) {
  final key = resolveCityName(city) ?? city;
  // For centerDisc, fall back to empty (pure-Meeus) until center tables ship —
  // never apply upper-limb corrections to a center-disc sunrise.
  if (convention == SunriseConvention.centerDisc) {
    return _tithiCenter[key] ?? const {};
  }
  return _tithi[key] ?? const {};
}
