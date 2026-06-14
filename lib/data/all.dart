// All-cities data pack.
//
// Importing this file and calling [registerAllCities] links and registers every
// supported city's correction tables. Apps that need the full city list (e.g.
// a global city picker) use this. Consumers that need only a region should
// import a region pack instead (e.g. package:tithi_engine/data/india.dart) so
// the tree-shaker can drop unused city data.
library;

export 'package:tithi_engine/src/regions/all_cities.g.dart' show registerAllCities;
