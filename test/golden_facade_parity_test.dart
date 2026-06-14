// Facade parity golden test (Phase 1 of the tithi engine refactor).
//
// This reproduces, BYTE-FOR-BYTE, the canonical characterization dump defined
// by the consumer-side golden master (LalVakhs:
// test/golden/tithi_golden_master_test.dart) — but drives EVERY computation
// through the public `Panchang` facade instead of the (now-internal)
// TithiCalculator and free finder functions.
//
// If the FNV-1a 64-bit hash still equals the locked baseline
// (ef8a845c5a74b8c6), then the Panchang facade is a COMPLETE and
// BEHAVIOR-PRESERVING single entry point: the refactor changed the public API
// shape without changing any output.
//
// Keep the input space, ordering, and line formatting identical to the
// consumer golden — any divergence there would change the hash for reasons
// unrelated to engine behavior.

import 'dart:convert';

import 'package:test/test.dart';
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart';

const _expectedHash = 'ef8a845c5a74b8c6';

// ── Deterministic input space (must match the consumer golden) ────────────
const _years = [1899, 1963, 2010, 2020, 2023, 2026, 2044, 2080, 2101];
const _cities = ['Ujjain', 'Srinagar', 'Kolkata', 'Seattle', 'London', 'Tokyo'];
const _systems = [MonthSystem.purnimant, MonthSystem.amant];

final _timeProbes = <List<Object>>[
  [DateTime.utc(2026, 5, 11), 'Delhi'],
  [DateTime.utc(2026, 5, 11), 'Seattle'],
  [DateTime.utc(2026, 2, 15), 'Ujjain'],
  [DateTime.utc(2026, 11, 8), 'Ujjain'],
  [DateTime.utc(2026, 3, 19), 'Tokyo'],
  [DateTime.utc(2026, 7, 29), 'London'],
];

final _roundTripProbes = <List<Object>>[
  [DateTime.utc(2026, 1, 15), 'Ujjain'],
  [DateTime.utc(2026, 5, 25), 'Srinagar'],
  [DateTime.utc(2026, 8, 16), 'Seattle'],
  [DateTime.utc(2025, 10, 20), 'London'],
  [DateTime.utc(2080, 9, 29), 'Kolkata'],
];

const _festivalYears = [2025, 2026, 2027];
const _festivalCities = ['Ujjain', 'Seattle'];

// ── Canonical rendering (must match the consumer golden) ──────────────────
String _sys(MonthSystem s) => s == MonthSystem.purnimant ? 'P' : 'A';
String _pk(Paksha p) => p == Paksha.shukla ? 'S' : 'K';

String _ts(DateTime d) {
  final u = d.toUtc();
  String p2(int n) => n.toString().padLeft(2, '0');
  return '${u.year.toString().padLeft(4, '0')}${p2(u.month)}${p2(u.day)}'
      'T${p2(u.hour)}${p2(u.minute)}';
}

String _info(TithiInfo i) =>
    'T${i.tithiNumber}|${i.tithiInPaksha}|${_pk(i.paksha)}|'
    'm${i.month.index}|${i.isAdhika ? 1 : 0}|${i.displayName}';

String _buildCanonicalViaFacade() {
  final b = StringBuffer();

  // 1) Daily scan — facade: Panchang.forDate.
  b.writeln('# SECTION daily');
  for (final year in _years) {
    for (final city in _cities) {
      for (final system in _systems) {
        final p = Panchang([registerAllCities], system: system);
        var d = DateTime.utc(year, 1, 1);
        while (d.year == year) {
          final info = p.forDate(d, city);
          b.writeln('${_ts(d)}|$city|${_sys(system)}|${_info(info)}');
          d = d.add(const Duration(days: 1));
        }
      }
    }
  }

  // 2) DOB-with-time — facade: Panchang.forDate(..., utcOffset:).
  b.writeln('# SECTION time');
  for (final probe in _timeProbes) {
    final date = probe[0] as DateTime;
    final city = probe[1] as String;
    final loc = getLocationForCity(city);
    final offset = Duration(minutes: (loc.utcOffset * 60).round());
    for (final system in _systems) {
      final p = Panchang([registerAllCities], system: system);
      for (final hour in [7, 22]) {
        final dt = DateTime(date.year, date.month, date.day, hour);
        final info = p.forDate(dt, city, utcOffset: offset);
        b.writeln('${_ts(date)}|$city|${_sys(system)}|h$hour|${_info(info)}');
      }
    }
  }

  // 3) Round-trip — facade: Panchang.getDates.
  b.writeln('# SECTION roundtrip');
  for (final probe in _roundTripProbes) {
    final date = probe[0] as DateTime;
    final city = probe[1] as String;
    for (final system in _systems) {
      final p = Panchang([registerAllCities], system: system);
      final info = p.forDate(date, city);
      final found = p.getDates(
          info.month, info.paksha, info.tithiInPaksha, date.year, city,
          isAdhika: info.isAdhika)
        ..sort();
      final stamps = found.map(_ts).join(',');
      b.writeln('${_ts(date)}|$city|${_sys(system)}|${_info(info)}|=>$stamps');
    }
  }

  // 4) Festivals — facade: Panchang.recurringDates / Panchang.dateFor.
  b.writeln('# SECTION festivals');
  for (final fest in festivals) {
    for (final city in _festivalCities) {
      for (final year in _festivalYears) {
        for (final system in _systems) {
          final p = Panchang([registerAllCities], system: system);
          if (fest.recurring) {
            final dates = p
                .recurringDates(fest, year, city)
                .map((r) =>
                    '${_ts(r.date)}[${_ts(r.tithiStart)};${_ts(r.tithiEnd)}]')
                .toList()
              ..sort();
            b.writeln(
                '${fest.id}|$city|$year|${_sys(system)}|R|${dates.join(",")}');
          } else {
            final r = p.dateFor(fest, year, city);
            if (r == null) {
              b.writeln('${fest.id}|$city|$year|${_sys(system)}|F|null');
            } else {
              b.writeln('${fest.id}|$city|$year|${_sys(system)}|F|'
                  '${_ts(r.date)}|${_ts(r.tithiStart)}|${_ts(r.tithiEnd)}|'
                  '${r.muhurtaStart == null ? "-" : _ts(r.muhurtaStart!)}|'
                  '${r.muhurtaEnd == null ? "-" : _ts(r.muhurtaEnd!)}');
            }
          }
        }
      }
    }
  }

  return b.toString();
}

String _fnv1a64(String s) {
  final mask = (BigInt.one << 64) - BigInt.one;
  final prime = BigInt.from(0x100000001b3);
  var hash = BigInt.parse('14695981039346656037');
  for (final byte in utf8.encode(s)) {
    hash = (hash ^ BigInt.from(byte)) & mask;
    hash = (hash * prime) & mask;
  }
  return hash.toRadixString(16).padLeft(16, '0');
}

void main() {
  setUpAll(registerAllCities); // register every city's corrections before use

  test('Panchang facade reproduces the locked golden hash', () {
    final canonical = _buildCanonicalViaFacade();
    final hash = _fnv1a64(canonical);
    final lines = '\n'.allMatches(canonical).length;
    final bytes = utf8.encode(canonical).length;
    // ignore: avoid_print
    print('[facade-golden] fnv1a64=$hash lines=$lines bytes=$bytes');
    expect(hash, _expectedHash,
        reason: 'Panchang facade output diverged from the locked baseline. '
            'The refactor changed engine behavior — investigate before proceeding.');
  }, timeout: const Timeout(Duration(minutes: 5)));
}
