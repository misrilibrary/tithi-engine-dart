import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

void main() {
  final panchang = Panchang([registerAllCities]);
  print(panchang.tithiOnDate(DateTime(2026, 2, 15), 'Ujjain').displayName);
}
