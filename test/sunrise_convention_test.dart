import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

void main() {
  final d = DateTime.utc(2026, 6, 22);

  group('SunriseConvention enum', () {
    test('altitude constants match the documented horizon depressions', () {
      // Upper limb = 34' refraction + 16' semidiameter = 50' = 0.833°.
      expect(SunriseConvention.upperLimb.horizonAltitudeDeg, -0.833);
      // Center of disk = refraction only = 34' = 0.5667°.
      expect(SunriseConvention.centerDisc.horizonAltitudeDeg, -0.5667);
    });

    test('default is upper limb', () {
      final p = Panchang([registerAllCities]);
      expect(p.convention, SunriseConvention.upperLimb);
    });
  });

  group('backwards compatibility', () {
    // Omitting the convention must reproduce the explicit upper-limb path
    // exactly (the original behavior).
    final implicit = Panchang([registerAllCities]);
    final explicitUpper =
        Panchang([registerAllCities], convention: SunriseConvention.upperLimb);

    for (final city in ['New York', 'Ujjain', 'London', 'Tokyo', 'Sydney']) {
      test('$city sunrise/sunset identical when convention omitted', () {
        expect(implicit.sunrise(d, city), explicitUpper.sunrise(d, city));
        expect(implicit.sunset(d, city), explicitUpper.sunset(d, city));
      });

      test('$city tithiOnDate identical when convention omitted', () {
        expect(implicit.tithiOnDate(d, city).displayName,
            explicitUpper.tithiOnDate(d, city).displayName);
      });
    }

    test('festival date unchanged when convention omitted (Diwali 2026)', () {
      final diwali = festivals.firstWhere((f) => f.id == 'diwali');
      expect(implicit.dateFor(diwali, 2026, 'Ujjain')?.date,
          explicitUpper.dateFor(diwali, 2026, 'Ujjain')?.date);
    });
  });

  group('centerDisc convention shifts sun times in the right direction', () {
    final upper =
        Panchang([registerAllCities], convention: SunriseConvention.upperLimb);
    final center =
        Panchang([registerAllCities], convention: SunriseConvention.centerDisc);

    for (final city in ['New York', 'London', 'Ujjain', 'Tokyo']) {
      test('$city: centerDisc sunrise later, sunset earlier', () {
        final upSr = upper.sunrise(d, city);
        final ctSr = center.sunrise(d, city);
        final upSs = upper.sunset(d, city);
        final ctSs = center.sunset(d, city);

        // Center of disk sits ~16' higher than the upper limb, so the sun
        // reaches it later in the morning and earlier in the evening.
        expect(ctSr.isAfter(upSr), isTrue,
            reason: 'centerDisc sunrise should be later');
        expect(ctSs.isBefore(upSs), isTrue,
            reason: 'centerDisc sunset should be earlier');

        // The shift is one semidiameter of altitude — a few minutes, never huge.
        final srDelta = ctSr.difference(upSr).inMinutes;
        final ssDelta = upSs.difference(ctSs).inMinutes;
        expect(srDelta, inInclusiveRange(1, 15));
        expect(ssDelta, inInclusiveRange(1, 15));
      });
    }

    test('centerDisc tithiOnDate still returns a valid tithi (Meeus fallback)',
        () {
      final info = center.tithiOnDate(d, 'Ujjain');
      expect(info.tithiNumber, inInclusiveRange(1, 30));
      expect(info.displayName, isNotEmpty);
    });

    test('centerDisc tithiAtInstant does not crash and is in range', () {
      final info = center.tithiAtInstant(
          DateTime.utc(2026, 6, 22, 3, 30), 'Ujjain',
          offset: const Duration(hours: 5, minutes: 30));
      expect(info.tithiNumber, inInclusiveRange(1, 30));
    });
  });
}
