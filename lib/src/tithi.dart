// Core tithi calculation and naming.

// The two fortnights (pakshas) of a lunar month.
///
// - [shukla]: bright fortnight (waxing moon, tithis 1–15)
// - [krishna]: dark fortnight (waning moon, tithis 16–30)
enum Paksha { shukla, krishna }

/// Tithi names within a paksha (1-15).
const _tithiNames = [
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
  return _tithiNames[index];
}

/// Get tithi position within paksha (1-15).
int tithiInPaksha(int tithiNumber) =>
    tithiNumber <= 15 ? tithiNumber : tithiNumber - 15;

/// A tithi as a value: a lunar day identified by its [paksha] and position.
///
/// Carries both encodings — the absolute [number] (1–30) and the paksha-relative
/// [dayInPaksha] (1–15) — and owns the paksha-dependent [name] (the 15th is
/// Purnima in shukla, Amavasya in krishna), so callers never reimplement that
/// rule.
///
/// ```dart
/// Tithi.shukla(8);     // Shukla Ashtami
/// Tithi.krishna(11);   // Krishna Ekadashi
/// Tithi.ofNumber(23);  // == Tithi.krishna(8)
/// ```
class Tithi {
  /// Fortnight (waxing/waning).
  final Paksha paksha;

  /// Position within the paksha, 1–15.
  final int dayInPaksha;

  const Tithi._(this.paksha, this.dayInPaksha);

  /// Shukla-paksha (waxing) tithi at [dayInPaksha] (1–15; 15 = Purnima).
  factory Tithi.shukla(int dayInPaksha) {
    _check(dayInPaksha);
    return Tithi._(Paksha.shukla, dayInPaksha);
  }

  /// Krishna-paksha (waning) tithi at [dayInPaksha] (1–15; 15 = Amavasya).
  factory Tithi.krishna(int dayInPaksha) {
    _check(dayInPaksha);
    return Tithi._(Paksha.krishna, dayInPaksha);
  }

  /// From an absolute tithi number (1–30).
  factory Tithi.ofNumber(int number) {
    if (number < 1 || number > 30) {
      throw ArgumentError.value(number, 'number', 'tithi number must be 1–30');
    }
    return number <= 15
        ? Tithi._(Paksha.shukla, number)
        : Tithi._(Paksha.krishna, number - 15);
  }

  static void _check(int d) {
    if (d < 1 || d > 15) {
      throw ArgumentError.value(d, 'dayInPaksha', 'must be 1–15');
    }
  }

  /// Absolute tithi number, 1–30.
  int get number => paksha == Paksha.shukla ? dayInPaksha : dayInPaksha + 15;

  /// Paksha-aware name (15 → Purnima for shukla, Amavasya for krishna).
  String get name => getTithiName(number);

  @override
  bool operator ==(Object other) =>
      other is Tithi &&
      other.paksha == paksha &&
      other.dayInPaksha == dayInPaksha;

  @override
  int get hashCode => Object.hash(paksha, dayInPaksha);

  @override
  String toString() =>
      '${paksha == Paksha.shukla ? "Shukla" : "Krishna"} $name '
      '(${paksha == Paksha.shukla ? "S" : "K"}.$dayInPaksha)';
}
