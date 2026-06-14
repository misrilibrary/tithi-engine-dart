// Behavior-focused unit tests for public API paths the golden/regression suites
// don't directly exercise: the Panchang facade methods (getDate/findNext/
// transitionTime/forDate-with-time), TithiInfo.fromStored display rendering,
// the Meeus fallback (out-of-table years), the mutable registry contract, and
// lunar-month naming. Assertions are relative/contractual to avoid brittleness.

import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';
import 'package:tithi_engine/src/regions/registry.dart';
import 'package:tithi_engine/src/lunar_month.dart' show getLunarMonth;

void main() {
  setUpAll(registerAllCities);

  group('Panchang.getDate vs getDates', () {
    final p = Panchang([registerAllCities]);

    test('getDate returns the first of getDates (non-empty case)', () {
      const month = LunarMonth.chaitra;
      final all = p.getDates(month, Paksha.shukla, 5, 2026, 'Ujjain');
      final one = p.getDate(month, Paksha.shukla, 5, 2026, 'Ujjain');
      expect(all, isNotEmpty);
      expect(one, isNotNull);
      expect(one, all.first);
    });

    test('resolved getDate actually lands on the requested tithi', () {
      final d = p.getDate(LunarMonth.kartika, Paksha.shukla, 15, 2026, 'Ujjain');
      expect(d, isNotNull);
      final info = p.forDate(d!, 'Ujjain');
      expect(info.tithiInPaksha, 15);
      expect(info.paksha, Paksha.shukla);
    });
  });

  group('Panchang.findNext', () {
    final p = Panchang([registerAllCities]);

    test('finds an occurrence on/after `from` matching the spec', () {
      final from = DateTime.utc(2026, 1, 1);
      final next = p.findNext(LunarMonth.magha, Paksha.shukla, 5, 'Ujjain', from: from);
      expect(next, isNotNull);
      expect(next!.isBefore(from), isFalse);
      final info = p.forDate(next, 'Ujjain');
      expect(info.tithiInPaksha, 5);
      expect(info.paksha, Paksha.shukla);
    });
  });

  group('Panchang.transitionTime', () {
    final p = Panchang([registerAllCities]);

    test('most days have a tithi transition in the sunrise→next-sunrise window', () {
      var withTransition = 0;
      for (var d = DateTime.utc(2026, 1, 1); d.month == 1; d = d.add(const Duration(days: 1))) {
        if (p.transitionTime(d) != null) withTransition++;
      }
      // A tithi lasts ~24h, so nearly every day has exactly one transition.
      expect(withTransition, greaterThanOrEqualTo(25));
    });

    test('a returned transition lies within the day window', () {
      final day = DateTime.utc(2026, 2, 15);
      final t = p.transitionTime(day);
      if (t != null) {
        expect(t.isAfter(day.subtract(const Duration(days: 1))), isTrue);
        expect(t.isBefore(day.add(const Duration(days: 2))), isTrue);
      }
    });
  });

  group('Panchang.forDate with time-of-day (utcOffset path)', () {
    final p = Panchang([registerAllCities]);
    final offset = Duration(minutes: (getLocationForCity('Delhi').utcOffset * 60).round());

    test('time-of-day query returns a valid tithi and full display', () {
      final morning = p.forDate(DateTime(2026, 5, 11, 7), 'Delhi', utcOffset: offset);
      final evening = p.forDate(DateTime(2026, 5, 11, 23), 'Delhi', utcOffset: offset);
      for (final info in [morning, evening]) {
        expect(info.tithiNumber, inInclusiveRange(1, 30));
        expect(info.displayName, isNotEmpty);
      }
      // Same calendar day → tithi differs by at most 1 (or wraps 30→1).
      final diff = (morning.tithiNumber - evening.tithiNumber).abs();
      expect(diff <= 1 || diff == 29, isTrue);
    });
  });

  group('Meeus fallback (years outside the 1900–2100 tables)', () {
    final p = Panchang([registerAllCities]);

    test('pre-1900 date still yields a valid tithi', () {
      final info = p.forDate(DateTime.utc(1850, 6, 1), 'Ujjain');
      expect(info.tithiNumber, inInclusiveRange(1, 30));
      expect(info.displayName, isNotEmpty);
    });

    test('post-2100 date still yields a valid tithi', () {
      final info = p.forDate(DateTime.utc(2150, 6, 1), 'Ujjain');
      expect(info.tithiNumber, inInclusiveRange(1, 30));
    });
  });

  group('TithiInfo.fromStored', () {
    test('Purnima / Amavasya naming', () {
      final purnima = TithiInfo.fromStored(
          tithiNumber: 15, month: LunarMonth.kartika, storedSystem: MonthSystem.purnimant);
      expect(purnima.tithiName, 'Purnima');
      expect(purnima.paksha, Paksha.shukla);
      expect(purnima.displayName, 'Kartika Shukla Purnima');

      final amavasya = TithiInfo.fromStored(
          tithiNumber: 30, month: LunarMonth.kartika, storedSystem: MonthSystem.purnimant);
      expect(amavasya.tithiName, 'Amavasya');
      expect(amavasya.paksha, Paksha.krishna);
    });

    test('same display system → month unchanged', () {
      final t = TithiInfo.fromStored(
          tithiNumber: 5, month: LunarMonth.magha, storedSystem: MonthSystem.purnimant,
          displaySystem: MonthSystem.purnimant);
      expect(t.month, LunarMonth.magha);
      expect(t.tithiInPaksha, 5);
    });

    test('cross-system Krishna paksha shifts the month name (Purnimant→Amant = −1)', () {
      // Krishna paksha (tithi 16–30): Purnimant assigns the NEXT month vs Amant.
      final t = TithiInfo.fromStored(
          tithiNumber: 20, month: LunarMonth.pausha, storedSystem: MonthSystem.purnimant,
          displaySystem: MonthSystem.amant);
      expect(t.paksha, Paksha.krishna);
      expect(t.month, LunarMonth.margashirsha); // pausha − 1
    });

    test('Shukla paksha is unchanged across systems', () {
      final t = TithiInfo.fromStored(
          tithiNumber: 5, month: LunarMonth.pausha, storedSystem: MonthSystem.purnimant,
          displaySystem: MonthSystem.amant);
      expect(t.month, LunarMonth.pausha);
    });

    test('adhika prefix in display name', () {
      final t = TithiInfo.fromStored(
          tithiNumber: 3, month: LunarMonth.shravana, storedSystem: MonthSystem.purnimant,
          isAdhika: true);
      expect(t.isAdhika, isTrue);
      expect(t.displayName, startsWith('Adhika '));
    });
  });

  group('Registry contract', () {
    test('unregistered city → empty corrections (Meeus fallback)', () {
      expect(getTithiCorrections('NoSuchCity_XYZ'), isEmpty);
      expect(getTransitionMinutes('NoSuchCity_XYZ'), isEmpty);
    });

    test('registered city has data after registerAllCities', () {
      expect(hasRegisteredCities, isTrue);
      expect(registeredCities, contains('Ujjain'));
      expect(getTithiCorrections('Ujjain'), isNotEmpty);
    });

    test('registerAllCities is idempotent', () {
      final before = registeredCities.length;
      registerAllCities();
      registerAllCities();
      expect(registeredCities.length, before);
    });

    test('registerCity adds/overwrites a single city', () {
      registerCity('TestVille', tithi: const {42: 7});
      expect(getTithiCorrections('TestVille'), {42: 7});
      registerCity('TestVille', tithi: const {42: 9});
      expect(getTithiCorrections('TestVille')[42], 9);
    });
  });

  group('Lunar month naming', () {
    test('every month has a non-empty display name', () {
      for (final m in LunarMonth.values) {
        expect(m.displayName, isNotEmpty);
      }
    });

    test('getLunarMonth resolves in both systems', () {
      for (final sun in [15.0, 75.0, 200.0, 330.0]) {
        expect(getLunarMonth(sun, system: MonthSystem.purnimant), isA<LunarMonth>());
        expect(getLunarMonth(sun, system: MonthSystem.amant, isKrishnaPaksha: true),
            isA<LunarMonth>());
      }
    });
  });
}
