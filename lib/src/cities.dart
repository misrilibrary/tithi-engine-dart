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
  'Delhi': CityLocation(28.6, 77.2, 5.5, region: 'India'),
  'Mumbai': CityLocation(19.1, 72.9, 5.5, region: 'India'),
  'Kolkata': CityLocation(22.6, 88.4, 5.5, region: 'India'),
  'Chennai': CityLocation(13.1, 80.3, 5.5, region: 'India'),
  'Srinagar': CityLocation(34.1, 74.8, 5.5, region: 'India'),
  'Bangalore': CityLocation(12.9, 77.6, 5.5, region: 'India'),
  'Hyderabad': CityLocation(17.4, 78.5, 5.5, region: 'India'),
  'Pune': CityLocation(18.5, 73.9, 5.5, region: 'India'),
  'Ahmedabad': CityLocation(23.0, 72.6, 5.5, region: 'India'),
  'Jaipur': CityLocation(26.9, 75.8, 5.5, region: 'India'),
  'Lucknow': CityLocation(26.8, 81.0, 5.5, region: 'India'),
  'Chandigarh': CityLocation(30.7, 76.8, 5.5, region: 'India'),
  'Jammu': CityLocation(32.7, 74.9, 5.5, region: 'India'),
  'Indore': CityLocation(22.7, 75.9, 5.5, region: 'India'),
  'Ujjain': CityLocation(23.2, 75.8, 5.5, region: 'India'),
  'Bhopal': CityLocation(23.3, 77.4, 5.5, region: 'India'),
  'Nagpur': CityLocation(21.1, 79.1, 5.5, region: 'India'),
  'Patna': CityLocation(25.6, 85.1, 5.5, region: 'India'),
  'Kochi': CityLocation(10.0, 76.3, 5.5, region: 'India'),
  'Guwahati': CityLocation(26.1, 91.7, 5.5, region: 'India'),
  'Varanasi': CityLocation(25.3, 83.0, 5.5, region: 'India'),
  'Amritsar': CityLocation(31.6, 74.9, 5.5, region: 'India'),
  'Dehradun': CityLocation(30.3, 78.0, 5.5, region: 'India'),
  'Thiruvananthapuram': CityLocation(8.5, 76.9, 5.5, region: 'India'),
  'Coimbatore': CityLocation(11.0, 76.9, 5.5, region: 'India'),
  'Visakhapatnam': CityLocation(17.7, 83.3, 5.5, region: 'India'),
  'Mangalore': CityLocation(12.9, 74.9, 5.5, region: 'India'),
  'Mysore': CityLocation(12.3, 76.7, 5.5, region: 'India'),
  'Noida': CityLocation(28.6, 77.3, 5.5, region: 'India'),
  'Gurgaon': CityLocation(28.5, 77.0, 5.5, region: 'India'),

  // ─── USA ───
  'Seattle': CityLocation(47.6, -122.3, -8.0, region: 'WA'),
  'Kirkland': CityLocation(47.7, -122.2, -8.0, region: 'WA'),
  'San Francisco': CityLocation(37.8, -122.4, -8.0, region: 'CA'),
  'Fremont': CityLocation(37.5, -122.0, -8.0, region: 'CA'),
  'San Jose': CityLocation(37.3, -121.9, -8.0, region: 'CA'),
  'Los Angeles': CityLocation(34.1, -118.2, -8.0, region: 'CA'),
  'Dallas': CityLocation(32.8, -96.8, -6.0, region: 'TX'),
  'Austin': CityLocation(30.3, -97.7, -6.0, region: 'TX'),
  'Houston': CityLocation(29.8, -95.4, -6.0, region: 'TX'),
  'Boston': CityLocation(42.4, -71.1, -5.0, region: 'MA'),
  'New York': CityLocation(40.7, -74.0, -5.0, region: 'NY'),
  'Chicago': CityLocation(41.9, -87.6, -6.0, region: 'IL'),
  'Atlanta': CityLocation(33.7, -84.4, -5.0, region: 'GA'),
  'Orlando': CityLocation(28.5, -81.4, -5.0, region: 'FL'),
  'Denver': CityLocation(39.7, -105.0, -7.0, region: 'CO'),
  'Phoenix': CityLocation(33.4, -112.1, -7.0, region: 'AZ'),
  'Washington DC': CityLocation(38.9, -77.0, -5.0),
  'Miami': CityLocation(25.8, -80.2, -5.0, region: 'FL'),
  'Portland': CityLocation(45.5, -122.7, -8.0, region: 'OR'),
  'Minneapolis': CityLocation(44.9, -93.3, -6.0, region: 'MN'),
  'Detroit': CityLocation(42.3, -83.0, -5.0, region: 'MI'),
  'Philadelphia': CityLocation(40.0, -75.2, -5.0, region: 'PA'),
  'San Diego': CityLocation(32.7, -117.2, -8.0, region: 'CA'),
  'Raleigh': CityLocation(35.8, -78.6, -5.0, region: 'NC'),

  // ─── Canada ───
  'Toronto': CityLocation(43.7, -79.4, -5.0, region: 'ON'),
  'Vancouver': CityLocation(49.3, -123.1, -8.0, region: 'BC'),
  'Montreal': CityLocation(45.5, -73.6, -5.0, region: 'QC'),
  'Calgary': CityLocation(51.0, -114.1, -7.0, region: 'AB'),
  'Ottawa': CityLocation(45.4, -75.7, -5.0, region: 'ON'),

  // ─── UK & Europe ───
  'London': CityLocation(51.5, -0.1, 0.0, region: 'UK'),
  'Berlin': CityLocation(52.5, 13.4, 1.0, region: 'Germany'),
  'Amsterdam': CityLocation(52.4, 4.9, 1.0, region: 'Netherlands'),
  'Paris': CityLocation(48.9, 2.3, 1.0, region: 'France'),
  'Dublin': CityLocation(53.3, -6.3, 0.0, region: 'Ireland'),
  'Munich': CityLocation(48.1, 11.6, 1.0, region: 'Germany'),
  'Zurich': CityLocation(47.4, 8.5, 1.0, region: 'Switzerland'),
  'Stockholm': CityLocation(59.3, 18.1, 1.0, region: 'Sweden'),
  'Helsinki': CityLocation(60.2, 24.9, 2.0, region: 'Finland'),
  'Warsaw': CityLocation(52.2, 21.0, 1.0, region: 'Poland'),
  'Vienna': CityLocation(48.2, 16.4, 1.0, region: 'Austria'),
  'Prague': CityLocation(50.1, 14.4, 1.0, region: 'Czechia'),
  'Milan': CityLocation(45.5, 9.2, 1.0, region: 'Italy'),
  'Barcelona': CityLocation(41.4, 2.2, 1.0, region: 'Spain'),
  'Lisbon': CityLocation(38.7, -9.1, 0.0, region: 'Portugal'),

  // ─── Middle East ───
  'Dubai': CityLocation(25.2, 55.3, 4.0, region: 'UAE'),
  'Muscat': CityLocation(23.6, 58.5, 4.0, region: 'Oman'),
  'Doha': CityLocation(25.3, 51.5, 3.0, region: 'Qatar'),
  'Riyadh': CityLocation(24.7, 46.7, 3.0, region: 'Saudi Arabia'),
  'Kuwait City': CityLocation(29.4, 47.9, 3.0, region: 'Kuwait'),
  'Bahrain': CityLocation(26.2, 50.6, 3.0),
  'Tel Aviv': CityLocation(32.1, 34.8, 2.0, region: 'Israel'),

  // ─── Asia Pacific ───
  'Singapore': CityLocation(1.4, 103.8, 8.0),
  'Tokyo': CityLocation(35.7, 139.7, 9.0, region: 'Japan'),
  'Hong Kong': CityLocation(22.3, 114.2, 8.0),
  'Kuala Lumpur': CityLocation(3.1, 101.7, 8.0, region: 'Malaysia'),
  'Bangkok': CityLocation(13.8, 100.5, 7.0, region: 'Thailand'),
  'Jakarta': CityLocation(-6.2, 106.8, 7.0, region: 'Indonesia'),
  'Seoul': CityLocation(37.6, 127.0, 9.0, region: 'South Korea'),
  'Taipei': CityLocation(25.0, 121.5, 8.0, region: 'Taiwan'),
  'Manila': CityLocation(14.6, 121.0, 8.0, region: 'Philippines'),
  'Ho Chi Minh City': CityLocation(10.8, 106.6, 7.0, region: 'Vietnam'),
  'Kathmandu': CityLocation(27.7, 85.3, 5.75, region: 'Nepal'),
  'Colombo': CityLocation(6.9, 79.9, 5.5, region: 'Sri Lanka'),
  'Dhaka': CityLocation(23.8, 90.4, 6.0, region: 'Bangladesh'),

  // ─── Australia & NZ ───
  'Sydney': CityLocation(-33.9, 151.2, 10.0, region: 'Australia'),
  'Melbourne': CityLocation(-37.8, 145.0, 10.0, region: 'Australia'),
  'Brisbane': CityLocation(-27.5, 153.0, 10.0, region: 'Australia'),
  'Perth': CityLocation(-31.9, 115.9, 8.0, region: 'Australia'),
  'Auckland': CityLocation(-36.8, 174.8, 12.0, region: 'New Zealand'),

  // ─── Africa ───
  'Nairobi': CityLocation(-1.3, 36.8, 3.0, region: 'Kenya'),
  'Cape Town': CityLocation(-33.9, 18.4, 2.0, region: 'South Africa'),
  'Lagos': CityLocation(6.5, 3.4, 1.0, region: 'Nigeria'),
  'Cairo': CityLocation(30.0, 31.2, 2.0, region: 'Egypt'),
  'Johannesburg': CityLocation(-26.2, 28.0, 2.0, region: 'South Africa'),

  // ─── South America ───
  'São Paulo': CityLocation(-23.5, -46.6, -3.0, region: 'Brazil'),
  'Buenos Aires': CityLocation(-34.6, -58.4, -3.0, region: 'Argentina'),
  'Bogotá': CityLocation(4.7, -74.1, -5.0, region: 'Colombia'),
  'Lima': CityLocation(-12.0, -77.0, -5.0, region: 'Peru'),
  'Santiago': CityLocation(-33.4, -70.6, -4.0, region: 'Chile'),

  // ─── Pakistan ───
  'Karachi': CityLocation(24.9, 67.0, 5.0, region: 'Pakistan'),
  'Lahore': CityLocation(31.5, 74.3, 5.0, region: 'Pakistan'),
  'Islamabad': CityLocation(33.7, 73.0, 5.0, region: 'Pakistan'),

  // ─── Caribbean & Central America ───
  'Port of Spain': CityLocation(10.7, -61.5, -4.0, region: 'Trinidad'),
  'Georgetown': CityLocation(6.8, -58.2, -4.0, region: 'Guyana'),
  'Paramaribo': CityLocation(5.9, -55.2, -3.0, region: 'Suriname'),
  'Kingston': CityLocation(18.0, -76.8, -5.0, region: 'Jamaica'),
  'Panama City': CityLocation(9.0, -79.5, -5.0, region: 'Panama'),

  // ─── Africa (additional) ───
  'Durban': CityLocation(-29.9, 31.0, 2.0, region: 'South Africa'),
  'Port Louis': CityLocation(-20.2, 57.5, 4.0, region: 'Mauritius'),
  'Dar es Salaam': CityLocation(-6.8, 39.3, 3.0, region: 'Tanzania'),
  'Accra': CityLocation(5.6, -0.2, 0.0, region: 'Ghana'),
  'Addis Ababa': CityLocation(9.0, 38.7, 3.0, region: 'Ethiopia'),
  'Kampala': CityLocation(0.3, 32.6, 3.0, region: 'Uganda'),
  'Mombasa': CityLocation(-4.1, 39.7, 3.0, region: 'Kenya'),

  // ─── Pacific Islands ───
  'Suva': CityLocation(-18.1, 178.4, 12.0, region: 'Fiji'),

  // ─── Europe (additional) ───
  'Leicester': CityLocation(52.6, -1.1, 0.0, region: 'UK'),
  'Glasgow': CityLocation(55.9, -4.3, 0.0, region: 'UK'),
  'Bucharest': CityLocation(44.4, 26.1, 2.0, region: 'Romania'),
  'Athens': CityLocation(37.9, 23.7, 2.0, region: 'Greece'),
  'Rome': CityLocation(41.9, 12.5, 1.0, region: 'Italy'),
  'Madrid': CityLocation(40.4, -3.7, 1.0, region: 'Spain'),
  'Budapest': CityLocation(47.5, 19.0, 1.0, region: 'Hungary'),
  'Brussels': CityLocation(50.9, 4.4, 1.0, region: 'Belgium'),
  'Sofia': CityLocation(42.7, 23.3, 2.0, region: 'Bulgaria'),
  'Kyiv': CityLocation(50.4, 30.5, 2.0, region: 'Ukraine'),
  'Oslo': CityLocation(59.9, 10.8, 1.0, region: 'Norway'),
  'Copenhagen': CityLocation(55.7, 12.6, 1.0, region: 'Denmark'),

  // ─── Canada (additional) ───
  'Brampton': CityLocation(43.7, -79.8, -5.0, region: 'ON'),
  'Edmonton': CityLocation(53.5, -113.5, -7.0, region: 'AB'),
  'Winnipeg': CityLocation(49.9, -97.1, -6.0, region: 'MB'),
  'Surrey': CityLocation(49.2, -122.8, -8.0, region: 'BC'),
  'Mississauga': CityLocation(43.6, -79.7, -5.0, region: 'ON'),

  // ─── USA (additional) ───
  'Las Vegas': CityLocation(36.2, -115.2, -8.0, region: 'NV'),
  'Salt Lake City': CityLocation(40.8, -111.9, -7.0, region: 'UT'),
  'Nashville': CityLocation(36.2, -86.8, -6.0, region: 'TN'),
  'Charlotte': CityLocation(35.2, -80.8, -5.0, region: 'NC'),

  // ─── Middle East (additional) ───
  'Abu Dhabi': CityLocation(24.5, 54.4, 4.0, region: 'UAE'),
  'Jeddah': CityLocation(21.5, 39.2, 3.0, region: 'Saudi Arabia'),
  'Amman': CityLocation(31.9, 35.9, 2.0, region: 'Jordan'),

  // ─── Central Asia ───
  'Tashkent': CityLocation(41.3, 69.3, 5.0, region: 'Uzbekistan'),
  'Almaty': CityLocation(43.2, 76.9, 6.0, region: 'Kazakhstan'),

  // ─── SE Asia (additional) ───
  'Hanoi': CityLocation(21.0, 105.9, 7.0, region: 'Vietnam'),
  'Yangon': CityLocation(16.9, 96.2, 6.5, region: 'Myanmar'),
  'Phnom Penh': CityLocation(11.6, 104.9, 7.0, region: 'Cambodia'),
  'Denpasar': CityLocation(-8.7, 115.2, 8.0, region: 'Indonesia'),

  // ─── Oceania (additional) ───
  'Adelaide': CityLocation(-34.9, 138.6, 9.5, region: 'Australia'),
  'Canberra': CityLocation(-35.3, 149.1, 10.0, region: 'Australia'),
  'Wellington': CityLocation(-41.3, 174.8, 12.0, region: 'New Zealand'),

  // ─── South America (additional) ───
  'Rio de Janeiro': CityLocation(-22.9, -43.2, -3.0, region: 'Brazil'),
  'Medellín': CityLocation(6.2, -75.6, -5.0, region: 'Colombia'),
  'Quito': CityLocation(-0.2, -78.5, -5.0, region: 'Ecuador'),

  // India Tier 2
  'Agra': CityLocation(27.2, 78.0, 5.5, region: 'India'),
  'Allahabad': CityLocation(25.4, 81.8, 5.5, region: 'India'),
  'Aurangabad': CityLocation(19.9, 75.3, 5.5, region: 'India'),
  'Bhubaneswar': CityLocation(20.3, 85.8, 5.5, region: 'India'),
  'Faridabad': CityLocation(28.4, 77.3, 5.5, region: 'India'),
  'Ghaziabad': CityLocation(28.7, 77.4, 5.5, region: 'India'),
  'Gorakhpur': CityLocation(26.8, 83.4, 5.5, region: 'India'),
  'Gwalior': CityLocation(26.2, 78.2, 5.5, region: 'India'),
  'Hubli': CityLocation(15.4, 75.1, 5.5, region: 'India'),
  'Jabalpur': CityLocation(23.2, 79.9, 5.5, region: 'India'),
  'Jalandhar': CityLocation(31.3, 75.6, 5.5, region: 'India'),
  'Jodhpur': CityLocation(26.3, 73.0, 5.5, region: 'India'),
  'Kanpur': CityLocation(26.4, 80.3, 5.5, region: 'India'),
  'Kota': CityLocation(25.2, 75.9, 5.5, region: 'India'),
  'Ludhiana': CityLocation(30.9, 75.9, 5.5, region: 'India'),
  'Madurai': CityLocation(9.9, 78.1, 5.5, region: 'India'),
  'Meerut': CityLocation(29.0, 77.7, 5.5, region: 'India'),
  'Nashik': CityLocation(20.0, 73.8, 5.5, region: 'India'),
  'Raipur': CityLocation(21.3, 81.6, 5.5, region: 'India'),
  'Rajkot': CityLocation(22.3, 70.8, 5.5, region: 'India'),
  'Ranchi': CityLocation(23.3, 85.3, 5.5, region: 'India'),
  'Salem': CityLocation(11.7, 78.2, 5.5, region: 'India'),
  'Surat': CityLocation(21.2, 72.8, 5.5, region: 'India'),
  'Thane': CityLocation(19.2, 73.0, 5.5, region: 'India'),
  'Tiruchirappalli': CityLocation(10.8, 78.7, 5.5, region: 'India'),
  'Tirupati': CityLocation(13.6, 79.4, 5.5, region: 'India'),
  'Udaipur': CityLocation(24.6, 73.7, 5.5, region: 'India'),
  'Vadodara': CityLocation(22.3, 73.2, 5.5, region: 'India'),
  'Vijayawada': CityLocation(16.5, 80.6, 5.5, region: 'India'),
  'Warangal': CityLocation(18.0, 79.6, 5.5, region: 'India'),
  // Pilgrimage cities
  'Mussoorie': CityLocation(30.5, 78.1, 5.5, region: 'India'),
  'Rishikesh': CityLocation(30.1, 78.3, 5.5, region: 'India'),
  'Haridwar': CityLocation(29.9, 78.2, 5.5, region: 'India'),
  'Mathura': CityLocation(27.5, 77.7, 5.5, region: 'India'),
  'Vrindavan': CityLocation(27.6, 77.7, 5.5, region: 'India'),
  'Ayodhya': CityLocation(26.8, 82.2, 5.5, region: 'India'),
  'Prayagraj': CityLocation(25.4, 81.8, 5.5, region: 'India'),
  'Dwarka': CityLocation(22.2, 69.0, 5.5, region: 'India'),
  'Shirdi': CityLocation(19.8, 74.5, 5.5, region: 'India'),
  // World cities
  'Moscow': CityLocation(55.8, 37.6, 3.0, region: 'Russia'),
  'Istanbul': CityLocation(41.0, 29.0, 3.0, region: 'Turkey'),
  'Beijing': CityLocation(39.9, 116.4, 8.0, region: 'China'),
  'Shanghai': CityLocation(31.2, 121.5, 8.0, region: 'China'),
  'Osaka': CityLocation(34.7, 135.5, 9.0, region: 'Japan'),
  'Mexico City': CityLocation(19.4, -99.1, -6.0, region: 'Mexico'),
  'Edinburgh': CityLocation(55.9, -3.2, 0.0, region: 'UK'),
  'Manchester': CityLocation(53.5, -2.2, 0.0, region: 'UK'),
  'Birmingham': CityLocation(52.5, -1.9, 0.0, region: 'UK'),
  // ─── Phase 2: 99% coverage ───
  'Honolulu': CityLocation(21.3, -157.8, -10.0, region: 'HI'),
  'Tampa': CityLocation(27.9, -82.5, -5.0, region: 'FL'),
  'Pittsburgh': CityLocation(40.4, -80.0, -5.0, region: 'PA'),
  'Columbus': CityLocation(39.9, -83.0, -5.0, region: 'OH'),
  'Indianapolis': CityLocation(39.8, -86.2, -5.0, region: 'IN'),
  'Kansas City': CityLocation(39.1, -94.6, -6.0, region: 'MO'),
  'St. Louis': CityLocation(38.6, -90.2, -6.0, region: 'MO'),
  'Sacramento': CityLocation(38.6, -121.5, -8.0, region: 'CA'),
  'Halifax': CityLocation(44.6, -63.6, -4.0, region: 'NS'),
  'Regina': CityLocation(50.5, -104.6, -6.0, region: 'SK'),
  'Gothenburg': CityLocation(57.7, 12.0, 1.0, region: 'Sweden'),
  'Lyon': CityLocation(45.8, 4.8, 1.0, region: 'France'),
  'Naples': CityLocation(40.8, 14.3, 1.0, region: 'Italy'),
  'Zagreb': CityLocation(45.8, 16.0, 1.0, region: 'Croatia'),
  'Krakow': CityLocation(50.1, 19.9, 1.0, region: 'Poland'),
  'Thessaloniki': CityLocation(40.6, 22.9, 2.0, region: 'Greece'),
  'Porto': CityLocation(41.2, -8.6, 0.0, region: 'Portugal'),
  'Rotterdam': CityLocation(51.9, 4.5, 1.0, region: 'Netherlands'),
  'Beirut': CityLocation(33.9, 35.5, 2.0, region: 'Lebanon'),
  'Ankara': CityLocation(39.9, 32.9, 3.0, region: 'Turkey'),
  'Redmond': CityLocation(47.7, -122.1, -8.0, region: 'WA'),
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

  /// City names whose bare form is commonly confused with another well-known
  /// place; only these receive a qualifier from [displayName].
  static const _ambiguous = {
    'Redmond',
    'Birmingham',
    'Manchester',
    'Naples',
    'Vancouver',
    'Athens',
    'San Jose',
    'Portland',
    'Columbus',
    'Kingston',
    'Georgetown',
    'Kochi',
    'Salem',
    'Surrey',
  };

  /// Compact label: the bare city name, with a region/country qualifier
  /// appended **only** for commonly-confused names (e.g. `'Redmond'` →
  /// `'Redmond, WA'`; `'Delhi'` → `'Delhi'`). Use in headers and confirmation
  /// UI. For always-qualified labels (pickers/search), use [qualifiedName].
  static String displayName(String city) {
    if (!_ambiguous.contains(city)) return city;
    final region = supportedCities[city]?.region;
    return region == null ? city : '$city, $region';
  }

  /// Fully-qualified label: appends the region/country for **every** city that
  /// has one (e.g. `'Seattle'` → `'Seattle, WA'`, `'Tokyo'` → `'Tokyo, Japan'`).
  /// Use in pickers/search lists where consistent qualification aids selection.
  /// Returns the bare name for self-qualifying cities (e.g. `'Singapore'`) and
  /// unknown names. [displayName] is the selective subset of this.
  static String qualifiedName(String city) {
    final region = supportedCities[city]?.region;
    return region == null ? city : '$city, $region';
  }
}

// ── City-name resolution ──────────────────────────────────────────────────
// Normalized lookup so callers can pass any reasonable spelling — case/space
// variants and the "City, Region" qualified form (what [City.qualifiedName]
// emits) — without silently falling back to the default city. Both coordinate
// and correction lookups route through this, so they can never disagree.
String _canonCity(String s) => s.toLowerCase().replaceAll(RegExp(r'\s+'), '');

final Map<String, String> _cityResolveMap = () {
  final m = <String, String>{};
  supportedCities.forEach((name, loc) {
    m[_canonCity(name)] = name;
    if (loc.region != null) m[_canonCity('$name, ${loc.region}')] = name;
  });
  return m;
}();

/// Resolve any reasonable city spelling to a registered city name, or `null` if
/// it matches no supported city.
///
/// Matches (case/space-insensitive): the bare name (the *primary* city‑region
/// for that name) and the `"City, Region"` qualified form (a specific
/// city‑region). There is intentionally **no** region‑stripping fuzzy match, so
/// `"Vancouver, WA"` never silently resolves to `"Vancouver, BC"`.
String? resolveCityName(String city) => _cityResolveMap[_canonCity(city)];
