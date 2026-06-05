/// Core tithi calculation and naming.

enum Paksha { shukla, krishna }

/// Tithi names within a paksha (1-15).
const tithiNames = [
  'Pratipada', // 1
  'Dwitiya', // 2
  'Tritiya', // 3
  'Chaturthi', // 4
  'Panchami', // 5
  'Shashthi', // 6
  'Saptami', // 7
  'Ashtami', // 8
  'Navami', // 9
  'Dashami', // 10
  'Ekadashi', // 11
  'Dwadashi', // 12
  'Trayodashi', // 13
  'Chaturdashi', // 14
  'Purnima', // 15 (Shukla) / Amavasya (Krishna)
];

/// Calculate tithi number (1-30) from Moon and Sun sidereal longitudes.
/// 1-15 = Shukla Paksha (waxing), 16-30 = Krishna Paksha (waning).
int calculateTithi(double moonLongitude, double sunLongitude) {
  double diff = (moonLongitude - sunLongitude) % 360;
  if (diff < 0) diff += 360;
  return (diff / 12).floor() + 1;
}

/// Get paksha from tithi number (1-30).
Paksha getPaksha(int tithiNumber) =>
    tithiNumber <= 15 ? Paksha.shukla : Paksha.krishna;

/// Get tithi name from tithi number (1-30).
String getTithiName(int tithiNumber) {
  if (tithiNumber == 15) return 'Purnima';
  if (tithiNumber == 30) return 'Amavasya';
  final index = ((tithiNumber - 1) % 15);
  return tithiNames[index];
}

/// Get tithi position within paksha (1-15).
int tithiInPaksha(int tithiNumber) =>
    tithiNumber <= 15 ? tithiNumber : tithiNumber - 15;
