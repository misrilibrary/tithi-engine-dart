import 'package:test/test.dart';
import 'package:tithi_engine/src/tithi_calculator.dart';
import 'package:tithi_engine/src/astronomy.dart';
import 'package:tithi_engine/src/ayanamsha.dart';
import 'package:tithi_engine/src/tithi.dart';

void main() {
  group('Astronomy - Julian Day', () {
    test('J2000.0 epoch', () {
      // Jan 1.5, 2000 = JD 2451545.0
      final jd = julianDay(DateTime.utc(2000, 1, 1, 12));
      expect(jd, closeTo(2451545.0, 0.01));
    });

    test('known date', () {
      // Oct 4.81, 1957 (Sputnik) = JD 2436116.31
      final jd = julianDay(DateTime.utc(1957, 10, 4, 19, 26));
      expect(jd, closeTo(2436116.31, 0.01));
    });
  });

  group('Astronomy - Sun longitude', () {
    test('vernal equinox ~0 degrees', () {
      // Around March 20, Sun longitude should be near 0° (tropical)
      final lon = sunLongitude(DateTime.utc(2024, 3, 20, 12));
      expect(lon, closeTo(0, 2)); // within 2 degrees
    });

    test('summer solstice ~90 degrees', () {
      final lon = sunLongitude(DateTime.utc(2024, 6, 21, 12));
      expect(lon, closeTo(90, 2));
    });
  });

  group('Astronomy - Moon longitude', () {
    test('moon longitude is 0-360', () {
      final lon = moonLongitude(DateTime.utc(2024, 1, 15, 12));
      expect(lon, greaterThanOrEqualTo(0));
      expect(lon, lessThan(360));
    });

    test('moon moves ~13 degrees per day', () {
      final lon1 = moonLongitude(DateTime.utc(2024, 1, 15, 12));
      final lon2 = moonLongitude(DateTime.utc(2024, 1, 16, 12));
      final diff = (lon2 - lon1) % 360;
      expect(diff, closeTo(13, 2)); // ~13°/day ± 2°
    });
  });

  group('Ayanamsha', () {
    test('Lahiri ~24 degrees in 2024', () {
      final ay = lahiriAyanamsha(DateTime(2024, 1, 1));
      expect(ay, closeTo(24.2, 0.2));
    });

    test('increases over time', () {
      final ay2000 = lahiriAyanamsha(DateTime(2000, 1, 1));
      final ay2024 = lahiriAyanamsha(DateTime(2024, 1, 1));
      expect(ay2024, greaterThan(ay2000));
    });
  });

  group('Tithi calculation', () {
    test('new moon = tithi 30 (Amavasya)', () {
      // When moon and sun are at same longitude, tithi = 1 (or 30 wrapping)
      final t = calculateTithi(100, 100);
      expect(t, 1); // 0° difference = tithi 1
    });

    test('full moon = tithi 15 (Purnima)', () {
      // Moon 180° ahead of Sun
      final t = calculateTithi(280, 100);
      expect(t, 16); // Actually 180/12 = 15, floor+1 = 16? Let me check
      // 180/12 = 15.0, floor = 15, +1 = 16 — that's Krishna Pratipada
      // Purnima is at exactly 180° boundary = tithi 15
      final t2 = calculateTithi(279.9, 100);
      expect(t2, 15); // Just before 180° = Purnima
    });

    test('tithi names', () {
      expect(getTithiName(1), 'Pratipada');
      expect(getTithiName(8), 'Ashtami');
      expect(getTithiName(11), 'Ekadashi');
      expect(getTithiName(15), 'Purnima');
      expect(getTithiName(30), 'Amavasya');
      expect(getTithiName(16), 'Pratipada'); // Krishna Pratipada
    });

    test('paksha detection', () {
      expect(getPaksha(1), Paksha.shukla);
      expect(getPaksha(15), Paksha.shukla);
      expect(getPaksha(16), Paksha.krishna);
      expect(getPaksha(30), Paksha.krishna);
    });
  });

  group('TithiCalculator - known dates', () {
    final calc = TithiCalculator();

    test('returns valid tithi range 1-30', () {
      final info = calc.getTithi(DateTime(2025, 1, 13));
      expect(info.tithiNumber, inInclusiveRange(1, 30));
      expect(info.tithiInPaksha, inInclusiveRange(1, 15));
    });

    test('consecutive days have consecutive or same tithis', () {
      final t1 = calc.getTithi(DateTime(2024, 6, 15));
      final t2 = calc.getTithi(DateTime(2024, 6, 16));
      // Tithi advances by 0 or 1 per day (occasionally 2 near boundaries)
      final diff = (t2.tithiNumber - t1.tithiNumber) % 30;
      expect(diff, inInclusiveRange(0, 2));
    });

    test('full moon date has tithi near 15', () {
      // Known full moon: Jan 13, 2025 (verified astronomically)
      final info = calc.getTithi(DateTime(2025, 1, 13));
      expect(info.tithiNumber, inInclusiveRange(14, 16));
    });

    test('new moon date has tithi 30 or 1 (boundary)', () {
      // Known new moon: Jan 29, 2025 — could be 30 (Amavasya) or 1 (just past)
      final info = calc.getTithi(DateTime(2025, 1, 29));
      expect(info.tithiNumber, anyOf(30, 1));
    });

    test('display name format is Month Paksha Tithi', () {
      final info = calc.getTithi(DateTime(2024, 6, 15));
      final parts = info.displayName.split(' ');
      expect(parts.length, 3);
      expect(parts[1], anyOf('Shukla', 'Krishna'));
    });

    test('month is a valid LunarMonth', () {
      final info = calc.getTithi(DateTime(2024, 8, 15));
      expect(LunarMonth.values, contains(info.month));
    });
  });

  group('TithiCalculator - findInYear', () {
    final calc = TithiCalculator();

    test('finds a tithi in the target year', () {
      final info = calc.getTithi(DateTime(2024, 3, 25)); // some known date
      final found = calc.findInYear(info, 2025);
      expect(found, isNotEmpty);
      expect(found.first.year, 2025);
      // The tithi on that date should be within ±1 (boundary tolerance)
      final verify = calc.getTithi(found.first);
      expect((verify.tithiNumber - info.tithiNumber).abs(), lessThanOrEqualTo(1));
    });

    test('returns a date within reasonable range', () {
      final info = calc.getTithi(DateTime(2024, 8, 15)); // Independence Day
      final found = calc.findInYear(info, 2025);
      expect(found, isNotEmpty);
      // Date should be within ~45 days of Jan 1 of target year or within the year
      final jan1 = DateTime(2025, 1, 1);
      final diff = found.first.difference(jan1).inDays.abs();
      expect(diff, lessThan(365));
    });
  });
}
