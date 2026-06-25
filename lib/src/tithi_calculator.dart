import 'astronomy.dart';
import 'ayanamsha.dart';
import 'finder.dart';
import 'lunar_month.dart';
import 'lunar_month_resolver.dart';
import 'month_converter.dart';
import 'regions/registry.dart';
import 'tithi.dart' as tithi_core;
import 'transitions/global_transition_corrections.g.dart';

export 'lunar_month.dart' show LunarMonth, MonthSystem;
export 'tithi.dart' show Paksha;

/// Complete tithi information for a date.
class TithiInfo {
  final int tithiNumber; // 1-30
  final String tithiName; // e.g. "Chaturdashi"
  final tithi_core.Paksha paksha;
  final int tithiInPaksha; // 1-15
  final LunarMonth month;
  final bool isAdhika; // true = adhika (leap) month
  final String displayName; // e.g. "Phalguna Krishna Chaturdashi"

  const TithiInfo({
    required this.tithiNumber,
    required this.tithiName,
    required this.paksha,
    required this.tithiInPaksha,
    required this.month,
    this.isAdhika = false,
    required this.displayName,
  });

  /// Build a [TithiInfo] for a STORED tithi spec (number + month + the system
  /// it was recorded in), deriving paksha/name/position and the display string.
  ///
  /// If [displaySystem] differs from [storedSystem], the month name is converted
  /// between Purnimant/Amant for display (the tithi itself is unchanged).
  /// This is pure naming/rendering — no astronomy — and is the single source of
  /// truth for turning a saved tithi into a labelled [TithiInfo].
  factory TithiInfo.fromStored({
    required int tithiNumber,
    required LunarMonth month,
    required MonthSystem storedSystem,
    bool isAdhika = false,
    MonthSystem? displaySystem,
  }) {
    final paksha = tithi_core.getPaksha(tithiNumber);
    final name = tithi_core.getTithiName(tithiNumber);
    final inPaksha = tithi_core.tithiInPaksha(tithiNumber);
    final target = displaySystem ?? storedSystem;
    final displayMonth = target == storedSystem
        ? month
        : convertMonth(month, paksha, from: storedSystem, to: target);
    final pakshaStr = paksha == tithi_core.Paksha.shukla ? 'Shukla' : 'Krishna';
    final adhikaPrefix = isAdhika ? 'Adhika ' : '';
    final display = '$adhikaPrefix${displayMonth.displayName} $pakshaStr $name';
    return TithiInfo(
      tithiNumber: tithiNumber,
      tithiName: name,
      paksha: paksha,
      tithiInPaksha: inPaksha,
      month: displayMonth,
      isAdhika: isAdhika,
      displayName: display,
    );
  }

  @override
  String toString() => displayName;
}

/// A contiguous span of a single tithi within an enumeration window.
///
/// Returned by [TithiCalculator.tithiSegments] / `Panchang.tithiSegments`. The
/// window is partitioned by every tithi transition inside it, so N transitions
/// yield N+1 segments. [startUtc]/[endUtc] are clipped to the window edges;
/// [startIsTransition]/[endIsTransition] indicate whether that edge is a real
/// tithi boundary (true) or just the window clip (false).
class TithiSegment {
  final DateTime startUtc; // UTC, inclusive
  final DateTime endUtc; // UTC, exclusive
  final TithiInfo tithi;
  final bool startIsTransition;
  final bool endIsTransition;

  const TithiSegment({
    required this.startUtc,
    required this.endUtc,
    required this.tithi,
    required this.startIsTransition,
    required this.endIsTransition,
  });

  @override
  String toString() =>
      '${tithi.displayName} [${startUtc.toIso8601String()} → ${endUtc.toIso8601String()}]';
}

/// Pure Dart tithi calculator. No external dependencies.
///
/// Time inputs are **UTC instants**; the calculator performs no wall-clock or
/// DST conversion. Where a civil-day mapping is needed (correction-table row
/// selection), the caller supplies the `offset` in effect at that instant and
/// the calculator derives the civil date from the instant + offset. Resolving the
/// DST-correct offset is the caller's responsibility.
class TithiCalculator {
  final MonthSystem monthSystem;

  /// Which sunrise/sunset convention all sun-time-derived calculations use.
  /// Defaults to [SunriseConvention.upperLimb] (the original behavior).
  final SunriseConvention convention;
  late final LunarMonthResolver _monthResolver;

  /// Per-city resolver cache. The default city uses [_monthResolver]; every
  /// other city's resolver is built once and reused, so its per-year month-span
  /// cache survives across calls.
  final Map<String, LunarMonthResolver> _resolverCache = {};

  TithiCalculator({
    this.monthSystem = MonthSystem.purnimant,
    this.convention = SunriseConvention.upperLimb,
  }) {
    _monthResolver =
        LunarMonthResolver(system: monthSystem, convention: convention);
  }

  /// Returns the (cached) resolver for [city].
  LunarMonthResolver _resolverFor(String city) {
    if (city == defaultCity) return _monthResolver;
    return _resolverCache[city] ??= LunarMonthResolver(
        system: monthSystem, city: city, convention: convention);
  }

  // ── Public API ───────────────────────────────────────────────────────────

  /// Sunrise tithi for the panchang day of [date] at [city] (observance/display).
  ///
  /// Only [date]'s calendar fields (year/month/day) select the day; time-of-day
  /// is ignored. No offset is required — sunrise is astronomical (from lat/lon).
  /// Uses the corrected sunrise tithi when tabled, Meeus fallback otherwise.
  TithiInfo tithiOnDate(DateTime date, String city) {
    final civilDate = DateTime.utc(date.year, date.month, date.day);
    final dayIndex = civilDate.difference(_epoch).inDays;
    final loc = getLocationForCity(city);
    final tithiNum = getTithiCorrections(city, convention)[dayIndex] ??
        _meeusTithiAt(computeSunrise(date, loc, convention: convention));
    return _buildInfo(tithiNum, civilDate, city);
  }

  /// Tithi active at the exact UTC [utcInstant] at [city] (birth-time precision).
  ///
  /// [offset] is the actual (DST-aware) UTC offset in effect at that instant in
  /// [city]; its only job is to derive the civil date for correction-table row
  /// selection (instant + offset). The astronomy uses [utcInstant] directly.
  TithiInfo tithiAtInstant(DateTime utcInstant, String city,
      {required Duration offset}) {
    assert(utcInstant.isUtc, 'tithiAtInstant requires a UTC instant');
    final civil = utcInstant.add(offset);
    final civilDate = DateTime.utc(civil.year, civil.month, civil.day);
    // The tithi at an instant is the Swiss-corrected elongation tithi of the
    // segment (bounded by corrected transitions) that contains it. Labeling by
    // the segment's own elongation — not a sunrise anchor — keeps it correct even
    // when the engine's Meeus sunrise lands on the opposite side of a
    // near-sunrise transition from the true sunrise (the straddle case).
    final lo = utcInstant.subtract(const Duration(hours: 30));
    final hi = utcInstant.add(const Duration(hours: 30));
    var a = lo, b = hi;
    for (final tr in _findAllTransitions(lo, hi)) {
      if (!tr.isAfter(utcInstant)) {
        a = tr;
      } else {
        b = tr;
        break;
      }
    }
    final mid =
        a.add(Duration(milliseconds: b.difference(a).inMilliseconds ~/ 2));
    return _buildInfo(_meeusTithiAt(mid), civilDate, city);
  }

  /// Enumerate every tithi segment within `[windowStartUtc, windowEndUtc)` at
  /// [city]. N transitions inside the window → N+1 segments.
  ///
  /// The caller frames the window — e.g. a civil day's local-midnight→midnight
  /// converted to UTC (DST-aware) — and supplies [offset] (the offset in effect
  /// during the window) used only for correction-table row selection.
  ///
  /// Accuracy: transition *instants* are Swiss-corrected at the source by the
  /// global (city-independent) transition correction; each segment's *label* is
  /// its own corrected-elongation tithi (at the segment midpoint), so labels are
  /// Swiss-exact and independent of any sunrise anchor.
  List<TithiSegment> tithiSegments(
      DateTime windowStartUtc, DateTime windowEndUtc, String city,
      {required Duration offset}) {
    assert(windowStartUtc.isUtc && windowEndUtc.isUtc,
        'tithiSegments requires UTC window bounds');

    // 1. All transition instants inside the window — already Swiss-corrected at
    //    the source via the global transition correction (_findAllTransitions).
    final transitions = _findAllTransitions(windowStartUtc, windowEndUtc);

    // 2. Label each segment by its OWN Swiss-corrected elongation tithi (the
    //    tithi at the segment midpoint), independent of any sunrise anchor — so
    //    labels stay .se1-correct even on sunrise-straddle days (where the
    //    engine's Meeus sunrise and the true sunrise fall on opposite sides of a
    //    near-sunrise transition).
    final bounds = <DateTime>[windowStartUtc, ...transitions, windowEndUtc];
    final segments = <TithiSegment>[];
    final last = bounds.length - 2;
    for (var i = 0; i <= last; i++) {
      final mid = bounds[i].add(Duration(
          milliseconds:
              bounds[i + 1].difference(bounds[i]).inMilliseconds ~/ 2));
      segments.add(TithiSegment(
        startUtc: bounds[i],
        endUtc: bounds[i + 1],
        tithi: _buildInfo(_meeusTithiAt(mid), mid, city),
        startIsTransition: i > 0,
        endIsTransition: i < last,
      ));
    }
    return segments;
  }

  /// Find when a tithi falls in a given year for a celebration city.
  /// Returns all occurrences (usually 1, sometimes 2).
  List<DateTime> findInYear(TithiInfo info, int year,
      {String? celebrationCity}) {
    final city = celebrationCity ?? defaultCity;
    final resolver = _resolverFor(city);
    return findTithiInYear(
      month: info.month,
      paksha: info.paksha,
      tithiInPakshaNum: info.tithiInPaksha,
      year: year,
      resolver: resolver,
      system: monthSystem,
      isAdhika: info.isAdhika,
      sunriseFn: (dt) =>
          computeSunrise(dt, getLocationForCity(city), convention: convention),
    );
  }

  /// Find the next occurrence of a tithi from today (or a given date).
  DateTime? findNext(TithiInfo info,
      {DateTime? from, String? celebrationCity}) {
    final city = celebrationCity ?? defaultCity;
    final resolver = _resolverFor(city);
    return findNextOccurrence(
      month: info.month,
      paksha: info.paksha,
      tithiInPakshaNum: info.tithiInPaksha,
      resolver: resolver,
      from: from,
      system: monthSystem,
      sunriseFn: (dt) =>
          computeSunrise(dt, getLocationForCity(city), convention: convention),
    );
  }

  // ── Internal helpers ───────────────────────────────────────────────────────

  static final _epoch = DateTime.utc(1900, 1, 1);

  /// Pure-astronomy tithi number (1-30) at an absolute UTC instant.
  static int _meeusTithiAt(DateTime utcInstant) {
    final sun = toSidereal(sunLongitude(utcInstant), utcInstant);
    final moon = toSidereal(moonLongitude(utcInstant), utcInstant);
    return tithi_core.calculateTithi(moon, sun);
  }

  /// Lazily-decoded absolute Swiss transition instants (UTC minutes since 1900),
  /// reconstructed once by prefix-summing the delta-encoded global table.
  static List<int>? _absTransCache;
  static List<int> get _absTransitions {
    final cached = _absTransCache;
    if (cached != null) return cached;
    final d = globalTransitionCorrectionDeltas;
    final abs = List<int>.filled(d.length, 0);
    var acc = 0;
    for (var i = 0; i < d.length; i++) {
      acc += d[i];
      abs[i] = acc;
    }
    return _absTransCache = abs;
  }

  /// Override a Meeus transition instant with the Swiss-exact one from the
  /// global (city-independent) correction list when one exists within ±60 min
  /// (transitions are ≥~19.5h apart, so the match is unambiguous). Returns the
  /// Swiss instant (minute resolution) or the Meeus instant unchanged.
  static DateTime _correctTransition(DateTime meeus) {
    final list = _absTransitions;
    final meeusMin = meeus.difference(_epoch).inMinutes;
    var lo = 0, hi = list.length - 1;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      if (list[mid] < meeusMin) {
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }
    var best = -1, bestDelta = 61;
    for (final i in [lo - 1, lo]) {
      if (i < 0 || i >= list.length) continue;
      final d = (list[i] - meeusMin).abs();
      if (d <= 60 && d < bestDelta) {
        bestDelta = d;
        best = i;
      }
    }
    return best >= 0 ? _epoch.add(Duration(minutes: list[best])) : meeus;
  }

  /// All tithi transition instants in `[start, end)`, in chronological order.
  /// Coarse 1-hour scan (tithis are ≥~19.5h, so no transition is skipped) then
  /// 1-second bisection of each detected change.
  static List<DateTime> _findAllTransitions(DateTime start, DateTime end) {
    final out = <DateTime>[];
    const step = Duration(hours: 1);
    var segLo = start;
    var loTithi = _meeusTithiAt(start);
    var probe = start.add(step);
    while (true) {
      final cur = probe.isAfter(end) ? end : probe;
      final t = _meeusTithiAt(cur);
      if (t != loTithi) {
        final b = _bisect(segLo, cur, loTithi);
        if (b.isAfter(start) && b.isBefore(end)) out.add(_correctTransition(b));
        loTithi = t;
      }
      segLo = cur;
      if (!cur.isBefore(end)) break;
      probe = probe.add(step);
    }
    return out;
  }

  /// Bisect `[lo, hi]` for the first instant whose tithi differs from
  /// [startTithi] (1-second precision).
  static DateTime _bisect(DateTime lo, DateTime hi, int startTithi) {
    while (hi.difference(lo).inMilliseconds > 1000) {
      final mid =
          lo.add(Duration(milliseconds: hi.difference(lo).inMilliseconds ~/ 2));
      if (_meeusTithiAt(mid) == startTithi) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    return hi;
  }

  /// Shared labeling: tithi number + month-resolution instant → full [TithiInfo].
  /// Month/adhika are resolved at [monthAtInstant] (day-granular spans); paksha
  /// and name derive from [tithiNum].
  TithiInfo _buildInfo(int tithiNum, DateTime monthAtInstant, String city) {
    final paksha = tithi_core.getPaksha(tithiNum);
    final name = tithi_core.getTithiName(tithiNum);
    final inPaksha = tithi_core.tithiInPaksha(tithiNum);
    final monthInfo = _resolverFor(city).getMonthInfo(monthAtInstant);
    final pakshaStr = paksha == tithi_core.Paksha.shukla ? 'Shukla' : 'Krishna';
    final adhikaPrefix = monthInfo.isAdhika ? 'Adhika ' : '';
    final display =
        '$adhikaPrefix${monthInfo.month.displayName} $pakshaStr $name';
    return TithiInfo(
      tithiNumber: tithiNum,
      tithiName: name,
      paksha: paksha,
      tithiInPaksha: inPaksha,
      month: monthInfo.month,
      isAdhika: monthInfo.isAdhika,
      displayName: display,
    );
  }
}
