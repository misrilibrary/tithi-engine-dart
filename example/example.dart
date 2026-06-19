import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

void main() {
  // Supply a city-data pack at construction (registerAllCities links every
  // city; a region pack like registerIndia links only that region).
  final panchang = Panchang([registerAllCities], system: MonthSystem.purnimant);

  // Date → Tithi
  final info = panchang.tithiOnDate(DateTime(2026, 2, 15), City.ujjain);
  print(info.displayName); // "Phalguna Krishna Trayodashi"

  // Festival date
  final shivaratri = panchang.dateFor(
      festivals.firstWhere((f) => f.name == 'Maha Shivaratri'),
      2026,
      City.ujjain);
  print('Maha Shivaratri 2026: ${shivaratri?.date}');

  // Tithi → Date
  final date = panchang.getDate(
      LunarMonth.bhadrapada, Paksha.krishna, 8, 2026, City.seattle);
  print('Janmashtami 2026 Seattle: $date');
}
