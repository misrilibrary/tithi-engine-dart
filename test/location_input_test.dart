import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/src/astronomy.dart' show lookupCityLocation;
import 'package:tithi_engine/data/all.dart';

void main() {
  setUpAll(registerAllCities);
  final p = Panchang([registerAllCities]);
  final date = DateTime.utc(2026, 1, 3);

  test('coordinates on a city cell == Location.city (Swiss-corrected)', () {
    final s = lookupCityLocation('Seattle');
    final byCity = p.at(Location.city('Seattle')).tithiOnDate(date);
    // exact stored coords, and a small offset that stays in the same 0.1° cell
    for (final pt in [
      Location.at(s.latitude, s.longitude),
      Location.at(s.latitude + 0.01, s.longitude - 0.01),
    ]) {
      expect(pt.source, LocationSource.cityCorrected);
      final byCoord = p.at(pt).tithiOnDate(date);
      expect(byCoord.tithiNumber, byCity.tithiNumber);
      expect(byCoord.displayName, byCity.displayName);
    }
  });

  test('coordinate matching a stored city reproduces the name result', () {
    final ny = lookupCityLocation('New York');
    final byCoord =
        p.at(Location.at(ny.latitude, ny.longitude)).tithiOnDate(date);
    final byName = p.tithiOnDate(date, City.of('New York'));
    expect(byCoord.displayName, byName.displayName);
  });

  test('off-grid coordinate is Meeus-only and requires an offset', () {
    // Mid-Pacific — no supported city cell.
    expect(() => Location.at(0.0, -140.0), throwsArgumentError);
    final raw = Location.at(0.0, -140.0, offset: const Duration(hours: -9));
    expect(raw.source, LocationSource.meeusRaw);
    final info = p.at(raw).tithiOnDate(date);
    expect(info.tithiNumber, inInclusiveRange(1, 30)); // computes via Meeus
  });

  test('Allahabad/Prayagraj alias resolve to the same corrected cell', () {
    final a = lookupCityLocation('Allahabad');
    final pr = lookupCityLocation('Prayagraj');
    expect(pr.latitude, a.latitude);
    expect(pr.longitude, a.longitude);
    expect(Location.at(a.latitude, a.longitude).source,
        LocationSource.cityCorrected);
  });
}
