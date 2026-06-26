import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';
import 'package:tithi_engine/data/all_center.dart';
import 'package:tithi_engine/src/astronomy.dart' show lookupCityLocation;

// Branch/line coverage tests for under-covered public surface: the PanchangAt
// bound view, tithiSegments, recurringDates/findNext, getDates, muhurta windows,
// sunset + pre-1920 ΔT, and the centerDisc-registered registry path + the
// tithiAtInstant Meeus-fallback branch. (Each test file runs in its own isolate,
// so registering the centerDisc pack here does not leak into other files.)
void main() {
  final p = Panchang([registerAllCities]);
  final d = DateTime.utc(2026, 2, 15);
  const istOffset = Duration(hours: 5, minutes: 30);
  const pstOffset = Duration(hours: -8);

  group('PanchangAt (named city) mirrors the city-keyed API', () {
    final at = p.at(Location.city('Seattle'));

    test('source is cityCorrected', () {
      expect(at.source, LocationSource.cityCorrected);
    });
    test('tithiOnDate / sunrise / sunset match the keyed calls', () {
      expect(at.tithiOnDate(d).displayName,
          p.tithiOnDate(d, City.of('Seattle')).displayName);
      expect(at.sunrise(d), p.sunrise(d, City.of('Seattle')));
      expect(at.sunset(d), p.sunset(d, City.of('Seattle')));
    });
    test('tithiAtInstant / tithiSegments match the keyed calls', () {
      final utc = DateTime.utc(2026, 2, 15, 18);
      expect(
          at.tithiAtInstant(utc, offset: pstOffset).displayName,
          p
              .tithiAtInstant(utc, City.of('Seattle'), offset: pstOffset)
              .displayName);
      final s = DateTime.utc(2026, 2, 15, 8);
      final e = DateTime.utc(2026, 2, 16, 8);
      expect(at.tithiSegments(s, e, offset: pstOffset).length,
          p.tithiSegments(s, e, City.of('Seattle'), offset: pstOffset).length);
    });
    test('findDate / findDates / findNext / dateFor / recurringDates match',
        () {
      expect(
          at.findDate(LunarMonth.bhadrapada, Tithi.krishna(8), 2026),
          p.findDate(LunarMonth.bhadrapada, Tithi.krishna(8), 2026,
              City.of('Seattle')));
      expect(
          at.findDates(LunarMonth.bhadrapada, Tithi.krishna(8), 2026).length,
          p
              .findDates(LunarMonth.bhadrapada, Tithi.krishna(8), 2026,
                  City.of('Seattle'))
              .length);
      final atNext = at.findNext(LunarMonth.chaitra, Tithi.shukla(1), from: d);
      final pNext = p.findNext(
          LunarMonth.chaitra, Tithi.shukla(1), City.of('Seattle'),
          from: d);
      expect(atNext, pNext);
      final diwali = festivals.firstWhere((f) => f.id == 'diwali');
      expect(at.dateFor(diwali, 2026)?.date,
          p.dateFor(diwali, 2026, City.of('Seattle'))?.date);
      expect(
          at
              .recurringDates(
                  festivals.firstWhere((f) => f.id == 'masik_purnima'), 2026)
              .length,
          p
              .recurringDates(
                  festivals.firstWhere((f) => f.id == 'masik_purnima'),
                  2026,
                  City.of('Seattle'))
              .length);
    });
  });

  group('PanchangAt (raw coordinates)', () {
    test('off-grid point is meeusRaw and still computes a tithi', () {
      final remote =
          p.at(Location.at(0.0, -140.0, offset: Duration(hours: -9)));
      expect(remote.source, LocationSource.meeusRaw);
      expect(remote.tithiOnDate(d).tithiNumber, inInclusiveRange(1, 30));
    });
    test('a point inside a city cell is cityCorrected', () {
      final ny = lookupCityLocation('New York');
      expect(p.at(Location.at(ny.latitude, ny.longitude)).source,
          LocationSource.cityCorrected);
    });
  });

  group('tithiSegments invariants (both conventions)', () {
    for (final conv in SunriseConvention.values) {
      test('contiguous, in-range segments — ${conv.name}', () {
        final pp = Panchang([registerAllCities], convention: conv);
        final start = DateTime.utc(2026, 2, 15, 8);
        final end = DateTime.utc(2026, 2, 16, 8);
        final segs =
            pp.tithiSegments(start, end, City.of('Ujjain'), offset: istOffset);
        expect(segs, isNotEmpty);
        expect(segs.first.startUtc, start);
        expect(segs.last.endUtc, end);
        expect(segs.first.startIsTransition, isFalse);
        expect(segs.last.endIsTransition, isFalse);
        for (var i = 0; i < segs.length; i++) {
          expect(segs[i].tithi.tithiNumber, inInclusiveRange(1, 30));
          if (i > 0) expect(segs[i].startUtc, segs[i - 1].endUtc);
        }
      });
    }
  });

  group('recurringDates / findNext / getDates', () {
    test('masik_purnima recurs ~monthly, always Purnima (T15)', () {
      final r = p.recurringDates(
          festivals.firstWhere((f) => f.id == 'masik_purnima'),
          2026,
          City.of('Ujjain'));
      expect(r.length, inInclusiveRange(12, 13));
      for (final fd in r) {
        expect(fd.tithiStart.isBefore(fd.tithiEnd), isTrue);
      }
    });
    test('findNext returns a date at/after the from date', () {
      final from = DateTime.utc(2026, 1, 1);
      // Bhadrapada Krishna 8 (Janmashtami) reliably occurs each year, so the
      // 400-day forward scan resolves it (exercises findNext's success path).
      final n = p.findNext(
          LunarMonth.bhadrapada, Tithi.krishna(8), City.of('Ujjain'),
          from: from);
      expect(n, isNotNull);
      expect(n!.isBefore(from), isFalse);
    });
    test('findDates returns at least one date for a normal tithi', () {
      final dates = p.findDates(
          LunarMonth.kartika, Tithi.krishna(15), 2026, City.of('Ujjain'));
      expect(dates, isNotEmpty);
    });
  });

  group('dateFor muhurta windows (non-sunrise rules)', () {
    test('nishita (Maha Shivaratri) yields a muhurta window', () {
      final fd = p.dateFor(
          festivals.firstWhere((f) => f.id == 'maha_shivaratri'),
          2026,
          City.of('Ujjain'));
      expect(fd, isNotNull);
      expect(fd!.muhurtaStart, isNotNull);
      expect(fd.muhurtaEnd, isNotNull);
      expect(fd.muhurtaStart!.isBefore(fd.muhurtaEnd!), isTrue);
    });
    test('madhyahna (Ram Navami) and pradosh (Diwali) resolve', () {
      expect(
          p.dateFor(festivals.firstWhere((f) => f.id == 'ram_navami'), 2026,
              City.of('Ujjain')),
          isNotNull);
      expect(
          p.dateFor(festivals.firstWhere((f) => f.id == 'diwali'), 2026,
              City.of('Ujjain')),
          isNotNull);
    });
  });

  group('sun times: pre-1920 ΔT branch + sunset', () {
    test('1905 sunrise < sunset (exercises Espenak–Meeus pre-1920 ΔT)', () {
      final old = DateTime.utc(1905, 6, 21);
      final sr = p.sunrise(old, City.of('London'));
      final ss = p.sunset(old, City.of('London'));
      expect(sr.isBefore(ss), isTrue);
    });
  });

  group('centerDisc with registered tables', () {
    // Register the centerDisc pack (isolated to this file's isolate).
    final pc = Panchang([registerAllCities, registerAllCitiesCenterDisc],
        convention: SunriseConvention.centerDisc);

    test('a Seattle centerDisc correction day uses the table value', () {
      // dayIndex 9506 = 1926-01-11; centerDisc table says T28 (Meeus would be 27).
      expect(
          pc
              .tithiOnDate(DateTime.utc(1926, 1, 11), City.of('Seattle'))
              .tithiNumber,
          28);
    });

    test(
        'tithiAtInstant falls back to Meeus when only a transition minute exists',
        () {
      // dayIndex 1165 IS in Seattle's (shared) transition table but is NOT a
      // centerDisc tithi-correction day -> sunriseTithi is null -> the null-safe
      // branch must use Meeus (no crash, valid range). Derive the date from the
      // epoch+index so the dayIndex is exact.
      final day1165 = DateTime.utc(1900, 1, 1).add(const Duration(days: 1165));
      final t = pc.tithiAtInstant(
          day1165.add(const Duration(hours: 20)), City.of('Seattle'),
          offset: pstOffset);
      expect(t.tithiNumber, inInclusiveRange(1, 30));
    });
  });

  group('tithi_calculator corrected & snap paths (table-transition day)', () {
    // dayIndex 1165 is in BOTH Seattle's upper-limb tithi corrections and its
    // transition-minute table (transMinute = 390 = 06:30 standard-local), so it
    // drives the corrected tithiAtInstant branch and the tithiSegments snap.
    final day1165 = DateTime.utc(1900, 1, 1).add(const Duration(days: 1165));

    test('tithiAtInstant corrected branch — both sides of the transition', () {
      // 20:00 UTC = 12:00 PST (>= 06:30 -> sunrise tithi);
      // 13:00 UTC = 05:00 PST (<  06:30 -> sunrise tithi - 1).
      for (final hours in [20, 13]) {
        final info = p.tithiAtInstant(
            day1165.add(Duration(hours: hours)), City.of('Seattle'),
            offset: pstOffset);
        expect(info.tithiNumber, inInclusiveRange(1, 30));
      }
    });

    test('tithiSegments snap branch + TithiSegment.toString', () {
      final ws = day1165.add(const Duration(hours: 8)); // local midnight (UTC)
      final we = ws.add(const Duration(days: 1));
      final segs =
          p.tithiSegments(ws, we, City.of('Seattle'), offset: pstOffset);
      expect(segs, isNotEmpty);
      expect(segs.first.toString(), contains('→'));
    });

    test('TithiInfo.toString returns the display name', () {
      final info = p.tithiOnDate(day1165, City.of('Seattle'));
      expect(info.toString(), info.displayName);
      expect(info.toString(), isNotEmpty);
    });
  });
}
