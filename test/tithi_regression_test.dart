import 'package:test/test.dart';
import 'package:tithi_engine/data/all.dart';
import 'package:tithi_engine/src/astronomy.dart';
import 'package:tithi_engine/src/cities.dart' show cityRegistry;
import 'package:tithi_engine/src/lunar_month.dart';
import 'package:tithi_engine/src/lunar_month_resolver.dart';
import 'package:tithi_engine/src/regions/registry.dart';

/// Regression guards distilled from the Swiss-Ephemeris benchmark (which itself
/// stays a manual/CI tool). These are fast, deterministic, and assert against
/// verified Drik values — no Swiss dependency.
void main() {
  setUpAll(registerAllCities);
  group('Sunrise day-carry (guards the eastern-city h%24 wrap bug)', () {
    // Eastern / higher-latitude cities whose UTC sunrise goes negative in summer.
    for (final city in [
      'Varanasi',
      'Kolkata',
      'Guwahati',
      'Delhi',
      'Srinagar',
      'Seattle'
    ]) {
      for (final d in [DateTime.utc(2025, 6, 21), DateTime.utc(2025, 12, 21)]) {
        test('$city sunrise lands on the right local day (${d.month}/${d.day})',
            () {
          final loc = lookupCityLocation(city);
          final sr = computeSunrise(d, loc);
          // Convert UTC instant to the city's local clock time.
          final local = sr.add(Duration(minutes: (loc.utcOffset * 60).round()));
          // Sunrise must be on the requested local date, in a sane morning window.
          expect(local.year, d.year);
          expect(local.month, d.month);
          expect(local.day, d.day);
          expect(local.hour, inInclusiveRange(4, 9));
        });
      }
    }
  });

  group('Adhik month names match verified Drik Panchang', () {
    final expected = {
      2010: 'Vaishakha',
      2015: 'Ashadha',
      2023: 'Shravana',
      2029: 'Chaitra',
      1945: 'Chaitra',
      1963: 'Kartika',
      1964: 'Chaitra',
    };
    final r = LunarMonthResolver(system: MonthSystem.purnimant);
    expected.forEach((year, month) {
      test('$year => Adhik $month', () {
        final adhik = r
            .getSpansForYear(year)
            .where((s) => s.isAdhika)
            .map((s) => s.month.displayName)
            .toSet();
        expect(adhik, {month});
      });
    });
  });

  group('No month silently skipped (non-kshaya years, eastern city)', () {
    // Kolkata wraps in summer pre-fix; post-fix every nij month must still appear.
    // 2000-2030 contains no kshaya year (last was 1983, next ~2123).
    final r =
        LunarMonthResolver(system: MonthSystem.purnimant, city: 'Kolkata');
    for (var year = 2000; year <= 2030; year++) {
      test('$year has all 12 nij months', () {
        final nij = r
            .getSpansForYear(year)
            .where((s) => !s.isAdhika)
            .map((s) => s.month)
            .toSet();
        expect(nij.length, 12,
            reason: 'year $year missing: '
                '${LunarMonth.values.where((m) => !nij.contains(m)).map((m) => m.displayName).join(",")}');
      });
    }
  });

  group('Every supported city has its own correction table', () {
    for (final city in cityRegistry.keys) {
      test('$city is covered', () {
        // Full coverage policy: no city should silently fall back to raw Meeus.
        expect(getTithiCorrections(city), isNotEmpty,
            reason:
                '$city has no correction table — run gen_city_corrections + gen_registry');
      });
    }
  });
}
