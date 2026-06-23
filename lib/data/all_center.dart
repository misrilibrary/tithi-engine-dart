// centerDisc ("half disk visible") all-cities data pack.
//
// Importing this file and calling [registerAllCitiesCenterDisc] links and
// registers every city's centerDisc correction tables. Use it ALONGSIDE
// [registerAllCities] when the app exposes the runtime sunrise-convention
// toggle:
//
//   final p = Panchang([registerAllCities, registerAllCitiesCenterDisc],
//       convention: SunriseConvention.centerDisc);
//
// Pure upper-limb consumers omit this pack and pay zero size for centerDisc.
library;

export 'package:tithi_engine/src/regions/all_cities_center.g.dart'
    show registerAllCitiesCenterDisc;
