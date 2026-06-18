import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

/// Regression for the transition-time day-attribution bug.
///
/// `transitionTime(date, utcOffset:)` returns the tithi boundary that falls
/// within the caller's LOCAL calendar day. Previously it ignored utcOffset and
/// framed the search by the Ujjain (IST) day, so for far-west cities a boundary
/// in the 00:00Z-08:00Z band got stamped onto the wrong local day.
///
/// Ground truth (Swiss Ephemeris):
///   Austin (CDT -5), 2006-05-30: the transition during the local day is
///     S4->S5 at 2006-05-31T04:14Z (= May 30, 11:14 PM CDT). The 03:3xZ
///     boundary (S3->S4) is actually May 29, 10:34 PM CDT — the prior evening.
///   Seattle (PDT -7), 2020-05-31: S9->S10 at 2020-05-31T12:08Z
///     (= May 31, 5:08 AM PDT) — already on the correct local day.
void main() {
  final panchang = Panchang([registerAllCities]);

  group('transitionTime is framed by the caller local day', () {
    test('Austin 2006-05-30 (CDT -5) -> the May-30 boundary, not May-29', () {
      const cdt = Duration(hours: -5);
      final t =
          panchang.transitionTime(DateTime.utc(2006, 5, 30), utcOffset: cdt);
      expect(t, isNotNull);
      expect(t!.toUtc(), DateTime.utc(2006, 5, 31, 4, 14));
      final local = t.add(cdt); // UTC -> Austin wall clock
      expect(local.day, 30); // 2006-05-30 23:14 (11:14 PM CDT)
      expect(local.hour, 23);
    });

    test('Seattle 2020-05-31 (PDT -7) -> unchanged, correct local day', () {
      const pdt = Duration(hours: -7);
      final t =
          panchang.transitionTime(DateTime.utc(2020, 5, 31), utcOffset: pdt);
      expect(t, isNotNull);
      expect(t!.toUtc(), DateTime.utc(2020, 5, 31, 12, 8));
      final local = t.add(pdt);
      expect(local.day, 31); // 2020-05-31 05:08 (5:08 AM PDT)
    });

    test('no utcOffset still returns a value (reference-day fallback)', () {
      final t = panchang.transitionTime(DateTime.utc(2006, 5, 30));
      expect(t, isNotNull);
    });
  });
}
