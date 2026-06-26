// Day-level tithi vriddhi & kshaya tests.
//
// At a fixed city's sunrise, the tithi number normally advances +1 per day.
// Two anomalies occur regularly and are the heart of panchang correctness:
//   - VRIDDHI ("growth"): a tithi spans two sunrises → the SAME tithi appears
//     on two consecutive days (delta 0).
//   - KSHAYA ("decay"): a tithi begins and ends entirely between two sunrises →
//     it never appears at any sunrise, so the sequence jumps +2 (one skipped).
//
// These tests detect the phenomena directly in the daily sunrise sequence
// (rather than asserting hardcoded dates), then tie them to the finder:
//   - a vriddhi tithi resolves to its LAST (second) sunrise day,
//   - a kshaya tithi resolves to the day BEFORE the skip (last day the
//     preceding tithi was present at sunrise).

import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

void main() {
  setUpAll(registerAllCities);
  final p = Panchang([registerAllCities]);

  int delta(int a, int b) => (b - a + 30) % 30; // sunrise-to-sunrise tithi step

  // Daily sunrise tithis for a year at one city, with parallel dates.
  ({List<DateTime> dates, List<TithiInfo> info}) yearSeq(
      int year, String city) {
    final dates = <DateTime>[];
    final info = <TithiInfo>[];
    for (var d = DateTime.utc(year, 1, 1);
        d.year == year;
        d = d.add(const Duration(days: 1))) {
      dates.add(d);
      info.add(p.tithiOnDate(d, city));
    }
    return (dates: dates, info: info);
  }

  group('Day-level vriddhi & kshaya occur in the sunrise sequence', () {
    final seq = yearSeq(2026, 'Ujjain');

    test('vriddhi happens: a tithi repeats on two consecutive sunrises', () {
      var n = 0;
      for (var i = 0; i + 1 < seq.info.length; i++) {
        if (delta(seq.info[i].tithiNumber, seq.info[i + 1].tithiNumber) == 0) {
          n++;
        }
      }
      expect(n, greaterThan(0),
          reason: 'expected repeated (vriddhi) tithis within a year');
    });

    test('kshaya happens: a tithi is skipped between consecutive sunrises', () {
      var n = 0;
      for (var i = 0; i + 1 < seq.info.length; i++) {
        if (delta(seq.info[i].tithiNumber, seq.info[i + 1].tithiNumber) == 2) {
          n++;
        }
      }
      expect(n, greaterThan(0),
          reason: 'expected skipped (kshaya) tithis within a year');
    });

    test(
        'every sunrise-to-sunrise step is +1 (normal), 0 (vriddhi) or +2 (kshaya)',
        () {
      for (var i = 0; i + 1 < seq.info.length; i++) {
        expect(delta(seq.info[i].tithiNumber, seq.info[i + 1].tithiNumber),
            anyOf(0, 1, 2),
            reason: 'unexpected tithi jump at ${seq.dates[i]}: '
                '${seq.info[i].tithiNumber} → ${seq.info[i + 1].tithiNumber}');
      }
    });
  });

  group('Vriddhi resolves to the LAST (second) sunrise day', () {
    test('finder returns the second day of a clean vriddhi pair', () {
      // Scan a few years for a vriddhi within a single month, away from the
      // paksha boundary (tithi not 15/30) so the spec is unambiguous.
      for (final year in [2026, 2025, 2024, 2027]) {
        final seq = yearSeq(year, 'Ujjain');
        for (var i = 0; i + 1 < seq.info.length; i++) {
          final a = seq.info[i], b = seq.info[i + 1];
          if (a.tithiNumber != b.tithiNumber) continue; // not vriddhi
          if (a.tithiNumber == 15 || a.tithiNumber == 30) continue; // boundary
          if (a.month != b.month) continue; // same month
          final dates = p.findDates(
              a.month, Tithi.ofNumber(a.tithiNumber), year, 'Ujjain');
          expect(dates, contains(seq.dates[i + 1]),
              reason:
                  'vriddhi ${a.displayName} ($year): finder should return the '
                  'second day ${seq.dates[i + 1]}; got $dates');
          return; // one clean case is enough
        }
      }
      fail('no clean vriddhi pair found in 2024–2027');
    });
  });

  group('Kshaya resolves to the day BEFORE the skip', () {
    test('finder returns the prior day for a skipped tithi', () {
      for (final year in [2026, 2025, 2024, 2027]) {
        final seq = yearSeq(year, 'Ujjain');
        for (var i = 0; i + 1 < seq.info.length; i++) {
          final before = seq.info[i].tithiNumber;
          final after = seq.info[i + 1].tithiNumber;
          if (delta(before, after) != 2) continue; // not kshaya
          if (before == 15 || before == 30) {
            continue; // keep skip within a paksha
          }
          if (seq.info[i].month != seq.info[i + 1].month) continue;
          final skipped = before + 1; // the kshaya tithi
          // The skipped tithi never appears at sunrise on the bounding days.
          expect(before, isNot(skipped));
          expect(after, isNot(skipped));
          // Finder maps it to the prior day (where `before` was at sunrise).
          final dates = p.findDates(
              seq.info[i].month, Tithi.ofNumber(skipped), year, 'Ujjain');
          expect(dates, isNotEmpty,
              reason: 'kshaya tithi should still resolve to a date');
          expect(dates, contains(seq.dates[i]),
              reason:
                  'kshaya skipped=$skipped ($year): finder should return the '
                  'prior day ${seq.dates[i]}; got $dates');
          return; // one clean case is enough
        }
      }
      fail('no clean kshaya skip found in 2024–2027');
    });
  });
}
