import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';

/// Regression tests for kshaya tithi detection (tithi skipped at sunrise).
/// When a tithi is kshaya, findInYear should return the previous day
/// (the last day the preceding tithi was present at sunrise).
void main() {
  final calc = TithiCalculator(monthSystem: MonthSystem.purnimant);

  TithiInfo _info(int tithiNumber, LunarMonth month) {
    final paksha = tithiNumber <= 15 ? Paksha.shukla : Paksha.krishna;
    final inPaksha = tithiNumber <= 15 ? tithiNumber : tithiNumber - 15;
    return TithiInfo(
      tithiNumber: tithiNumber,
      tithiName: getTithiName(tithiNumber),
      paksha: paksha,
      tithiInPaksha: inPaksha,
      month: month,
      isAdhika: false,
      displayName: '',
    );
  }

  group('Kshaya at 30→1 wraparound (Shukla Pratipada)', () {
    test('Chaitra S1 2026 kshaya → returns Mar 19 (Amavasya day)', () {
      final dates = calc.findInYear(_info(1, LunarMonth.chaitra), 2026);
      expect(dates, isNotEmpty, reason: 'Kshaya tithi should still return a date');
      expect(dates.first, DateTime.utc(2026, 3, 19));
    });

    test('Jyeshtha S1 2025 kshaya → returns May 27 (Amavasya day)', () {
      final dates = calc.findInYear(_info(1, LunarMonth.jyeshtha), 2025);
      expect(dates, isNotEmpty, reason: 'Kshaya tithi should still return a date');
      expect(dates.first, DateTime.utc(2025, 5, 27));
    });
  });

  group('Kshaya at span start (K1 at Purnimant boundary)', () {
    test('Kartika K1 2025 kshaya → returns a date', () {
      final dates = calc.findInYear(_info(16, LunarMonth.kartika), 2025);
      expect(dates, isNotEmpty, reason: 'Kshaya K1 at span start should return a date');
    });
  });

  group('Non-kshaya tithis still work (no regression)', () {
    test('Chaitra S5 2026 (normal) returns a date', () {
      final dates = calc.findInYear(_info(5, LunarMonth.chaitra), 2026);
      expect(dates, isNotEmpty);
    });

    test('Kartika K8 2025 (normal) returns a date', () {
      final dates = calc.findInYear(_info(23, LunarMonth.kartika), 2025);
      expect(dates, isNotEmpty);
    });

    test('Vriddhi: Margashirsha S1 2026 returns second day (Dec 10)', () {
      final dates = calc.findInYear(_info(1, LunarMonth.margashirsha), 2026);
      expect(dates, contains(DateTime.utc(2026, 12, 10)));
    });
  });
}
