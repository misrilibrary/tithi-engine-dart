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

/// ΔT (TT − UT) in **seconds** — pure-Dart Espenak & Meeus (2006) polynomials.
/// The Meeus Sun/Moon series expect Terrestrial Time; UT must be advanced by ΔT.
/// The correction-table generator MUST use this identical function so the
/// engine's Meeus matches the generator's Meeus (invariant: Meeus+corrections=Swiss).
double deltaTSeconds(DateTime dt) {
  final y = dt.year + (dt.month - 0.5) / 12.0;
  double u;
  if (y < 1920) {
    final t = y - 1900;
    return -2.79 +
        1.494119 * t -
        0.0598939 * t * t +
        0.0061966 * t * t * t -
        0.000197 * t * t * t * t;
  } else if (y < 1941) {
    final t = y - 1920;
    return 21.20 + 0.84493 * t - 0.076100 * t * t + 0.0020936 * t * t * t;
  } else if (y < 1961) {
    final t = y - 1950;
    return 29.07 + 0.407 * t - t * t / 233 + t * t * t / 2547;
  } else if (y < 1986) {
    final t = y - 1975;
    return 45.45 + 1.067 * t - t * t / 260 - t * t * t / 718;
  } else if (y < 2005) {
    final t = y - 2000;
    return 63.86 +
        0.3345 * t -
        0.060374 * t * t +
        0.0017275 * t * t * t +
        0.000651814 * t * t * t * t +
        0.00002373599 * t * t * t * t * t;
  } else if (y < 2050) {
    final t = y - 2000;
    return 62.92 + 0.32217 * t + 0.005589 * t * t;
  } else if (y < 2150) {
    u = (y - 1820) / 100;
    return -20 + 32 * u * u - 0.5628 * (2150 - y);
  }
  u = (y - 1820) / 100;
  return -20 + 32 * u * u;
}

/// Julian Day in Terrestrial Time (UT advanced by ΔT) for the Meeus series.
double _ttJulianDay(DateTime dt) => julianDay(dt) + deltaTSeconds(dt) / 86400.0;

/// Normalize angle to 0-360
double _norm360(double deg) => deg % 360 + (deg < 0 ? 360 : 0);

/// Sun's ecliptic longitude in degrees (tropical), apparent of date.
/// Geometric longitude from VSOP87 (truncated, ~1-2"); aberration (-0.00569) and
/// nutation (-0.00478*sin Ω) kept so nutation cancels in the Moon-Sun elongation
/// and the Sun stays apparent. The generator's ourSun MUST mirror this exactly.
double sunLongitude(DateTime dt) {
  final jdTT = _ttJulianDay(dt);
  final t = _T(jdTT); // Julian centuries TT (for omega)
  final tau = (jdTT - 2451545.0) / 365250.0; // Julian millennia TT (for VSOP)
  double ser(List<List<double>> terms) {
    double s = 0;
    for (final x in terms) {
      s += x[0] * cos(x[1] + x[2] * tau);
    }
    return s;
  }

  // Earth heliocentric longitude (radians)
  final l = (ser(_vsopL0) +
          ser(_vsopL1) * tau +
          ser(_vsopL2) * tau * tau +
          ser(_vsopL3) * tau * tau * tau +
          ser(_vsopL4) * tau * tau * tau * tau) /
      1e8;
  // Geocentric Sun = Earth helio longitude + 180
  final geo = _norm360(l * _rad2deg + 180.0);
  final omega = 125.04 - 1934.136 * t;
  return _norm360(geo - 0.00569 - 0.00478 * sin(omega * _deg2rad));
}

// VSOP87D Earth longitude terms [A, B, C]; L = Σ A·cos(B + C·τ), τ in millennia.
// Truncated set (~1-2" over 1900-2100). Same tables MUST exist in the generator.
const _vsopL0 = <List<double>>[
  [175347046, 0, 0],
  [3341656, 4.6692568, 6283.07585],
  [34894, 4.6261, 12566.1517],
  [3497, 2.7441, 5753.3849],
  [3418, 2.8289, 3.5231],
  [3136, 3.6277, 77713.7715],
  [2676, 4.4181, 7860.4194],
  [2343, 6.1352, 3930.2097],
  [1324, 0.7425, 11506.7698],
  [1273, 2.0371, 529.691],
  [1199, 1.1096, 1577.3435],
  [990, 5.233, 5884.927],
  [902, 2.045, 26.298],
  [857, 3.508, 398.149],
  [780, 1.179, 5223.694],
  [753, 2.533, 5507.553],
  [505, 4.583, 18849.228],
  [492, 4.205, 775.523],
  [357, 2.920, 0.067],
  [317, 5.849, 11790.629],
  [284, 1.899, 796.298],
  [271, 0.315, 10977.079],
  [243, 0.345, 5486.778],
  [206, 4.806, 2544.314],
  [205, 1.869, 5573.143],
  [202, 2.458, 6069.777],
  [156, 0.833, 213.299],
  [132, 3.411, 2942.463],
  [126, 1.083, 20.775],
  [115, 0.645, 0.980],
  [103, 0.636, 4694.003],
  [102, 0.976, 15720.839],
  [102, 4.267, 7.114],
];
const _vsopL1 = <List<double>>[
  [628331966747, 0, 0],
  [206059, 2.678235, 6283.07585],
  [4303, 2.6351, 12566.1517],
  [425, 1.590, 3.523],
  [119, 5.796, 26.298],
  [109, 2.966, 1577.344],
  [93, 2.59, 18849.23],
  [72, 1.14, 529.69],
  [68, 1.87, 398.15],
  [67, 4.41, 5507.55],
  [59, 2.89, 5223.69],
  [56, 2.17, 155.42],
  [45, 0.40, 796.30],
  [36, 0.47, 775.52],
  [29, 2.65, 7.11],
  [21, 5.34, 0.98],
  [19, 1.85, 5486.78],
  [19, 4.97, 213.30],
  [17, 2.99, 6275.96],
  [16, 0.03, 2544.31],
];
const _vsopL2 = <List<double>>[
  [52919, 0, 0],
  [8720, 1.0721, 6283.0758],
  [309, 0.867, 12566.152],
  [27, 0.05, 3.52],
  [16, 5.19, 26.30],
  [16, 3.68, 155.42],
  [10, 0.76, 18849.23],
  [9, 2.06, 77713.77],
  [7, 0.83, 775.52],
  [5, 4.66, 1577.34],
];
const _vsopL3 = <List<double>>[
  [289, 5.844, 6283.076],
  [35, 0, 0],
  [17, 5.49, 12566.15],
];
const _vsopL4 = <List<double>>[
  [114, 3.142, 0],
];

/// Moon's ecliptic longitude in degrees (tropical). Meeus Ch. 47, full table.
double moonLongitude(DateTime dt) {
  final t = _T(_ttJulianDay(dt));
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

  // Apparent longitude: add the same Δψ main term the Sun uses, so nutation
  // cancels in the Moon−Sun elongation (tithi) and the Moon's absolute longitude
  // is apparent (correct for nakshatra/rasi).
  final omega = 125.04 - 1934.136 * t;
  final nutation = -0.00478 * sin(omega * _deg2rad);
  final moonLon = lp + sumL / 1000000.0 + nutation;
  return _norm360(moonLon);
}

/// Function type for computing sunrise as UTC DateTime for a given date.
typedef SunriseFn = DateTime Function(DateTime date);

/// City location for sunrise calculation.
class CityLocation {
  final double latitude; // degrees (positive = North)
  final double longitude; // degrees (positive = East)
  final double utcOffset; // standard time offset in hours

  /// Optional region/country qualifier for cities whose name collides with
  /// another well-known place (e.g. `'WA'` for Redmond, `'UK'` for Birmingham).
  /// Null for unambiguous cities. Used only for display (see [City.displayName]);
  /// it does not affect any calculation.
  final String? region;

  const CityLocation(this.latitude, this.longitude, this.utcOffset,
      {this.region});
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
