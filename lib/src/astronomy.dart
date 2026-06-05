import 'dart:math';

import 'cities.dart';
export 'cities.dart'
    show supportedCities, pinnedCities, orderedCityList, defaultCity;

/// Meeus astronomical algorithms for Sun and Moon ecliptic longitude.
/// Reference: Jean Meeus, "Astronomical Algorithms", 2nd Edition.

const _deg2rad = pi / 180;
const _rad2deg = 180 / pi;

/// Julian Day Number from DateTime (UTC).
double julianDay(DateTime dt) {
  final utc = dt.toUtc();
  int y = utc.year;
  int m = utc.month;
  final d =
      utc.day + utc.hour / 24.0 + utc.minute / 1440.0 + utc.second / 86400.0;
  if (m <= 2) {
    y--;
    m += 12;
  }
  final a = (y / 100).floor();
  final b = 2 - a + (a / 4).floor();
  return (365.25 * (y + 4716)).floor() +
      (30.6001 * (m + 1)).floor() +
      d +
      b -
      1524.5;
}

/// Julian centuries from J2000.0
// ignore: non_constant_identifier_names
double _T(double jd) => (jd - 2451545.0) / 36525.0;

/// Normalize angle to 0-360
double _norm360(double deg) => deg % 360 + (deg < 0 ? 360 : 0);

/// Sun's ecliptic longitude in degrees (tropical). Meeus Ch. 25, low accuracy.
double sunLongitude(DateTime dt) {
  final t = _T(julianDay(dt));

  // Geometric mean longitude
  final l0 = _norm360(280.46646 + 36000.76983 * t + 0.0003032 * t * t);
  // Mean anomaly
  final m = _norm360(357.52911 + 35999.05029 * t - 0.0001537 * t * t);
  final mRad = m * _deg2rad;

  // Equation of center
  final c = (1.914602 - 0.004817 * t - 0.000014 * t * t) * sin(mRad) +
      (0.019993 - 0.000101 * t) * sin(2 * mRad) +
      0.000289 * sin(3 * mRad);

  // Sun's true longitude
  final sunLon = _norm360(l0 + c);

  // Apparent longitude (nutation correction)
  final omega = 125.04 - 1934.136 * t;
  final apparent = sunLon - 0.00569 - 0.00478 * sin(omega * _deg2rad);

  return _norm360(apparent);
}

/// Moon's ecliptic longitude in degrees (tropical). Meeus Ch. 47, full table.
double moonLongitude(DateTime dt) {
  final t = _T(julianDay(dt));
  final t2 = t * t;
  final t3 = t2 * t;
  final t4 = t3 * t;

  // Moon's mean longitude
  final lp = _norm360(218.3164477 +
      481267.88123421 * t -
      0.0015786 * t2 +
      t3 / 538841 -
      t4 / 65194000);
  // Mean elongation
  final d = _norm360(297.8501921 +
      445267.1114034 * t -
      0.0018819 * t2 +
      t3 / 545868 -
      t4 / 113065000);
  // Sun's mean anomaly
  final m = _norm360(
      357.5291092 + 35999.0502909 * t - 0.0001536 * t2 + t3 / 24490000);
  // Moon's mean anomaly
  final mp = _norm360(134.9633964 +
      477198.8675055 * t +
      0.0087414 * t2 +
      t3 / 69699 -
      t4 / 14712000);
  // Moon's argument of latitude
  final f = _norm360(93.2720950 +
      483202.0175233 * t -
      0.0036539 * t2 -
      t3 / 3526000 +
      t4 / 863310000);

  final dR = d * _deg2rad;
  final mR = m * _deg2rad;
  final mpR = mp * _deg2rad;
  final fR = f * _deg2rad;

  // Meeus Table 47.A — all 60 longitude terms (no E correction applied)
  double sumL = 0;
  sumL += 6288774 * sin(mpR);
  sumL += 1274027 * sin(2 * dR - mpR);
  sumL += 658314 * sin(2 * dR);
  sumL += 213618 * sin(2 * mpR);
  sumL += -185116 * sin(mR);
  sumL += -114332 * sin(2 * fR);
  sumL += 58793 * sin(2 * dR - 2 * mpR);
  sumL += 57066 * sin(2 * dR - mR - mpR);
  sumL += 53322 * sin(2 * dR + mpR);
  sumL += 45758 * sin(2 * dR - mR);
  sumL += -40923 * sin(mR - mpR);
  sumL += -34720 * sin(dR);
  sumL += -30383 * sin(mR + mpR);
  sumL += 15327 * sin(2 * dR - 2 * fR);
  sumL += -12528 * sin(mpR + 2 * fR);
  sumL += 10980 * sin(mpR - 2 * fR);
  sumL += 10675 * sin(4 * dR - mpR);
  sumL += 10034 * sin(3 * mpR);
  sumL += 8548 * sin(4 * dR - 2 * mpR);
  sumL += -7888 * sin(2 * dR + mR - mpR);
  sumL += -6766 * sin(2 * dR + mR);
  sumL += -5163 * sin(dR - mpR);
  sumL += 4987 * sin(dR + mR);
  sumL += 4036 * sin(2 * dR - mR + mpR);
  sumL += 3994 * sin(2 * dR + 2 * mpR);
  sumL += 3861 * sin(4 * dR);
  sumL += 3665 * sin(2 * dR - 3 * mpR);
  sumL += -2689 * sin(mR - 2 * mpR);
  sumL += -2602 * sin(2 * dR - mpR + 2 * fR);
  sumL += 2390 * sin(2 * dR - mR - 2 * mpR);
  sumL += -2348 * sin(dR + mpR);
  sumL += 2236 * sin(2 * dR - 2 * mR);
  sumL += -2120 * sin(mR + 2 * mpR);
  sumL += -2069 * sin(2 * mR);
  sumL += 2048 * sin(2 * dR - 2 * mR - mpR);
  sumL += -1773 * sin(2 * dR + mpR - 2 * fR);
  sumL += -1595 * sin(2 * dR + 2 * fR);
  sumL += 1215 * sin(4 * dR - mR - mpR);
  sumL += -1110 * sin(2 * mpR + 2 * fR);
  sumL += -892 * sin(3 * dR - mpR);
  sumL += -810 * sin(2 * dR + mR + mpR);
  sumL += 759 * sin(4 * dR - mR - 2 * mpR);
  sumL += -713 * sin(2 * mR - mpR);
  sumL += -700 * sin(2 * dR + 2 * mR - mpR);
  sumL += 691 * sin(2 * dR + mR - 2 * mpR);
  sumL += 596 * sin(2 * dR - mR - 2 * fR);
  sumL += 549 * sin(4 * dR + mpR);
  sumL += 537 * sin(4 * mpR);
  sumL += 520 * sin(4 * dR - mR);
  sumL += -487 * sin(dR - 2 * mpR);
  sumL += -399 * sin(2 * dR + mR - 2 * fR);
  sumL += -381 * sin(2 * mpR - 2 * fR);
  sumL += 351 * sin(dR + mR + mpR);
  sumL += -340 * sin(3 * dR - 2 * mpR);
  sumL += 330 * sin(4 * dR - 3 * mpR);
  sumL += 327 * sin(2 * dR - mR + 2 * mpR);
  sumL += -323 * sin(2 * mR + mpR);
  sumL += 299 * sin(dR + mR - mpR);
  sumL += 294 * sin(2 * dR + 3 * mpR);

  // Additional correction terms (A1, A2, A3) from Meeus p. 338
  final a1 = _norm360(119.75 + 131.849 * t) * _deg2rad;
  final a2 = _norm360(53.09 + 479264.290 * t) * _deg2rad;

  sumL += 3958 * sin(a1);
  sumL += 1962 * sin(lp * _deg2rad - fR);
  sumL += 318 * sin(a2);

  final moonLon = lp + sumL / 1000000.0;
  return _norm360(moonLon);
}

/// Function type for computing sunrise as UTC DateTime for a given date.
typedef SunriseFn = DateTime Function(DateTime date);

/// City location for sunrise calculation.
class CityLocation {
  final double latitude; // degrees (positive = North)
  final double longitude; // degrees (positive = East)
  final double utcOffset; // standard time offset in hours
  const CityLocation(this.latitude, this.longitude, this.utcOffset);
}

/// Compute exact sunrise as UTC DateTime for a given date and location.
/// Uses solar declination from our Sun longitude + hour angle formula.
DateTime computeSunrise(DateTime date, CityLocation loc) {
  // Sun's declination from its ecliptic longitude
  final jd = julianDay(DateTime.utc(date.year, date.month, date.day, 12));
  final t = (jd - 2451545.0) / 36525.0;
  final sunLon =
      sunLongitude(DateTime.utc(date.year, date.month, date.day, 12));
  final obliquity = (23.4393 - 0.0130 * t) * _deg2rad;
  final sunLonRad = sunLon * _deg2rad;
  final declination = asin(sin(obliquity) * sin(sunLonRad));

  // Hour angle at sunrise (-0.833° for atmospheric refraction)
  final latRad = loc.latitude * _deg2rad;
  final cosH = (sin(-0.833 * _deg2rad) - sin(latRad) * sin(declination)) /
      (cos(latRad) * cos(declination));

  // Clamp for polar regions (midnight sun / polar night)
  final hourAngle = cosH.abs() > 1.0 ? pi : acos(cosH.clamp(-1.0, 1.0));

  // Equation of time: true solar noon differs from mean noon by E = L0 - RA.
  // (Without this the sunrise is off by up to ~±16 min seasonally.)
  final rightAsc = atan2(cos(obliquity) * sin(sunLonRad), cos(sunLonRad));
  final meanLon =
      _norm360(280.46646 + 36000.76983 * t + 0.0003032 * t * t) * _deg2rad;
  var eot = meanLon - rightAsc;
  eot = atan2(sin(eot), cos(eot)); // wrap to (-pi, pi]
  final eotHours = eot * _rad2deg / 15.0;

  // True solar noon in UTC (mean noon via longitude, corrected by equation of time)
  final solarNoonUTC = 12.0 - loc.longitude / 15.0 - eotHours;

  // Sunrise in UTC hours
  final sunriseUTC = solarNoonUTC - (hourAngle * _rad2deg / 15.0);

  // Build the instant via Duration so a sunrise before/after the UTC day
  // (sunriseUTC < 0 or >= 24, e.g. eastern cities in summer) carries to the
  // correct calendar day instead of wrapping within the same day.
  return DateTime.utc(date.year, date.month, date.day)
      .add(Duration(minutes: (sunriseUTC * 60).round()));
}

/// Compute exact sunset as UTC DateTime for a given date and location.
/// Mirror of computeSunrise: noon + hourAngle instead of noon - hourAngle.
DateTime computeSunset(DateTime date, CityLocation loc) {
  final jd = julianDay(DateTime.utc(date.year, date.month, date.day, 12));
  final t = (jd - 2451545.0) / 36525.0;
  final sunLon =
      sunLongitude(DateTime.utc(date.year, date.month, date.day, 12));
  final obliquity = (23.4393 - 0.0130 * t) * _deg2rad;
  final sunLonRad = sunLon * _deg2rad;
  final declination = asin(sin(obliquity) * sin(sunLonRad));

  final latRad = loc.latitude * _deg2rad;
  final cosH = (sin(-0.833 * _deg2rad) - sin(latRad) * sin(declination)) /
      (cos(latRad) * cos(declination));
  final hourAngle = cosH.abs() > 1.0 ? pi : acos(cosH.clamp(-1.0, 1.0));

  final rightAsc = atan2(cos(obliquity) * sin(sunLonRad), cos(sunLonRad));
  final meanLon =
      _norm360(280.46646 + 36000.76983 * t + 0.0003032 * t * t) * _deg2rad;
  var eot = meanLon - rightAsc;
  eot = atan2(sin(eot), cos(eot));
  final eotHours = eot * _rad2deg / 15.0;

  final solarNoonUTC = 12.0 - loc.longitude / 15.0 - eotHours;
  final sunsetUTC = solarNoonUTC + (hourAngle * _rad2deg / 15.0);

  return DateTime.utc(date.year, date.month, date.day)
      .add(Duration(minutes: (sunsetUTC * 60).round()));
}

/// Get location for a city. Falls back to the default reference city if unknown.
CityLocation getLocationForCity(String city) {
  return supportedCities[city] ?? supportedCities[defaultCity]!;
}

/// Sunrise at the default reference city (used when no city is specified).
DateTime defaultSunrise(DateTime date) =>
    computeSunrise(date, getLocationForCity(defaultCity));

/// Get sunrise function for a city.
SunriseFn getSunriseFnForCity(String city) {
  final loc = getLocationForCity(city);
  return (date) => computeSunrise(date, loc);
}

/// Legacy compatibility: get sunrise params-style offset for a city.
double getUtcOffsetForCity(String city) {
  return getLocationForCity(city).utcOffset;
}
