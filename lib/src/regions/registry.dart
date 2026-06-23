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
// per-convention maps. Transition minutes are an astronomical elongation event
// (independent of the observer's sunrise), so they are shared across both.
final Map<String, Map<int, int>> _tithi = {}; // upperLimb (default)
final Map<String, Map<int, int>> _tithiCenter = {}; // centerDisc
final Map<String, Map<int, int>> _trans = {}; // shared (convention-independent)
final Map<String, Map<int, int>> _amav = {}; // upperLimb (default)
final Map<String, Map<int, int>> _amavCenter = {}; // centerDisc
final Map<String, Map<int, int>> _purn = {}; // upperLimb (default)
final Map<String, Map<int, int>> _purnCenter = {}; // centerDisc

/// Register one city's correction tables. Invoked by the generated data packs;
/// not normally called directly.
///
/// [convention] selects which table set the tithi/amavasya/purnima corrections
/// belong to (default [SunriseConvention.upperLimb], matching today's generated
/// packs). Transition minutes are convention-independent and always shared.
void registerCity(
  String city, {
  Map<int, int>? tithi,
  Map<int, int>? transitions,
  Map<int, int>? amavasya,
  Map<int, int>? purnima,
  SunriseConvention convention = SunriseConvention.upperLimb,
}) {
  final center = convention == SunriseConvention.centerDisc;
  if (tithi != null) (center ? _tithiCenter : _tithi)[city] = tithi;
  if (transitions != null) _trans[city] = transitions;
  if (amavasya != null) (center ? _amavCenter : _amav)[city] = amavasya;
  if (purnima != null) (center ? _purnCenter : _purn)[city] = purnima;
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

Map<int, int> getTransitionMinutes(String city) =>
    _trans[resolveCityName(city) ?? city] ?? const {};

Map<int, int> getAmavasyaCorrections(String city,
    [SunriseConvention convention = SunriseConvention.upperLimb]) {
  final key = resolveCityName(city) ?? city;
  if (convention == SunriseConvention.centerDisc) {
    return _amavCenter[key] ?? const {};
  }
  return _amav[key] ?? const {};
}

Map<int, int> getPurnimaCorrections(String city,
    [SunriseConvention convention = SunriseConvention.upperLimb]) {
  final key = resolveCityName(city) ?? city;
  if (convention == SunriseConvention.centerDisc) {
    return _purnCenter[key] ?? const {};
  }
  return _purn[key] ?? const {};
}
