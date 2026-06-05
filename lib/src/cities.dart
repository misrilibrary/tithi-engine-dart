import 'astronomy.dart' show CityLocation;

/// The single default reference city used wherever no city is specified
/// (month/tithi resolution, sunrise, UI defaults). Change this one value to
/// swap the app-wide default. Must exist in [supportedCities].
const defaultCity = 'Ujjain';

/// Priority cities shown at the top of dropdowns (above all groups).
const pinnedCities = [
  'Amsterdam',
  'Boston',
  'Dallas',
  'Delhi',
  'Dubai',
  'Jammu',
  'London',
  'Mumbai',
  'Muscat',
  'Noida',
  'Pune',
  'Seattle',
  'Srinagar',
  'Ujjain',
];

/// All supported cities for tithi calculation.
/// To add a city: add an entry here, then generate its correction table
/// (tools/benchmark/bin/gen_city_corrections.dart) and run test/gen_registry.dart.
const supportedCities = <String, CityLocation>{
  // ─── India ───
  'Delhi': CityLocation(28.6, 77.2, 5.5),
  'Mumbai': CityLocation(19.1, 72.9, 5.5),
  'Kolkata': CityLocation(22.6, 88.4, 5.5),
  'Chennai': CityLocation(13.1, 80.3, 5.5),
  'Srinagar': CityLocation(34.1, 74.8, 5.5),
  'Bangalore': CityLocation(12.9, 77.6, 5.5),
  'Hyderabad': CityLocation(17.4, 78.5, 5.5),
  'Pune': CityLocation(18.5, 73.9, 5.5),
  'Ahmedabad': CityLocation(23.0, 72.6, 5.5),
  'Jaipur': CityLocation(26.9, 75.8, 5.5),
  'Lucknow': CityLocation(26.8, 81.0, 5.5),
  'Chandigarh': CityLocation(30.7, 76.8, 5.5),
  'Jammu': CityLocation(32.7, 74.9, 5.5),
  'Indore': CityLocation(22.7, 75.9, 5.5),
  'Ujjain': CityLocation(23.2, 75.8, 5.5),
  'Bhopal': CityLocation(23.3, 77.4, 5.5),
  'Nagpur': CityLocation(21.1, 79.1, 5.5),
  'Patna': CityLocation(25.6, 85.1, 5.5),
  'Kochi': CityLocation(10.0, 76.3, 5.5),
  'Guwahati': CityLocation(26.1, 91.7, 5.5),
  'Varanasi': CityLocation(25.3, 83.0, 5.5),
  'Amritsar': CityLocation(31.6, 74.9, 5.5),
  'Dehradun': CityLocation(30.3, 78.0, 5.5),
  'Thiruvananthapuram': CityLocation(8.5, 76.9, 5.5),
  'Coimbatore': CityLocation(11.0, 76.9, 5.5),
  'Visakhapatnam': CityLocation(17.7, 83.3, 5.5),
  'Mangalore': CityLocation(12.9, 74.9, 5.5),
  'Mysore': CityLocation(12.3, 76.7, 5.5),
  'Noida': CityLocation(28.6, 77.3, 5.5),
  'Gurgaon': CityLocation(28.5, 77.0, 5.5),

  // ─── USA ───
  'Seattle': CityLocation(47.6, -122.3, -8.0),
  'Kirkland': CityLocation(47.7, -122.2, -8.0),
  'San Francisco': CityLocation(37.8, -122.4, -8.0),
  'Fremont': CityLocation(37.5, -122.0, -8.0),
  'San Jose': CityLocation(37.3, -121.9, -8.0),
  'Los Angeles': CityLocation(34.1, -118.2, -8.0),
  'Dallas': CityLocation(32.8, -96.8, -6.0),
  'Austin': CityLocation(30.3, -97.7, -6.0),
  'Houston': CityLocation(29.8, -95.4, -6.0),
  'Boston': CityLocation(42.4, -71.1, -5.0),
  'New York': CityLocation(40.7, -74.0, -5.0),
  'Chicago': CityLocation(41.9, -87.6, -6.0),
  'Atlanta': CityLocation(33.7, -84.4, -5.0),
  'Orlando': CityLocation(28.5, -81.4, -5.0),
  'Denver': CityLocation(39.7, -105.0, -7.0),
  'Phoenix': CityLocation(33.4, -112.1, -7.0),
  'Washington DC': CityLocation(38.9, -77.0, -5.0),
  'Miami': CityLocation(25.8, -80.2, -5.0),
  'Portland': CityLocation(45.5, -122.7, -8.0),
  'Minneapolis': CityLocation(44.9, -93.3, -6.0),
  'Detroit': CityLocation(42.3, -83.0, -5.0),
  'Philadelphia': CityLocation(40.0, -75.2, -5.0),
  'San Diego': CityLocation(32.7, -117.2, -8.0),
  'Raleigh': CityLocation(35.8, -78.6, -5.0),

  // ─── Canada ───
  'Toronto': CityLocation(43.7, -79.4, -5.0),
  'Vancouver': CityLocation(49.3, -123.1, -8.0),
  'Montreal': CityLocation(45.5, -73.6, -5.0),
  'Calgary': CityLocation(51.0, -114.1, -7.0),
  'Ottawa': CityLocation(45.4, -75.7, -5.0),

  // ─── UK & Europe ───
  'London': CityLocation(51.5, -0.1, 0.0),
  'Berlin': CityLocation(52.5, 13.4, 1.0),
  'Amsterdam': CityLocation(52.4, 4.9, 1.0),
  'Paris': CityLocation(48.9, 2.3, 1.0),
  'Dublin': CityLocation(53.3, -6.3, 0.0),
  'Munich': CityLocation(48.1, 11.6, 1.0),
  'Zurich': CityLocation(47.4, 8.5, 1.0),
  'Stockholm': CityLocation(59.3, 18.1, 1.0),
  'Helsinki': CityLocation(60.2, 24.9, 2.0),
  'Warsaw': CityLocation(52.2, 21.0, 1.0),
  'Vienna': CityLocation(48.2, 16.4, 1.0),
  'Prague': CityLocation(50.1, 14.4, 1.0),
  'Milan': CityLocation(45.5, 9.2, 1.0),
  'Barcelona': CityLocation(41.4, 2.2, 1.0),
  'Lisbon': CityLocation(38.7, -9.1, 0.0),

  // ─── Middle East ───
  'Dubai': CityLocation(25.2, 55.3, 4.0),
  'Muscat': CityLocation(23.6, 58.5, 4.0),
  'Doha': CityLocation(25.3, 51.5, 3.0),
  'Riyadh': CityLocation(24.7, 46.7, 3.0),
  'Kuwait City': CityLocation(29.4, 47.9, 3.0),
  'Bahrain': CityLocation(26.2, 50.6, 3.0),
  'Tel Aviv': CityLocation(32.1, 34.8, 2.0),

  // ─── Asia Pacific ───
  'Singapore': CityLocation(1.4, 103.8, 8.0),
  'Tokyo': CityLocation(35.7, 139.7, 9.0),
  'Hong Kong': CityLocation(22.3, 114.2, 8.0),
  'Kuala Lumpur': CityLocation(3.1, 101.7, 8.0),
  'Bangkok': CityLocation(13.8, 100.5, 7.0),
  'Jakarta': CityLocation(-6.2, 106.8, 7.0),
  'Seoul': CityLocation(37.6, 127.0, 9.0),
  'Taipei': CityLocation(25.0, 121.5, 8.0),
  'Manila': CityLocation(14.6, 121.0, 8.0),
  'Ho Chi Minh City': CityLocation(10.8, 106.6, 7.0),
  'Kathmandu': CityLocation(27.7, 85.3, 5.75),
  'Colombo': CityLocation(6.9, 79.9, 5.5),
  'Dhaka': CityLocation(23.8, 90.4, 6.0),

  // ─── Australia & NZ ───
  'Sydney': CityLocation(-33.9, 151.2, 10.0),
  'Melbourne': CityLocation(-37.8, 145.0, 10.0),
  'Brisbane': CityLocation(-27.5, 153.0, 10.0),
  'Perth': CityLocation(-31.9, 115.9, 8.0),
  'Auckland': CityLocation(-36.8, 174.8, 12.0),

  // ─── Africa ───
  'Nairobi': CityLocation(-1.3, 36.8, 3.0),
  'Cape Town': CityLocation(-33.9, 18.4, 2.0),
  'Lagos': CityLocation(6.5, 3.4, 1.0),
  'Cairo': CityLocation(30.0, 31.2, 2.0),
  'Johannesburg': CityLocation(-26.2, 28.0, 2.0),

  // ─── South America ───
  'São Paulo': CityLocation(-23.5, -46.6, -3.0),
  'Buenos Aires': CityLocation(-34.6, -58.4, -3.0),
  'Bogotá': CityLocation(4.7, -74.1, -5.0),
  'Lima': CityLocation(-12.0, -77.0, -5.0),
  'Santiago': CityLocation(-33.4, -70.6, -4.0),
  // India Tier 2
  'Agra': CityLocation(27.2, 78.0, 5.5),
  'Allahabad': CityLocation(25.4, 81.8, 5.5),
  'Aurangabad': CityLocation(19.9, 75.3, 5.5),
  'Bhubaneswar': CityLocation(20.3, 85.8, 5.5),
  'Faridabad': CityLocation(28.4, 77.3, 5.5),
  'Ghaziabad': CityLocation(28.7, 77.4, 5.5),
  'Gorakhpur': CityLocation(26.8, 83.4, 5.5),
  'Gwalior': CityLocation(26.2, 78.2, 5.5),
  'Hubli': CityLocation(15.4, 75.1, 5.5),
  'Jabalpur': CityLocation(23.2, 79.9, 5.5),
  'Jalandhar': CityLocation(31.3, 75.6, 5.5),
  'Jodhpur': CityLocation(26.3, 73.0, 5.5),
  'Kanpur': CityLocation(26.4, 80.3, 5.5),
  'Kota': CityLocation(25.2, 75.9, 5.5),
  'Ludhiana': CityLocation(30.9, 75.9, 5.5),
  'Madurai': CityLocation(9.9, 78.1, 5.5),
  'Meerut': CityLocation(29.0, 77.7, 5.5),
  'Nashik': CityLocation(20.0, 73.8, 5.5),
  'Raipur': CityLocation(21.3, 81.6, 5.5),
  'Rajkot': CityLocation(22.3, 70.8, 5.5),
  'Ranchi': CityLocation(23.3, 85.3, 5.5),
  'Salem': CityLocation(11.7, 78.2, 5.5),
  'Surat': CityLocation(21.2, 72.8, 5.5),
  'Thane': CityLocation(19.2, 73.0, 5.5),
  'Tiruchirappalli': CityLocation(10.8, 78.7, 5.5),
  'Tirupati': CityLocation(13.6, 79.4, 5.5),
  'Udaipur': CityLocation(24.6, 73.7, 5.5),
  'Vadodara': CityLocation(22.3, 73.2, 5.5),
  'Vijayawada': CityLocation(16.5, 80.6, 5.5),
  'Warangal': CityLocation(18.0, 79.6, 5.5),
  // Pilgrimage cities
  'Mussoorie': CityLocation(30.5, 78.1, 5.5),
  'Rishikesh': CityLocation(30.1, 78.3, 5.5),
  'Haridwar': CityLocation(29.9, 78.2, 5.5),
  'Mathura': CityLocation(27.5, 77.7, 5.5),
  'Vrindavan': CityLocation(27.6, 77.7, 5.5),
  'Ayodhya': CityLocation(26.8, 82.2, 5.5),
  'Prayagraj': CityLocation(25.4, 81.8, 5.5),
  'Dwarka': CityLocation(22.2, 69.0, 5.5),
  'Shirdi': CityLocation(19.8, 74.5, 5.5),
  // World cities
  'Moscow': CityLocation(55.8, 37.6, 3.0),
  'Istanbul': CityLocation(41.0, 29.0, 3.0),
  'Beijing': CityLocation(39.9, 116.4, 8.0),
  'Shanghai': CityLocation(31.2, 121.5, 8.0),
  'Osaka': CityLocation(34.7, 135.5, 9.0),
  'Mexico City': CityLocation(19.4, -99.1, -6.0),
  'Edinburgh': CityLocation(55.9, -3.2, 0.0),
  'Manchester': CityLocation(53.5, -2.2, 0.0),
  'Birmingham': CityLocation(52.5, -1.9, 0.0),
};

/// India cities (UTC +5.5) for grouping.
const _indiaCities = {
  // Metros / tier-1
  'Delhi', 'Mumbai', 'Kolkata', 'Chennai', 'Srinagar', 'Bangalore', 'Hyderabad',
  'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow', 'Chandigarh', 'Jammu', 'Indore',
  'Ujjain',
  'Bhopal', 'Nagpur', 'Patna', 'Kochi', 'Guwahati', 'Varanasi', 'Amritsar',
  'Dehradun', 'Thiruvananthapuram', 'Coimbatore', 'Visakhapatnam', 'Mangalore',
  'Mysore', 'Noida', 'Gurgaon',
  // Tier-2
  'Agra', 'Allahabad', 'Aurangabad', 'Bhubaneswar', 'Faridabad', 'Ghaziabad',
  'Gorakhpur', 'Gwalior', 'Hubli', 'Jabalpur', 'Jalandhar', 'Jodhpur', 'Kanpur',
  'Kota', 'Ludhiana', 'Madurai', 'Meerut', 'Nashik', 'Raipur', 'Rajkot',
  'Ranchi',
  'Salem', 'Surat', 'Thane', 'Tiruchirappalli', 'Tirupati', 'Udaipur',
  'Vadodara',
  'Vijayawada', 'Warangal',
  // Pilgrimage
  'Mussoorie', 'Rishikesh', 'Haridwar', 'Mathura', 'Vrindavan', 'Ayodhya',
  'Prayagraj', 'Dwarka', 'Shirdi',
};

/// US cities for grouping.
const _usaCities = {
  'Seattle',
  'Kirkland',
  'San Francisco',
  'Fremont',
  'San Jose',
  'Los Angeles',
  'Dallas',
  'Austin',
  'Houston',
  'Boston',
  'New York',
  'Chicago',
  'Atlanta',
  'Orlando',
  'Denver',
  'Phoenix',
  'Washington DC',
  'Miami',
  'Portland',
  'Minneapolis',
  'Detroit',
  'Philadelphia',
  'San Diego',
  'Raleigh',
};

/// Returns ordered city names: priority → India → US → rest of world.
/// Each group (except priority) is alphabetically sorted.
/// Null entries are divider markers between groups.
List<String?> get orderedCityList {
  final india = supportedCities.keys
      .where((c) => _indiaCities.contains(c) && !pinnedCities.contains(c))
      .toList()
    ..sort();
  final usa = supportedCities.keys
      .where((c) => _usaCities.contains(c) && !pinnedCities.contains(c))
      .toList()
    ..sort();
  final rest = supportedCities.keys
      .where((c) =>
          !_indiaCities.contains(c) &&
          !_usaCities.contains(c) &&
          !pinnedCities.contains(c))
      .toList()
    ..sort();
  return [
    ...pinnedCities,
    null, // divider
    ...india,
    null, // divider
    ...usa,
    null, // divider
    ...rest,
  ];
}

/// Convenience constants for commonly used city names.
/// All cities in [supportedCities] can also be used as plain strings.
abstract class City {
  static const ujjain = 'Ujjain';
  static const srinagar = 'Srinagar';
  static const delhi = 'Delhi';
  static const mumbai = 'Mumbai';
  static const kolkata = 'Kolkata';
  static const chennai = 'Chennai';
  static const bangalore = 'Bangalore';
  static const hyderabad = 'Hyderabad';
  static const pune = 'Pune';
  static const jaipur = 'Jaipur';
  static const seattle = 'Seattle';
  static const london = 'London';
  static const newyork = 'New York';
  static const sanfrancisco = 'San Francisco';
  static const losangeles = 'Los Angeles';
  static const chicago = 'Chicago';
  static const toronto = 'Toronto';
  static const dubai = 'Dubai';
  static const singapore = 'Singapore';
  static const tokyo = 'Tokyo';
  static const sydney = 'Sydney';

  /// All supported city names.
  static List<String> get values => supportedCities.keys.toList();
}
