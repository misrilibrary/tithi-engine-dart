import 'package:test/test.dart';
import 'package:tithi_engine/data/all.dart';
import 'package:tithi_engine/src/tithi_calculator.dart';
import 'package:tithi_engine/src/festival_def.dart';
import 'package:tithi_engine/src/festival_finder.dart';
import 'package:tithi_engine/src/astronomy.dart';

/// Integration test matrix — exercises all workflows across cities × systems.
void main() {
  setUpAll(registerAllCities);
  final cities = [
    'Ujjain',
    'Delhi',
    'Srinagar',
    'Seattle',
    'London',
    'Sydney',
    'Tokyo'
  ];
  final calcP = TithiCalculator(monthSystem: MonthSystem.purnimant);
  final calcA = TithiCalculator(monthSystem: MonthSystem.amant);

  group('getTithi known dates', () {
    final knownDates = <List<dynamic>>[
      [DateTime.utc(2026, 5, 20), 'Ujjain', 4, LunarMonth.jyeshtha, true],
      [DateTime.utc(2026, 3, 19), 'Ujjain', 30, LunarMonth.chaitra, false],
      [DateTime.utc(2026, 7, 29), 'Ujjain', 15, LunarMonth.ashadha, false],
      [DateTime.utc(2026, 2, 15), 'Ujjain', 28, LunarMonth.phalguna, false],
      [DateTime.utc(2026, 11, 8), 'Ujjain', 29, LunarMonth.kartika, false],
      [DateTime.utc(1963, 10, 30), 'Ujjain', 13, LunarMonth.kartika, true],
    ];
    for (final kd in knownDates) {
      final dt = kd[0] as DateTime;
      test('${dt.day}/${dt.month}/${dt.year} ${kd[1]}', () {
        final info = calcP.tithiOnDate(dt, kd[1] as String);
        expect(info.tithiNumber, kd[2]);
        expect(info.month, kd[3]);
        expect(info.isAdhika, kd[4]);
      });
    }
  });

  group('Round-trip getTithi → findInYear', () {
    final dates = [
      DateTime.utc(2026, 1, 15),
      DateTime.utc(2026, 4, 20),
      DateTime.utc(2026, 5, 25),
      DateTime.utc(2026, 8, 16),
      DateTime.utc(2026, 11, 8),
      DateTime.utc(2025, 10, 20)
    ];
    for (final city in cities) {
      for (final dt in dates) {
        for (final calc in [calcP, calcA]) {
          test('${dt.day}/${dt.month}/${dt.year} $city ${calc.monthSystem}',
              () {
            final info = calc.tithiOnDate(dt, city);
            final found = calc.findInYear(info, dt.year, celebrationCity: city);
            final match = found.any((fd) {
              final fi = calc.tithiOnDate(fd, city);
              return fi.tithiNumber == info.tithiNumber &&
                  fi.month == info.month &&
                  fi.isAdhika == info.isAdhika;
            });
            expect(match, true,
                reason:
                    'found=${found.map((d) => '${d.day}/${d.month}').join(",")}');
          });
        }
      }
    }
  });

  group('Purnimant/Amant same tithi number', () {
    final dates = [
      DateTime.utc(2026, 3, 20),
      DateTime.utc(2026, 5, 20),
      DateTime.utc(2026, 7, 1),
      DateTime.utc(2026, 9, 4),
      DateTime.utc(2026, 11, 9),
      DateTime.utc(2026, 12, 25)
    ];
    for (final city in cities) {
      for (final dt in dates) {
        test('${dt.day}/${dt.month} $city', () {
          final p = calcP.tithiOnDate(dt, city);
          final a = calcA.tithiOnDate(dt, city);
          expect(p.tithiNumber, a.tithiNumber);
          expect(p.isAdhika, a.isAdhika);
        });
      }
    }
  });

  group('Month boundaries 2026', () {
    for (final city in cities) {
      test('Purnimant $city', () {
        for (var d = DateTime.utc(2026, 1, 1);
            d.year == 2026;
            d = d.add(const Duration(days: 1))) {
          final info = calcP.tithiOnDate(d, city);
          if (info.tithiNumber == 15 && !info.isAdhika) {
            final next = d.add(const Duration(days: 1));
            final nextInfo = calcP.tithiOnDate(next, city);
            if (nextInfo.paksha == Paksha.krishna) {
              final expected = LunarMonth.values[(info.month.index + 1) % 12];
              expect(nextInfo.month, expected,
                  reason: '$city ${d.day}/${d.month}');
            }
          }
        }
      });
      test('Amant $city', () {
        for (var d = DateTime.utc(2026, 1, 1);
            d.year == 2026;
            d = d.add(const Duration(days: 1))) {
          final info = calcA.tithiOnDate(d, city);
          if (info.tithiNumber == 30 && !info.isAdhika) {
            final next = d.add(const Duration(days: 1));
            final nextInfo = calcA.tithiOnDate(next, city);
            if (nextInfo.paksha == Paksha.shukla) {
              final expected = LunarMonth.values[(info.month.index + 1) % 12];
              expect(nextInfo.month == expected || nextInfo.isAdhika, true,
                  reason: '$city ${d.day}/${d.month}');
            }
          }
        }
      });
    }
  });

  group('Boundary regressions (specific dates)', () {
    final cases = <List<dynamic>>[
      [DateTime.utc(2080, 9, 29), 'Ujjain', LunarMonth.bhadrapada],
      [DateTime.utc(2026, 6, 30), 'Delhi', LunarMonth.jyeshtha],
      [DateTime.utc(2026, 4, 2), 'Seattle', LunarMonth.vaishakha],
      [DateTime.utc(2010, 10, 23), 'Kolkata', LunarMonth.ashvina],
    ];
    for (final c in cases) {
      final dt = c[0] as DateTime;
      final city = c[1] as String;
      final expectedMonth = c[2] as LunarMonth;
      test('$city ${dt.day}/${dt.month}/${dt.year}', () {
        final info = calcP.tithiOnDate(dt, city);
        expect(info.month, expectedMonth);
      });
    }
  });

  group('Festival dates (muhurta-aware, both systems)', () {
    final truth = {
      'maha_shivaratri': {2025: '2025-02-26', 2026: '2026-02-15'},
      'ram_navami': {2025: '2025-04-06', 2026: '2026-03-26'},
      'janmashtami_smarta': {2025: '2025-08-15', 2026: '2026-09-04'},
      'diwali': {2025: '2025-10-20', 2026: '2026-11-08'}
    };
    for (final fest in festivals.where((f) => truth.containsKey(f.id))) {
      for (final year in [2025, 2026]) {
        test('${fest.name} $year', () {
          final rP = findFestivalDate(fest, year, 'Ujjain', calcP);
          final rA = findFestivalDate(fest, year, 'Ujjain', calcA);
          final expected = truth[fest.id]![year]!;
          expect(rP?.date.toIso8601String().substring(0, 10), expected);
          expect(rA?.date.toIso8601String().substring(0, 10), expected);
        });
      }
    }
  });

  group('Adhika entry findInYear', () {
    test('Adhika Jyeshtha S4 2026 Srinagar', () {
      final info = TithiInfo(
          tithiNumber: 4,
          tithiName: 'Chaturthi',
          paksha: Paksha.shukla,
          tithiInPaksha: 4,
          month: LunarMonth.jyeshtha,
          isAdhika: true,
          displayName: '');
      final dates = calcA.findInYear(info, 2026, celebrationCity: 'Srinagar');
      expect(dates.isNotEmpty, true);
      final verify = calcA.tithiOnDate(dates.first, 'Srinagar');
      expect(verify.isAdhika, true);
      expect(verify.tithiNumber, 4);
    });
  });

  group('Adhik naming verified years', () {
    final truth = {
      2010: 'Vaishakha',
      2015: 'Ashadha',
      2020: 'Ashvina',
      2023: 'Shravana',
      2026: 'Jyeshtha',
      2029: 'Chaitra'
    };
    for (final e in truth.entries) {
      test('${e.key} => Adhik ${e.value}', () {
        String? found;
        for (var d = DateTime.utc(e.key, 1, 1);
            d.year == e.key;
            d = d.add(const Duration(days: 1))) {
          final info = calcP.tithiOnDate(d, 'Ujjain');
          if (info.isAdhika) {
            found = info.month.displayName;
            break;
          }
        }
        expect(found, e.value);
      });
    }
  });

  group('Kshaya year 1963', () {
    test('Amant Margashirsha absent', () {
      final months = <String>{};
      for (var d = DateTime.utc(1963, 1, 1);
          d.year == 1963;
          d = d.add(const Duration(days: 1))) {
        final info = calcA.tithiOnDate(d, 'Ujjain');
        months.add('${info.isAdhika ? "A." : ""}${info.month.displayName}');
      }
      expect(months.contains('Margashirsha'), false);
      expect(months.contains('A.Kartika'), true);
    });
  });

  group('Sunrise sanity', () {
    test('Ujjain equinox/solstice ranges', () {
      final loc = lookupCityLocation('Ujjain');
      final checks = [
        [DateTime.utc(2026, 3, 20), 385, 400],
        [DateTime.utc(2026, 6, 21), 335, 350],
        [DateTime.utc(2026, 12, 21), 418, 432]
      ];
      for (final c in checks) {
        final sr = computeSunrise(c[0] as DateTime, loc);
        final localMin =
            sr.hour * 60 + sr.minute + (loc.utcOffset * 60).round();
        expect(localMin >= (c[1] as int) && localMin <= (c[2] as int), true,
            reason:
                '${(c[0] as DateTime).day}/${(c[0] as DateTime).month}: $localMin min');
      }
    });
    test('Tokyo sunrise day-carry (eastern city, UTC sunrise < 0 in winter)',
        () {
      final loc = lookupCityLocation('Tokyo');
      // Tokyo sunrise is on the PREVIOUS UTC day (e.g. Jun 21 04:26 JST = Jun 20 19:26 UTC).
      // The day-carry bug (h%24) would put it on the wrong local day.
      for (final dt in [
        DateTime.utc(2026, 6, 21),
        DateTime.utc(2026, 12, 21),
        DateTime.utc(2026, 3, 20)
      ]) {
        final sr = computeSunrise(dt, loc);
        final srLocal = sr.add(Duration(minutes: (loc.utcOffset * 60).round()));
        // Sunrise local day must match the requested date
        expect(srLocal.day, dt.day,
            reason:
                'Tokyo ${dt.day}/${dt.month}: sunrise on day ${srLocal.day}');
        // Sunrise local hour should be 4-7 AM
        expect(srLocal.hour >= 4 && srLocal.hour <= 7, true,
            reason:
                'Tokyo ${dt.day}/${dt.month}: sunrise at ${srLocal.hour}:${srLocal.minute}');
      }
    });
  });
}
