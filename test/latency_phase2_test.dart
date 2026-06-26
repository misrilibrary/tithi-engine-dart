// Phase 2 latency check — mirrors the LalVakhs Phase 0 baseline
// (test/golden/tithi_latency_baseline_test.dart) but runs against the local
// refactored engine via the Panchang facade. Structure is identical: a fresh
// Panchang per month-grid render, ~30 tithiOnDate() calls for a celebration city.
//
// Baseline (1.0.9, no resolver cache), per month-grid:
//   Ujjain 3,180 us | Tokyo 27,646 us | Seattle 53,168 us  (~9-17x default)
//
// Run: dart test test/latency_phase2_test.dart

import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

Duration _timeMonthGrid(String city, int year, int month, int repeats) {
  final sw = Stopwatch()..start();
  for (var r = 0; r < repeats; r++) {
    final p = Panchang([registerAllCities],
        system: MonthSystem.purnimant); // fresh per grid, like the app baseline
    final days = _daysInMonth(year, month);
    for (var d = 1; d <= days; d++) {
      p.tithiOnDate(DateTime(year, month, d), City.of(city));
    }
  }
  sw.stop();
  return sw.elapsed;
}

void main() {
  test('Phase 2 latency: month-grid via Panchang (resolver cache)', () {
    const repeats = 50;
    _timeMonthGrid('Seattle', 2026, 1, 5); // warm up

    for (final city in ['Ujjain', 'Tokyo', 'Seattle']) {
      final elapsed = _timeMonthGrid(city, 2026, 5, repeats);
      final perGridUs = elapsed.inMicroseconds / repeats;
      final perDayUs = perGridUs / _daysInMonth(2026, 5);
      // ignore: avoid_print
      print(
          '[phase2-latency] $city: ${perGridUs.toStringAsFixed(1)} us/month-grid '
          '(${perDayUs.toStringAsFixed(1)} us/day) over $repeats repeats');
    }
  }, timeout: const Timeout(Duration(minutes: 3)));
}
