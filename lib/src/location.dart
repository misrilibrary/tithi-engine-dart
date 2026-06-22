import 'cities.dart' show cityForCell, registerAdHocLocation;

/// Accuracy tier of a resolved [Location].
enum LocationSource {
  /// A registered city (or a coordinate that fell in a city's 0.1° cell) —
  /// Swiss-Ephemeris correction tables applied.
  cityCorrected,

  /// Raw coordinates outside every supported city's cell — pure Meeus
  /// astronomy (no correction table). ~99.97% accurate on day-assignment.
  meeusRaw,
}

/// A place to compute for: either a registered city, or raw coordinates.
///
/// Pass to `Panchang.at(...)`:
/// ```dart
/// panchang.at(Location.city('Seattle')).tithiOnDate(date);
/// panchang.at(Location.at(47.61, -122.33, offset: Duration(hours: -8)))
///     .tithiOnDate(date);
/// ```
///
/// Coordinate resolution uses the **0.1° cell** (cities are stored at ~11 km
/// precision): a point that rounds into a supported city's cell reuses that
/// city wholesale (its coords, stored offset, and corrections) and reports
/// [LocationSource.cityCorrected]; a point outside every cell is Meeus-only
/// ([LocationSource.meeusRaw]) and requires an [offset].
class Location {
  /// Opaque internal key the engine resolves to coordinates + corrections.
  /// (A registered city name for corrected locations, or an ad-hoc coordinate
  /// key for Meeus-only points.) Treat as opaque.
  final String key;

  /// Whether this location is Swiss-corrected or Meeus-only.
  final LocationSource source;

  const Location._(this.key, this.source);

  /// A registered city by name (case/space-insensitive, or `"City, Region"`).
  /// Throws [ArgumentError] on use if the name is not supported.
  factory Location.city(String name) =>
      Location._(name, LocationSource.cityCorrected);

  /// Raw coordinates. If ([lat],[lng]) rounds into a supported city's 0.1° cell
  /// that city is used wholesale (Swiss-corrected) and [offset] is ignored;
  /// otherwise the point is Meeus-only and [offset] (the DST-aware UTC offset)
  /// is **required**.
  factory Location.at(double lat, double lng, {Duration? offset}) {
    final hit = cityForCell(lat, lng);
    if (hit != null) return Location._(hit, LocationSource.cityCorrected);
    if (offset == null) {
      throw ArgumentError(
          'offset is required for coordinates outside every supported city '
          '(Meeus-only): pass the DST-aware UTC offset in effect.');
    }
    final key = registerAdHocLocation(lat, lng, offset.inMinutes / 60.0);
    return Location._(key, LocationSource.meeusRaw);
  }
}
