import 'lunar_month.dart';
import 'tithi.dart';

/// Muhurta rule that determines the observance day for a festival.
enum MuhurtaRule {
  /// Standard: tithi at sunrise (generic rule).
  sunrise,

  /// Observe when tithi prevails at midnight (nishita kaal).
  nishita,

  /// Observe when tithi prevails at midday (madhyahna).
  madhyahna,

  /// Observe when tithi prevails during evening (pradosh kaal).
  pradosh,
}

/// Tradition/sampradaya for festivals with variant dates.
enum FestivalTradition { general, smarta, vaishnava, kashmiri }

/// Static definition of a Hindu festival.
class FestivalDef {
  final String id;
  final String name;
  final LunarMonth month;
  final Paksha paksha;
  final int tithiInPaksha; // 1-15
  final MuhurtaRule muhurta;
  final FestivalTradition tradition;
  final bool enabledByDefault;
  final bool recurring; // true = every month (month field ignored)

  const FestivalDef({
    required this.id,
    required this.name,
    required this.month,
    required this.paksha,
    required this.tithiInPaksha,
    required this.muhurta,
    this.tradition = FestivalTradition.general,
    this.enabledByDefault = true,
    this.recurring = false,
  });

  int get tithiNumber =>
      paksha == Paksha.shukla ? tithiInPaksha : tithiInPaksha + 15;
}

/// All supported festivals.
const festivals = <FestivalDef>[
  FestivalDef(
      id: 'maha_shivaratri_kashmiri',
      name: 'Herath',
      month: LunarMonth.phalguna,
      paksha: Paksha.krishna,
      tithiInPaksha: 13,
      muhurta: MuhurtaRule.nishita,
      tradition: FestivalTradition.kashmiri),
  FestivalDef(
      id: 'maha_shivaratri',
      name: 'Maha Shivaratri',
      month: LunarMonth.phalguna,
      paksha: Paksha.krishna,
      tithiInPaksha: 14,
      muhurta: MuhurtaRule.nishita),
  FestivalDef(
      id: 'holika_dahan',
      name: 'Holika Dahan',
      month: LunarMonth.phalguna,
      paksha: Paksha.shukla,
      tithiInPaksha: 15,
      muhurta: MuhurtaRule.pradosh),
  FestivalDef(
      id: 'ram_navami',
      name: 'Ram Navami',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 9,
      muhurta: MuhurtaRule.madhyahna),
  FestivalDef(
      id: 'akshaya_tritiya',
      name: 'Akshaya Tritiya',
      month: LunarMonth.vaishakha,
      paksha: Paksha.shukla,
      tithiInPaksha: 3,
      muhurta: MuhurtaRule.madhyahna),
  FestivalDef(
      id: 'guru_purnima',
      name: 'Guru Purnima',
      month: LunarMonth.ashadha,
      paksha: Paksha.shukla,
      tithiInPaksha: 15,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'raksha_bandhan',
      name: 'Raksha Bandhan',
      month: LunarMonth.shravana,
      paksha: Paksha.shukla,
      tithiInPaksha: 15,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'janmashtami_kashmiri',
      name: 'Zarmasatam (Kashmiri)',
      month: LunarMonth.bhadrapada,
      paksha: Paksha.krishna,
      tithiInPaksha: 7,
      muhurta: MuhurtaRule.nishita,
      tradition: FestivalTradition.kashmiri),
  FestivalDef(
      id: 'janmashtami_smarta',
      name: 'Janmashtami (Smarta)',
      month: LunarMonth.bhadrapada,
      paksha: Paksha.krishna,
      tithiInPaksha: 8,
      muhurta: MuhurtaRule.nishita,
      tradition: FestivalTradition.smarta),
  FestivalDef(
      id: 'janmashtami_iskcon',
      name: 'Janmashtami (ISKCON)',
      month: LunarMonth.bhadrapada,
      paksha: Paksha.krishna,
      tithiInPaksha: 8,
      muhurta: MuhurtaRule.sunrise,
      tradition: FestivalTradition.vaishnava),
  FestivalDef(
      id: 'ganesh_chaturthi',
      name: 'Ganesh Chaturthi',
      month: LunarMonth.bhadrapada,
      paksha: Paksha.shukla,
      tithiInPaksha: 4,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'vijayadashami',
      name: 'Vijayadashami',
      month: LunarMonth.ashvina,
      paksha: Paksha.shukla,
      tithiInPaksha: 10,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'diwali',
      name: 'Diwali / Lakshmi Puja',
      month: LunarMonth.kartika,
      paksha: Paksha.krishna,
      tithiInPaksha: 15,
      muhurta: MuhurtaRule.pradosh),
  // ── Curated Kashmiri jantri additions (Samvat 2082) ──
  FestivalDef(
      id: 'navreh',
      name: 'Navreh',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 1,
      muhurta: MuhurtaRule.sunrise,
      tradition: FestivalTradition.kashmiri),
  FestivalDef(
      id: 'thal_buth_vuchun',
      name: 'Thal Buth Vuchun',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 1,
      muhurta: MuhurtaRule.sunrise,
      tradition: FestivalTradition.kashmiri),
  FestivalDef(
      id: 'zang_trayi',
      name: 'Zang Trayi',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 2,
      muhurta: MuhurtaRule.sunrise,
      tradition: FestivalTradition.kashmiri),
  FestivalDef(
      id: 'durga_ashtami',
      name: 'Durga Ashtami',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 8,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'nirjala_ekadashi',
      name: 'Nirjala Ekadashi',
      month: LunarMonth.jyeshtha,
      paksha: Paksha.shukla,
      tithiInPaksha: 11,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'zyeth_ashtami',
      name: 'Zyeth Ashtami',
      month: LunarMonth.jyeshtha,
      paksha: Paksha.shukla,
      tithiInPaksha: 8,
      muhurta: MuhurtaRule.sunrise,
      tradition: FestivalTradition.kashmiri),
  FestivalDef(
      id: 'haar_ashtami',
      name: 'Haar Ashtami',
      month: LunarMonth.ashadha,
      paksha: Paksha.shukla,
      tithiInPaksha: 8,
      muhurta: MuhurtaRule.sunrise,
      tradition: FestivalTradition.kashmiri),
  FestivalDef(
      id: 'sharad_navratri',
      name: 'Navratri (Sharad) Begins',
      month: LunarMonth.ashvina,
      paksha: Paksha.shukla,
      tithiInPaksha: 1,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'maha_navami',
      name: 'Maha Navami',
      month: LunarMonth.ashvina,
      paksha: Paksha.shukla,
      tithiInPaksha: 9,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'karva_chauth',
      name: 'Karva Chauth',
      month: LunarMonth.kartika,
      paksha: Paksha.krishna,
      tithiInPaksha: 4,
      muhurta: MuhurtaRule.sunrise),
  FestivalDef(
      id: 'bhai_dooj',
      name: 'Bhai Dooj',
      month: LunarMonth.kartika,
      paksha: Paksha.shukla,
      tithiInPaksha: 2,
      muhurta: MuhurtaRule.sunrise),
  // Recurring monthly tithis
  FestivalDef(
      id: 'masik_krishna_ashtami',
      name: 'Krishna Ashtami',
      month: LunarMonth.chaitra,
      paksha: Paksha.krishna,
      tithiInPaksha: 8,
      muhurta: MuhurtaRule.sunrise,
      recurring: true),
  FestivalDef(
      id: 'masik_shukla_ashtami',
      name: 'Shukla Ashtami',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 8,
      muhurta: MuhurtaRule.sunrise,
      recurring: true),
  FestivalDef(
      id: 'masik_krishna_ekadashi',
      name: 'Krishna Ekadashi',
      month: LunarMonth.chaitra,
      paksha: Paksha.krishna,
      tithiInPaksha: 11,
      muhurta: MuhurtaRule.sunrise,
      recurring: true),
  FestivalDef(
      id: 'masik_shukla_ekadashi',
      name: 'Shukla Ekadashi',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 11,
      muhurta: MuhurtaRule.sunrise,
      recurring: true),
  FestivalDef(
      id: 'masik_purnima',
      name: 'Purnima',
      month: LunarMonth.chaitra,
      paksha: Paksha.shukla,
      tithiInPaksha: 15,
      muhurta: MuhurtaRule.sunrise,
      recurring: true),
  FestivalDef(
      id: 'masik_amavasya',
      name: 'Amavasya',
      month: LunarMonth.chaitra,
      paksha: Paksha.krishna,
      tithiInPaksha: 15,
      muhurta: MuhurtaRule.sunrise,
      recurring: true),
];
