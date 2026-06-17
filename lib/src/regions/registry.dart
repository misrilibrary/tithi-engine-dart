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

final Map<String, Map<int, int>> _tithi = {};
final Map<String, Map<int, int>> _trans = {};
final Map<String, Map<int, int>> _amav = {};
final Map<String, Map<int, int>> _purn = {};

/// Register one city's correction tables. Invoked by the generated data packs;
/// not normally called directly.
void registerCity(
  String city, {
  Map<int, int>? tithi,
  Map<int, int>? transitions,
  Map<int, int>? amavasya,
  Map<int, int>? purnima,
}) {
  if (tithi != null) _tithi[city] = tithi;
  if (transitions != null) _trans[city] = transitions;
  if (amavasya != null) _amav[city] = amavasya;
  if (purnima != null) _purn[city] = purnima;
}

/// Whether any city data has been registered (useful to detect missing setup).
bool get hasRegisteredCities => _tithi.isNotEmpty;

/// City names with registered tithi corrections.
Iterable<String> get registeredCities => _tithi.keys;

Map<int, int> getTithiCorrections(String city) => _tithi[city] ?? const {};
Map<int, int> getTransitionMinutes(String city) => _trans[city] ?? const {};
Map<int, int> getAmavasyaCorrections(String city) => _amav[city] ?? const {};
Map<int, int> getPurnimaCorrections(String city) => _purn[city] ?? const {};
