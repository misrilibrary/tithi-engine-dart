import 'package:test/test.dart';
import 'package:tithi_engine/src/lunar_month.dart';
import 'package:tithi_engine/src/month_converter.dart';
import 'package:tithi_engine/src/tithi.dart';

void main() {
  group('Month conversion: Purnimant ↔ Amant', () {
    // Rule: Only Krishna Paksha month name differs.
    // Shukla Paksha: same month in both systems.
    // Purnimant Krishna "X" = Amant Krishna "previous month"

    group('Shukla Paksha — no change in either direction', () {
      test('NI Pausha Shukla → SI Pausha Shukla (unchanged)', () {
        final result = convertMonth(
          LunarMonth.pausha,
          Paksha.shukla,
          from: MonthSystem.purnimant,
          to: MonthSystem.amant,
        );
        expect(result, LunarMonth.pausha);
      });

      test('SI Magha Shukla → NI Magha Shukla (unchanged)', () {
        final result = convertMonth(
          LunarMonth.magha,
          Paksha.shukla,
          from: MonthSystem.amant,
          to: MonthSystem.purnimant,
        );
        expect(result, LunarMonth.magha);
      });
    });

    group('Krishna Paksha — NI to SI (goes to previous month)', () {
      test('NI Phalguna Krishna → SI Magha Krishna', () {
        final result = convertMonth(
          LunarMonth.phalguna,
          Paksha.krishna,
          from: MonthSystem.purnimant,
          to: MonthSystem.amant,
        );
        expect(result, LunarMonth.magha);
      });

      test('NI Magha Krishna → SI Pausha Krishna', () {
        final result = convertMonth(
          LunarMonth.magha,
          Paksha.krishna,
          from: MonthSystem.purnimant,
          to: MonthSystem.amant,
        );
        expect(result, LunarMonth.pausha);
      });

      test('NI Chaitra Krishna → SI Phalguna Krishna', () {
        final result = convertMonth(
          LunarMonth.chaitra,
          Paksha.krishna,
          from: MonthSystem.purnimant,
          to: MonthSystem.amant,
        );
        expect(result, LunarMonth.phalguna);
      });
    });

    group('Krishna Paksha — SI to NI (goes to next month)', () {
      test('SI Magha Krishna → NI Phalguna Krishna', () {
        final result = convertMonth(
          LunarMonth.magha,
          Paksha.krishna,
          from: MonthSystem.amant,
          to: MonthSystem.purnimant,
        );
        expect(result, LunarMonth.phalguna);
      });

      test('SI Pausha Krishna → NI Magha Krishna', () {
        final result = convertMonth(
          LunarMonth.pausha,
          Paksha.krishna,
          from: MonthSystem.amant,
          to: MonthSystem.purnimant,
        );
        expect(result, LunarMonth.magha);
      });

      test('SI Phalguna Krishna → NI Chaitra Krishna', () {
        final result = convertMonth(
          LunarMonth.phalguna,
          Paksha.krishna,
          from: MonthSystem.amant,
          to: MonthSystem.purnimant,
        );
        expect(result, LunarMonth.chaitra);
      });
    });

    group('Same system — no change', () {
      test('NI → NI: no change', () {
        final result = convertMonth(
          LunarMonth.pausha,
          Paksha.krishna,
          from: MonthSystem.purnimant,
          to: MonthSystem.purnimant,
        );
        expect(result, LunarMonth.pausha);
      });

      test('SI → SI: no change', () {
        final result = convertMonth(
          LunarMonth.magha,
          Paksha.krishna,
          from: MonthSystem.amant,
          to: MonthSystem.amant,
        );
        expect(result, LunarMonth.magha);
      });
    });

    group('Round-trip: NI → SI → NI returns original', () {
      test('Phalguna Krishna round-trip', () {
        final si = convertMonth(
          LunarMonth.phalguna,
          Paksha.krishna,
          from: MonthSystem.purnimant,
          to: MonthSystem.amant,
        );
        final ni = convertMonth(
          si,
          Paksha.krishna,
          from: MonthSystem.amant,
          to: MonthSystem.purnimant,
        );
        expect(ni, LunarMonth.phalguna);
      });
    });

    group('Verified against Drik Panchang', () {
      // Feb 4, 2015: Drik shows Phalguna (Purnimant) / Magha (Amant)
      // Tithi: Krishna Pratipada
      test('Feb 4, 2015: NI=Phalguna Kr, SI=Magha Kr', () {
        final niToSi = convertMonth(
          LunarMonth.phalguna,
          Paksha.krishna,
          from: MonthSystem.purnimant,
          to: MonthSystem.amant,
        );
        expect(niToSi, LunarMonth.magha);
      });
    });
  });
}
