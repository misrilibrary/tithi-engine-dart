import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/src/astronomy.dart' show lookupCityLocation;
import 'package:tithi_engine/data/all.dart';

void main() {
  final p = Panchang([registerAllCities]);
  final d = DateTime.utc(2026, 6, 22);

  test('sunrise is before sunset; both at sensible local times (New York)', () {
    final sr = p.sunrise(d, City.of('New York'));
    final ss = p.sunset(d, City.of('New York'));
    expect(sr.isBefore(ss), true);
    final srLocal = sr.add(const Duration(hours: -4)); // EDT
    final ssLocal = ss.add(const Duration(hours: -4));
    expect(srLocal.hour, inInclusiveRange(4, 7)); // ~5:25 AM
    expect(ssLocal.hour, inInclusiveRange(19, 21)); // ~8:31 PM
  });

  test('coords on a city cell give the same sun times as the named city', () {
    final ny = lookupCityLocation('New York');
    expect(p.at(Location.at(ny.latitude, ny.longitude)).sunrise(d),
        p.sunrise(d, City.of('New York')));
    expect(p.at(Location.at(ny.latitude, ny.longitude)).sunset(d),
        p.sunset(d, City.of('New York')));
  });

  test('unsupported city throws', () {
    expect(() => p.sunrise(d, City.of('Nowhere')), throwsArgumentError);
    expect(() => p.sunset(d, City.of('Nowhere')), throwsArgumentError);
  });
}
