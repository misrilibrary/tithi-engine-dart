# tithi_engine

[![CI](https://github.com/misrilibrary/tithi-engine-dart/actions/workflows/ci.yml/badge.svg)](https://github.com/misrilibrary/tithi-engine-dart/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/tithi_engine.svg)](https://pub.dev/packages/tithi_engine)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A pure Dart library for Hindu lunar calendar (tithi/panchang) calculations. Computes accurate tithis, lunar months, and festival dates for any city worldwide.

## Features

- **Tithi calculation** — date → tithi number, name, paksha, lunar month
- **Festival dates** — muhurta-accurate (nishita, madhyahna, pradosh rules)
- **Month resolution** — moment-based adhika/kshaya detection, Purnimant & Amant systems
- **Date finding** — tithi → Gregorian date in any year
- **209 cities** — per-city correction tables verified against Swiss Ephemeris
- **Pure Dart** — no dependencies, works in Flutter, server, CLI, and web (WASM)
- **200-year accuracy** — validated 1900–2100 against Drik Panchang

## Installation

```yaml
dependencies:
  tithi_engine: ^1.0.3
```

## Quick Start

```dart
import 'package:tithi_engine/tithi_engine.dart';

final panchang = Panchang(MonthSystem.purnimant);

// Date → Tithi
final info = panchang.forDate(DateTime(2026, 2, 15), City.ujjain);
print(info.displayName); // "Phalguna Krishna Trayodashi"

// Festival date
final shivaratri = panchang.dateFor(
  festivals.firstWhere((f) => f.name == 'Maha Shivaratri'), 2026, City.ujjain);
print('Maha Shivaratri 2026: ${shivaratri?.date}');

// Tithi → Date
final date = panchang.getDate(
  LunarMonth.bhadrapada, Paksha.krishna, 8, 2026, City.seattle);
print('Janmashtami 2026 Seattle: $date');
```

## API

| Method | Description |
|--------|-------------|
| `panchang.forDate(date, city)` | Gregorian date → full TithiInfo |
| `panchang.getDate(month, paksha, tithi, year, city)` | Tithi spec → Gregorian date |
| `panchang.getDates(month, paksha, tithi, year, city)` | Tithi spec → all dates (adhika-aware) |
| `panchang.dateFor(festival, year, city)` | Festival → date with muhurta rules |
| `panchang.findNext(month, paksha, tithi, city)` | Next occurrence from today |

## Accuracy

| Metric | Value |
|--------|-------|
| Tithi vs Swiss Ephemeris | 0 mismatches (209 cities × 73,049 days, 1900–2100) |
| Month boundaries (Purnimant) | 100% (200 years, verified cities) |
| Festival dates vs Drik Panchang | 22/22 (2025–2026) |
| Test coverage | 467 tests |

## Cross-Platform

This is the Dart implementation of [tithi-engine](https://github.com/misrilibrary/tithi-engine) (Java). Both libraries produce identical results and share the same correction tables.

## License

Licensed under the [Apache License 2.0](LICENSE).
