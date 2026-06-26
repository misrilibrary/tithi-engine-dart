import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/src/astronomy.dart' show lookupCityLocation;
import 'package:tithi_engine/data/all.dart';

void main() {
  setUpAll(registerAllCities);

  test('case/space variants and qualified names resolve to the same city', () {
    expect(resolveCityName('New York'), 'New York');
    expect(resolveCityName('new york'), 'New York');
    expect(resolveCityName('NEWYORK'), 'New York');
    expect(resolveCityName('New York, NY'), 'New York'); // qualified form
  });

  test('homonyms: bare = primary city-region, qualified = specific, no fuzzy',
      () {
    // Today only Vancouver, BC exists.
    expect(resolveCityName('Vancouver'), 'Vancouver'); // bare -> primary (BC)
    expect(resolveCityName('Vancouver, BC'), 'Vancouver'); // qualified -> BC
    // A different region we don't have must NOT silently collapse to BC.
    expect(resolveCityName('Vancouver, WA'), isNull);
    // Redmond (WA) — exact qualified resolves; a wrong region does not.
    expect(resolveCityName('Redmond, WA'), 'Redmond');
    expect(resolveCityName('Redmond, XX'), isNull);
  });

  test('genuinely unknown -> null (no silent cross-city)', () {
    expect(resolveCityName('Nonexistent City'), isNull);
  });

  test('coords + corrections agree across spellings of a known city', () {
    final ny = lookupCityLocation('New York');
    expect(lookupCityLocation('New York, NY').latitude, ny.latitude);
    expect(lookupCityLocation('new york').longitude, ny.longitude);

    final p = Panchang([registerAllCities]);
    final a = p
        .tithiOnDate(DateTime.utc(2026, 1, 3), City.of('New York'))
        .tithiNumber;
    final b = p
        .tithiOnDate(DateTime.utc(2026, 1, 3), City.of('New York, NY'))
        .tithiNumber;
    final c = p
        .tithiOnDate(DateTime.utc(2026, 1, 3), City.of('new york'))
        .tithiNumber;
    expect(b, a);
    expect(c, a);
  });

  test('unsupported city -> throws ArgumentError (no silent substitution)', () {
    expect(() => lookupCityLocation('Nonexistent City'), throwsArgumentError);
    expect(() => lookupCityLocation('Vancouver, WA'), throwsArgumentError);
    expect(
        () => Panchang([registerAllCities])
            .tithiOnDate(DateTime.utc(2026, 1, 3), City.of('Nonexistent City')),
        throwsArgumentError);
  });
}
