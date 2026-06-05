import 'lunar_month.dart';
import 'tithi.dart';

/// Convert a lunar month between Purnimant and Amant systems.
///
/// Rule: Only Krishna Paksha differs between systems.
/// - Shukla Paksha: same month name in both systems
/// - Krishna Paksha: Purnimant assigns it to the NEXT month,
///   Amant keeps it in the CURRENT month.
///
/// So: Purnimant "Pausha Krishna" = Amant "Margashirsha Krishna"
LunarMonth convertMonth(
  LunarMonth month,
  Paksha paksha, {
  required MonthSystem from,
  required MonthSystem to,
}) {
  if (from == to) return month;
  if (paksha == Paksha.shukla) return month; // same in both

  // Krishna Paksha conversion
  final months = LunarMonth.values;
  final idx = months.indexOf(month);

  if (from == MonthSystem.purnimant && to == MonthSystem.amant) {
    // Purnimant Krishna → Amant: go to previous month
    return months[(idx - 1 + 12) % 12];
  } else {
    // Amant Krishna → Purnimant: go to next month
    return months[(idx + 1) % 12];
  }
}
