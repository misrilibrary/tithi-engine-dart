// Lunar month determination from Sun's sidereal position.

// The twelve months of the Hindu lunar calendar.
///
// Months begin at Chaitra (March–April) and end at Phalguna (February–March).
enum LunarMonth {
  chaitra,
  vaishakha,
  jyeshtha,
  ashadha,
  shravana,
  bhadrapada,
  ashvina,
  kartika,
  margashirsha,
  pausha,
  magha,
  phalguna;

  String get displayName {
    switch (this) {
      case chaitra:
        return 'Chaitra';
      case vaishakha:
        return 'Vaishakha';
      case jyeshtha:
        return 'Jyeshtha';
      case ashadha:
        return 'Ashadha';
      case shravana:
        return 'Shravana';
      case bhadrapada:
        return 'Bhadrapada';
      case ashvina:
        return 'Ashvina';
      case kartika:
        return 'Kartika';
      case margashirsha:
        return 'Margashirsha';
      case pausha:
        return 'Pausha';
      case magha:
        return 'Magha';
      case phalguna:
        return 'Phalguna';
    }
  }
}

/// Month system: Purnimant (North India) or Amant (South India).
enum MonthSystem { purnimant, amant }

/// Determine lunar month from Sun's sidereal longitude and paksha.
///
/// In Purnimant system: Krishna Paksha belongs to the NEXT month.
/// e.g., Krishna Paksha after Jyeshtha Purnima = Ashadha Krishna.
LunarMonth getLunarMonth(double siderealSunLongitude,
    {MonthSystem system = MonthSystem.purnimant,
    bool isKrishnaPaksha = false}) {
  final sign = (siderealSunLongitude / 30).floor() % 12;

  const monthOrder = [
    LunarMonth.vaishakha, // Sun in Mesha (Aries)
    LunarMonth.jyeshtha, // Sun in Vrishabha (Taurus)
    LunarMonth.ashadha, // Sun in Mithuna (Gemini)
    LunarMonth.shravana, // Sun in Karka (Cancer)
    LunarMonth.bhadrapada, // Sun in Simha (Leo)
    LunarMonth.ashvina, // Sun in Kanya (Virgo)
    LunarMonth.kartika, // Sun in Tula (Libra)
    LunarMonth.margashirsha, // Sun in Vrischika (Scorpio)
    LunarMonth.pausha, // Sun in Dhanu (Sagittarius)
    LunarMonth.magha, // Sun in Makara (Capricorn)
    LunarMonth.phalguna, // Sun in Kumbha (Aquarius)
    LunarMonth.chaitra, // Sun in Meena (Pisces)
  ];

  if (system == MonthSystem.purnimant) {
    final baseMonth = monthOrder[sign];
    if (isKrishnaPaksha) {
      // Krishna Paksha belongs to the next month in Purnimant
      final nextIndex = (LunarMonth.values.indexOf(baseMonth) + 1) % 12;
      return LunarMonth.values[nextIndex];
    }
    return baseMonth;
  } else {
    // Amant: one behind Purnimant Shukla
    final purnimantIndex = LunarMonth.values.indexOf(monthOrder[sign]);
    final amantIndex = (purnimantIndex - 1 + 12) % 12;
    return LunarMonth.values[amantIndex];
  }
}
