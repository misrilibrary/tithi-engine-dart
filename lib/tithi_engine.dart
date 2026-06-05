/// Accurate Vedic tithi, lunar month, and festival date calculator.
///
/// ```dart
/// import 'package:tithi_engine/tithi_engine.dart';
///
/// final panchang = Panchang(MonthSystem.purnimant);
/// final info = panchang.forDate(DateTime(2026, 2, 15), City.ujjain);
/// print(info.displayName); // "Phalguna Krishna Trayodashi"
/// ```
library;

export 'src/panchang.dart' show Panchang;
export 'src/tithi_calculator.dart' show TithiCalculator, TithiInfo;
export 'src/lunar_month.dart' show LunarMonth, MonthSystem;
export 'src/tithi.dart' show Paksha, getTithiName, getPaksha, tithiInPaksha, tithiNames, calculateTithi;
export 'src/astronomy.dart'
    show CityLocation, supportedCities, defaultCity, getLocationForCity;
export 'src/cities.dart' show City;
export 'src/festival_def.dart' show FestivalDef, MuhurtaRule, festivals;
export 'src/festival_finder.dart'
    show findFestivalDate, FestivalDate, findRecurringDates;
export 'src/month_converter.dart' show convertMonth;
