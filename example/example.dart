/// Comprehensive example demonstrating every public API method of tithi_engine.
library;

import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';
import 'package:tithi_engine/data/all_center.dart';

void main() {
  // ─── Construction ───────────────────────────────────────────────────────
  // Pass city-data registrars. Use registerAllCities for all 230 cities,
  // or a region pack (registerIndia, registerEurope, etc.) for tree-shaking.
  final panchang = Panchang([registerAllCities]);

  // ─── tithiOnDate: sunrise tithi of a panchang day (display/observance) ──
  final info = panchang.tithiOnDate(DateTime.utc(2026, 6, 25), 'New York');
  print('tithiOnDate: ${info.displayName}');
  print('  month=${info.month.displayName}, paksha=${info.paksha}, '
      'tithiInPaksha=${info.tithiInPaksha}, isAdhika=${info.isAdhika}');

  // ─── tithiAtInstant: tithi at an exact UTC moment (birth-time) ──────────
  // Pass the DST-aware offset in effect at the birth location+time.
  const nyOffset = Duration(hours: -4); // EDT
  final birthUtc = DateTime.utc(2026, 6, 25, 22, 30); // 6:30 PM EDT → UTC
  final birth = panchang.tithiAtInstant(birthUtc, 'New York', offset: nyOffset);
  print('\ntithiAtInstant: ${birth.displayName}');

  // ─── tithiSegments: all tithi segments in a UTC window ──────────────────
  final windowStart = DateTime.utc(2026, 6, 25, 0, 0);
  final windowEnd = DateTime.utc(2026, 6, 26, 0, 0);
  final segments = panchang.tithiSegments(windowStart, windowEnd, 'New York',
      offset: nyOffset);
  print('\ntithiSegments (${segments.length} segments in 24h window):');
  for (final seg in segments) {
    print('  ${seg.tithi.tithiName} from ${seg.startUtc} to ${seg.endUtc}');
  }

  // ─── findDate / findDates: tithi spec → Gregorian date(s) ──────────────
  final date = panchang.findDate(
      LunarMonth.bhadrapada, Tithi.krishna(8), 2026, 'Seattle');
  print('\nfindDate (Janmashtami 2026 Seattle): $date');

  final dates =
      panchang.findDates(LunarMonth.jyeshtha, Tithi.shukla(11), 2026, 'Ujjain');
  print('findDates (Jyeshtha Shukla Ekadashi 2026): $dates');

  // ─── dateFor: named festival → date with muhurta rules ─────────────────
  final shivaratri = panchang.dateFor(
      festivals.firstWhere((f) => f.id == 'maha_shivaratri'), 2026, 'Delhi');
  if (shivaratri != null) {
    print('\ndateFor (Maha Shivaratri 2026 Delhi):');
    print('  date=${shivaratri.date}, month=${shivaratri.month.displayName}');
    print('  tithi: ${shivaratri.tithiStart} → ${shivaratri.tithiEnd}');
    if (shivaratri.muhurtaStart != null) {
      print('  muhurta: ${shivaratri.muhurtaStart} → ${shivaratri.muhurtaEnd}');
    }
  }

  // ─── recurringDates: a recurring festival → all occurrences in a year ───
  final ekadashi = festivals.firstWhere((f) => f.id == 'masik_shukla_ekadashi');
  final ekadashiDates = panchang.recurringDates(ekadashi, 2026, 'Ujjain');
  print(
      '\nrecurringDates (Shukla Ekadashi 2026, ${ekadashiDates.length} occurrences):');
  for (final fd in ekadashiDates.take(3)) {
    // FestivalDate.month is the ACTUAL month of the occurrence (not Chaitra!)
    print('  ${fd.date} → ${fd.month.displayName} Shukla Ekadashi'
        '${fd.isAdhika ? " (Adhika)" : ""}');
  }
  print('  ...');

  // ─── findNext: next occurrence of a tithi from today ────────────────────
  // (findNext is deprecated in 4.4; a typed findNext(Tithi) lands in 5.0.)
  // ignore: deprecated_member_use
  final next =
      panchang.findNext(LunarMonth.kartika, Paksha.krishna, 15, 'Seattle');
  print('\nfindNext (Kartika Amavasya from today): $next');

  // ─── sunrise / sunset ──────────────────────────────────────────────────
  final sr = panchang.sunrise(DateTime.utc(2026, 6, 25), 'Seattle');
  final ss = panchang.sunset(DateTime.utc(2026, 6, 25), 'Seattle');
  print('\nsunrise Seattle 2026-06-25: $sr');
  print('sunset  Seattle 2026-06-25: $ss');

  // ─── Panchang.at(Location): bind to coordinates ────────────────────────
  // A point within a supported city's 0.1° cell reuses Swiss corrections.
  final here = panchang.at(Location.at(47.61, -122.33)); // Seattle coords
  print('\nPanchang.at(47.61, -122.33):');
  print('  source=${here.source}'); // cityCorrected
  print(
      '  tithiOnDate=${here.tithiOnDate(DateTime.utc(2026, 6, 25)).displayName}');

  // A point off-grid is Meeus-only (still ~99.97% accurate).
  final remote =
      panchang.at(Location.at(0.0, -140.0, offset: const Duration(hours: -9)));
  print('  off-grid source=${remote.source}'); // meeusRaw

  // ─── Sunrise convention: centre-of-disc ─────────────────────────────────
  // Register the centerDisc data pack and pass the convention.
  final pcenter = Panchang([registerAllCities, registerAllCitiesCenterDisc],
      convention: SunriseConvention.centerDisc);
  final centerInfo = pcenter.tithiOnDate(DateTime.utc(2026, 6, 25), 'Delhi');
  print('\ncenterDisc convention:');
  print('  tithiOnDate Delhi: ${centerInfo.displayName}');
  print(
      '  sunrise Delhi: ${pcenter.sunrise(DateTime.utc(2026, 6, 25), "Delhi")}');

  // ─── TithiInfo.fromStored: render a saved tithi with system conversion ──
  final stored = TithiInfo.fromStored(
    tithiNumber: 23, // Krishna 8
    month: LunarMonth.bhadrapada,
    storedSystem: MonthSystem.purnimant,
    displaySystem: MonthSystem.amant, // convert for Amant display
  );
  print('\nTithiInfo.fromStored (K.8, Bhadrapada Purnimant → Amant display):');
  print('  ${stored.displayName}');
}
