// Edge-case tests for the 3.0 UTC-instant API: tithiAtInstant civil-date
// indexing (Concern-1), exact-midnight births, and multi-transition / paksha-
// crossing tithiSegments. Expected values verified against the engine and
// cross-checked with Drik Panchang (Austin, Texas).
import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

void main() {
  final p = Panchang([registerAllCities]);
  const cdt = Duration(hours: -5); // Austin civil offset, May–June 2026 (DST)

  (DateTime, DateTime) austinDay(int y, int m, int d) {
    final s = DateTime.utc(y, m, d).subtract(cdt);
    return (s, s.add(const Duration(days: 1)));
  }

  group('tithiAtInstant — civil-date indexing (Concern-1)', () {
    test('evening birth that crosses UTC midnight indexes to the civil day',
        () {
      // 8 PM CDT, May 6 2026 → 01:00Z May 7. Raw-UTC day-indexing would pick
      // May 7's corrections; civil-date indexing (instant+offset) must pick May 6.
      final instant = DateTime.utc(2026, 5, 6, 20).subtract(cdt);
      expect(
          instant.toUtc(), DateTime.utc(2026, 5, 7, 1)); // really May 7 in UTC
      final atInstant =
          p.tithiAtInstant(instant, City.of('Austin'), offset: cdt);
      final sunrise =
          p.tithiOnDate(DateTime.utc(2026, 5, 6), City.of('Austin'));
      // No transition between sunrise and 8 PM that civil day → same tithi.
      expect(atInstant.tithiNumber, sunrise.tithiNumber);
      expect(atInstant.tithiInPaksha, 5); // Krishna Panchami
      expect(atInstant.paksha, Paksha.krishna);
    });

    test('exact-midnight birth resolves cleanly (no date-only footgun)', () {
      // 00:00 CDT May 21 2026. The old hasTime=hour!=0 heuristic would have
      // mis-read this as a date-only query; tithiAtInstant treats it as a moment.
      final midnight = DateTime.utc(2026, 5, 21).subtract(cdt);
      final atMid = p.tithiAtInstant(midnight, City.of('Austin'), offset: cdt);
      expect(atMid.tithiNumber, inInclusiveRange(1, 30));
      // Before the 19:55 transition → same as the day's sunrise tithi (Shashthi).
      expect(
          atMid.tithiInPaksha,
          p
              .tithiOnDate(DateTime.utc(2026, 5, 21), City.of('Austin'))
              .tithiInPaksha);
    });

    test('requires a UTC instant (asserts on wall-clock input)', () {
      final local = DateTime(2026, 5, 6, 20); // isUtc == false
      expect(() => p.tithiAtInstant(local, City.of('Austin'), offset: cdt),
          throwsA(isA<AssertionError>()));
    });
  });

  group('tithiSegments — Drik cross-check (Austin 2026-05-21)', () {
    test('Shukla Shashthi → Saptami at ~19:55 CDT (Drik: 07:54 PM)', () {
      final (s, e) = austinDay(2026, 5, 21);
      final segs = p.tithiSegments(s, e, City.of('Austin'), offset: cdt);
      expect(segs.length, 2);
      expect(segs[0].tithi.tithiInPaksha, 6); // Shashthi
      expect(segs[0].tithi.paksha, Paksha.shukla);
      expect(segs[1].tithi.tithiInPaksha, 7); // Saptami
      // Drik: Shashthi upto 07:54 PM CDT = 00:54Z May 22. Engine within ±2 min.
      final boundary = segs[1].startUtc;
      expect(
          boundary.difference(DateTime.utc(2026, 5, 22, 0, 54)).inMinutes.abs(),
          lessThanOrEqualTo(2));
      expect(segs[1].startIsTransition, isTrue);
    });
  });

  group('tithiSegments — multi-transition / paksha-crossing day', () {
    test('Austin 2026-06-14 has 3 segments: K.14 → Amavasya → S.1', () {
      final (s, e) = austinDay(2026, 6, 14);
      final segs = p.tithiSegments(s, e, City.of('Austin'), offset: cdt);

      expect(segs.length, 3, reason: 'two transitions inside the civil day');

      // Segment 1: Krishna Chaturdashi (K.14).
      expect(segs[0].tithi.tithiInPaksha, 14);
      expect(segs[0].tithi.paksha, Paksha.krishna);
      expect(segs[0].tithi.tithiName, 'Chaturdashi');

      // Segment 2: the short Amavasya sliver (tithi 30) fully inside the day.
      expect(segs[1].tithi.tithiNumber, 30);
      expect(segs[1].tithi.tithiName, 'Amavasya');
      expect(segs[1].tithi.paksha, Paksha.krishna);

      // Segment 3: Shukla Pratipada (S.1) — paksha flips vs the prior segments.
      expect(segs[2].tithi.tithiInPaksha, 1);
      expect(segs[2].tithi.paksha, Paksha.shukla);
      expect(segs[2].tithi.tithiName, 'Pratipada');

      // Per-segment paksha is resolved independently (not one value for the day).
      expect(segs[1].tithi.paksha, isNot(segs[2].tithi.paksha));
    });

    test(
        'segments tile the window contiguously; internal edges are transitions',
        () {
      final (s, e) = austinDay(2026, 6, 14);
      final segs = p.tithiSegments(s, e, City.of('Austin'), offset: cdt);
      expect(segs.first.startUtc, s);
      expect(segs.first.startIsTransition, isFalse);
      expect(segs.last.endUtc, e);
      expect(segs.last.endIsTransition, isFalse);
      for (var i = 1; i < segs.length; i++) {
        expect(segs[i].startUtc, segs[i - 1].endUtc); // contiguous
        expect(segs[i].startIsTransition, isTrue);
        expect(segs[i].startUtc.isAfter(s) && segs[i].startUtc.isBefore(e),
            isTrue);
      }
    });
  });
}
