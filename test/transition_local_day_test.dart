import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

/// Regression for the transition-time day-attribution bug, re-expressed for the
/// 3.0 `tithiSegments` API.
///
/// `tithiSegments(windowStartUtc, windowEndUtc, city, offset:)` enumerates the
/// tithi boundaries that fall within the caller's LOCAL civil day (the caller
/// frames the window). The old `transitionTime` ignored the offset and framed
/// the search by the Ujjain (IST) day, so for far-west cities a boundary in the
/// 00:00Z–08:00Z band got stamped onto the wrong local day.
///
/// Ground truth (Swiss Ephemeris):
///   Austin (CDT −5), 2006-05-30: the transition during the local day is
///     S4→S5 at 2006-05-31T04:14Z (= May 30, 11:14 PM CDT). The 03:3xZ boundary
///     (S3→S4) is May 29, 10:34 PM CDT — the prior local evening, and must NOT
///     appear in the May-30 window.
///   Seattle (PDT −7), 2020-05-31: S9→S10 at 2020-05-31T12:08Z
///     (= May 31, 5:08 AM PDT) — on the correct local day.
void main() {
  final panchang = Panchang([registerAllCities]);

  // Civil-day [start,end) in UTC for a local date at a fixed offset.
  (DateTime, DateTime) civilDay(int y, int m, int d, Duration offset) {
    final start = DateTime.utc(y, m, d).subtract(offset);
    return (start, start.add(const Duration(days: 1)));
  }

  group('tithiSegments is framed by the caller local civil day', () {
    test('Austin 2006-05-30 (CDT −5): boundary is the May-30 one, not May-29',
        () {
      const cdt = Duration(hours: -5);
      final (s, e) = civilDay(2006, 5, 30, cdt);
      final segs = panchang.tithiSegments(s, e, City.of('Austin'), offset: cdt);

      // Exactly one transition inside the local day → two segments.
      expect(segs.length, 2);
      final boundary = segs[1].startUtc;
      // Swiss-truth boundary 2006-05-31T04:14Z (±2 min for astronomy/snapping).
      expect(
          boundary.difference(DateTime.utc(2006, 5, 31, 4, 14)).inMinutes.abs(),
          lessThanOrEqualTo(2));
      // It belongs to local May 30 (11:14 PM CDT), not May 29.
      final local = boundary.add(cdt);
      expect(local.day, 30);
      expect(local.hour, 23);
    });

    test('Seattle 2020-05-31 (PDT −7): boundary on the correct local day', () {
      const pdt = Duration(hours: -7);
      final (s, e) = civilDay(2020, 5, 31, pdt);
      final segs =
          panchang.tithiSegments(s, e, City.of('Seattle'), offset: pdt);

      expect(segs.length, 2);
      final boundary = segs[1].startUtc;
      expect(
          boundary.difference(DateTime.utc(2020, 5, 31, 12, 8)).inMinutes.abs(),
          lessThanOrEqualTo(2));
      final local = boundary.add(pdt);
      expect(local.day, 31); // 5:08 AM PDT
    });

    test('segments always tile the window contiguously', () {
      const cdt = Duration(hours: -5);
      final (s, e) = civilDay(2006, 5, 30, cdt);
      final segs = panchang.tithiSegments(s, e, City.of('Austin'), offset: cdt);
      expect(segs.first.startUtc, s);
      expect(segs.last.endUtc, e);
      for (var i = 1; i < segs.length; i++) {
        expect(segs[i].startUtc, segs[i - 1].endUtc);
      }
    });
  });
}
