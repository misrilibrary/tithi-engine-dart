import 'astronomy.dart';
import 'ayanamsha.dart';
import 'festival_def.dart';
import 'tithi.dart' as tithi_core;
import 'tithi_calculator.dart';

/// Result of finding a festival date, including muhurta window and tithi span.
class FestivalDate {
  final FestivalDef festival;
  final DateTime date;
  final DateTime tithiStart; // UTC moment tithi begins
  final DateTime tithiEnd; // UTC moment tithi ends
  final DateTime?
      muhurtaStart; // UTC start of muhurta window (null for sunrise rule)
  final DateTime? muhurtaEnd; // UTC end of muhurta window

  FestivalDate({
    required this.festival,
    required this.date,
    required this.tithiStart,
    required this.tithiEnd,
    this.muhurtaStart,
    this.muhurtaEnd,
  });
}

/// Find the correct festival date for a given year and city, applying muhurta rules.
/// Festival definitions use Purnimant month names, so finding always uses Purnimant internally.
FestivalDate? findFestivalDate(
    FestivalDef fest, int year, String city, TithiCalculator calc) {
  // Always use Purnimant for finding — festival defs are in Purnimant convention
  final findCalc = calc.monthSystem == MonthSystem.purnimant
      ? calc
      : TithiCalculator(monthSystem: MonthSystem.purnimant);
  final info = TithiInfo(
    tithiNumber: fest.tithiNumber,
    tithiName: '',
    paksha: fest.paksha,
    tithiInPaksha: fest.tithiInPaksha,
    month: fest.month,
    displayName: fest.name,
  );
  final dates = findCalc.findInYear(info, year, celebrationCity: city);
  if (dates.isEmpty) return null;

  final loc = getLocationForCity(city);
  var d = dates.first;

  // Apply muhurta rule: check if D-1 has the target tithi at muhurta time
  if (fest.muhurta != MuhurtaRule.sunrise) {
    final prev = d.subtract(const Duration(days: 1));
    final muhurtaTime = _muhurtaUtc(prev, loc, fest.muhurta);
    final tithiAtMuhurta = _tithiAt(muhurtaTime);
    if (tithiAtMuhurta == fest.tithiNumber) {
      d = prev;
    }
  }

  // Compute tithi start/end times via binary search
  final tithiStart = _findTithiTransition(d, loc, fest.tithiNumber, true);
  final tithiEnd = _findTithiTransition(d, loc, fest.tithiNumber, false);

  // Compute muhurta window
  DateTime? muhurtaStart, muhurtaEnd;
  if (fest.muhurta != MuhurtaRule.sunrise) {
    final mw = _muhurtaWindow(d, loc, fest.muhurta);
    muhurtaStart = mw.$1;
    muhurtaEnd = mw.$2;
  }

  return FestivalDate(
    festival: fest,
    date: d,
    tithiStart: tithiStart,
    tithiEnd: tithiEnd,
    muhurtaStart: muhurtaStart,
    muhurtaEnd: muhurtaEnd,
  );
}

/// Compute the representative UTC moment for a muhurta rule on a given date.
DateTime _muhurtaUtc(DateTime date, CityLocation loc, MuhurtaRule rule) {
  final sunrise = computeSunrise(date, loc);
  final sunset = computeSunset(date, loc);
  switch (rule) {
    case MuhurtaRule.nishita:
      // Midnight ≈ midpoint between sunset and next sunrise
      final nextSunrise =
          computeSunrise(date.add(const Duration(days: 1)), loc);
      return sunset.add(
          Duration(minutes: nextSunrise.difference(sunset).inMinutes ~/ 2));
    case MuhurtaRule.madhyahna:
      // Midday ≈ midpoint between sunrise and sunset
      return sunrise
          .add(Duration(minutes: sunset.difference(sunrise).inMinutes ~/ 2));
    case MuhurtaRule.pradosh:
      // Pradosh ≈ sunset + 1 hour
      return sunset.add(const Duration(hours: 1));
    case MuhurtaRule.sunrise:
      return sunrise;
  }
}

/// Compute the muhurta window (start, end) as UTC DateTimes.
(DateTime, DateTime) _muhurtaWindow(
    DateTime date, CityLocation loc, MuhurtaRule rule) {
  final sunrise = computeSunrise(date, loc);
  final sunset = computeSunset(date, loc);
  switch (rule) {
    case MuhurtaRule.nishita:
      // Nishita kaal = the 8th of the night's 15 muhurtas (the central muhurta).
      final nextSunrise =
          computeSunrise(date.add(const Duration(days: 1)), loc);
      final nightMinutes = nextSunrise.difference(sunset).inMinutes;
      final muhurta = nightMinutes ~/ 15;
      return (
        sunset.add(Duration(minutes: muhurta * 7)),
        sunset.add(Duration(minutes: muhurta * 8))
      );
    case MuhurtaRule.madhyahna:
      // Madhyahna = 3rd of 5 parts of the day
      final dayMinutes = sunset.difference(sunrise).inMinutes;
      final part = dayMinutes ~/ 5;
      return (
        sunrise.add(Duration(minutes: part * 2)),
        sunrise.add(Duration(minutes: part * 3))
      );
    case MuhurtaRule.pradosh:
      // Pradosh kaal = sunset to sunset + 2h 24min
      return (sunset, sunset.add(const Duration(hours: 2, minutes: 24)));
    case MuhurtaRule.sunrise:
      return (sunrise, sunrise);
  }
}

/// Binary search for when the target tithi starts (searchStart=true) or ends (searchStart=false).
/// Searches a 48-hour window around the festival date.
DateTime _findTithiTransition(
    DateTime date, CityLocation loc, int targetTithi, bool searchStart) {
  // Search window: 24h before to 24h after the date's sunrise
  final sunrise = computeSunrise(date, loc);
  var lo = sunrise.subtract(const Duration(hours: 36));
  var hi = sunrise.add(const Duration(hours: 36));

  if (searchStart) {
    // Find the moment the target tithi begins (transition from prev to target)
    // Narrow: find a point before the tithi and a point during it
    while (_tithiAt(lo) == targetTithi &&
        lo.isAfter(sunrise.subtract(const Duration(hours: 48)))) {
      lo = lo.subtract(const Duration(hours: 6));
    }
    // lo should now be before the tithi starts; find the boundary
    if (_tithiAt(lo) == targetTithi) return lo; // tithi spans entire window
    // Ensure hi is within the tithi
    hi = sunrise;
    if (_tithiAt(hi) != targetTithi) {
      hi = sunrise.add(const Duration(hours: 12));
    }
    if (_tithiAt(hi) != targetTithi) return sunrise; // fallback
    // Binary search
    while (hi.difference(lo).inMinutes > 1) {
      final mid = lo.add(Duration(minutes: hi.difference(lo).inMinutes ~/ 2));
      if (_tithiAt(mid) == targetTithi) {
        hi = mid;
      } else {
        lo = mid;
      }
    }
    return hi;
  } else {
    // Find the moment the target tithi ends
    lo = sunrise;
    if (_tithiAt(lo) != targetTithi) {
      lo = sunrise.subtract(const Duration(hours: 12));
    }
    hi = sunrise.add(const Duration(hours: 36));
    // Ensure lo is within the tithi
    if (_tithiAt(lo) != targetTithi) {
      return sunrise.add(const Duration(hours: 24)); // fallback
    }
    // Binary search
    while (hi.difference(lo).inMinutes > 1) {
      final mid = lo.add(Duration(minutes: hi.difference(lo).inMinutes ~/ 2));
      if (_tithiAt(mid) == targetTithi) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    return hi;
  }
}

int _tithiAt(DateTime utcTime) {
  final sunLong = toSidereal(sunLongitude(utcTime), utcTime);
  final moonLong = toSidereal(moonLongitude(utcTime), utcTime);
  return tithi_core.calculateTithi(moonLong, sunLong);
}

/// Find all occurrences of a recurring tithi in a year.
List<FestivalDate> findRecurringDates(
    FestivalDef fest, int year, String city, TithiCalculator calc) {
  final loc = getLocationForCity(city);
  final results = <FestivalDate>[];
  final target = fest.tithiNumber;

  // Scan the year day by day, find each occurrence using "last day at sunrise" rule
  final sunriseFn = getSunriseFnForCity(city);
  DateTime? lastSeen;

  for (var d = DateTime.utc(year, 1, 1);
      d.year == year || (d.year == year + 1 && d.month == 1 && d.day == 1);
      d = d.add(const Duration(days: 1))) {
    final sr = sunriseFn(d);
    final t = _tithiAt(sr);
    if (t == target) {
      lastSeen = d;
    } else if (lastSeen != null) {
      // Tithi ended — lastSeen is the festival date
      final tithiStart = _findTithiTransition(lastSeen, loc, target, true);
      final tithiEnd = _findTithiTransition(lastSeen, loc, target, false);
      results.add(FestivalDate(
          festival: fest,
          date: lastSeen,
          tithiStart: tithiStart,
          tithiEnd: tithiEnd));
      lastSeen = null;
    }
  }
  // Handle if year ends with the tithi still active
  if (lastSeen != null) {
    final tithiStart = _findTithiTransition(lastSeen, loc, target, true);
    final tithiEnd = _findTithiTransition(lastSeen, loc, target, false);
    results.add(FestivalDate(
        festival: fest,
        date: lastSeen,
        tithiStart: tithiStart,
        tithiEnd: tithiEnd));
  }
  return results;
}
