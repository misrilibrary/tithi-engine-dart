import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/src/cities.dart' show cityRegistry;

void main() {
  group('City.displayName (selective)', () {
    test('ambiguous cities get a region qualifier', () {
      expect(City.displayName('Redmond'), 'Redmond, WA');
      expect(City.displayName('Birmingham'), 'Birmingham, UK');
      expect(City.displayName('Vancouver'), 'Vancouver, BC');
      expect(City.displayName('Kochi'), 'Kochi, India');
      expect(City.displayName('Salem'), 'Salem, India');
      expect(City.displayName('San Jose'), 'San Jose, CA');
    });

    test('unambiguous cities stay bare even though they now have a region', () {
      expect(City.displayName('Delhi'), 'Delhi');
      expect(City.displayName('Seattle'), 'Seattle');
      expect(City.displayName('Tokyo'), 'Tokyo');
    });

    test('unknown names pass through', () {
      expect(City.displayName('Atlantis'), 'Atlantis');
    });
  });

  group('City.qualifiedName (always-on)', () {
    test('appends region/country for every city that has one', () {
      expect(City.qualifiedName('Seattle'), 'Seattle, WA');
      expect(City.qualifiedName('Toronto'), 'Toronto, ON');
      expect(City.qualifiedName('Tokyo'), 'Tokyo, Japan');
      expect(City.qualifiedName('Delhi'), 'Delhi, India');
      expect(City.qualifiedName('Redmond'), 'Redmond, WA');
      expect(City.qualifiedName('São Paulo'), 'São Paulo, Brazil');
    });

    test('self-qualifying / unknown names stay bare', () {
      expect(City.qualifiedName('Singapore'), 'Singapore');
      expect(City.qualifiedName('Hong Kong'), 'Hong Kong');
      expect(City.qualifiedName('Bahrain'), 'Bahrain');
      expect(City.qualifiedName('Washington DC'), 'Washington DC');
      expect(City.qualifiedName('Atlantis'), 'Atlantis');
    });
  });

  group('region data model', () {
    test('region is dense: only the 4 self-qualifying cities lack one', () {
      final noRegion =
          cityRegistry.entries.where((e) => e.value.region == null);
      expect(noRegion.map((e) => e.key).toSet(),
          {'Washington DC', 'Singapore', 'Hong Kong', 'Bahrain'});
    });

    test('displayName is a subset of qualifiedName for every city', () {
      for (final c in City.values) {
        final d = City.displayName(c);
        final q = City.qualifiedName(c);
        expect(d == c || d == q, isTrue, reason: 'displayName($c)=$d vs $q');
      }
    });

    test('region does not affect coordinates', () {
      expect(cityRegistry['Redmond']!.latitude, closeTo(47.7, 0.01));
      expect(cityRegistry['Redmond']!.longitude, closeTo(-122.1, 0.01));
    });
  });
}
