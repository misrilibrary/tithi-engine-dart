import 'package:tithi_engine/tithi_engine.dart';

void main() {
  final panchang = Panchang(MonthSystem.purnimant);

  // Date → Tithi
  final info = panchang.forDate(DateTime(2026, 2, 15), City.ujjain);
  print(info.displayName); // "Phalguna Krishna Trayodashi"

  // Festival date
  final shivaratri = panchang.dateFor(festivals.firstWhere((f) => f.name == 'Maha Shivaratri'), 2026, City.ujjain);
  print('Maha Shivaratri 2026: ${shivaratri?.date}');

  // Tithi → Date
  final date = panchang.getDate(LunarMonth.bhadrapada, Paksha.krishna, 8, 2026, City.seattle);
  print('Janmashtami 2026 Seattle: $date');
}
