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
- **230 cities** — per-city correction tables verified against Swiss Ephemeris
- **Pure Dart** — no dependencies, works in Flutter, server, CLI, and web (WASM)
- **200-year accuracy** — validated 1900–2100 against Drik Panchang

## Installation

```yaml
dependencies:
  tithi_engine: ^2.1.0
```

## Quick Start

```dart
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart'; // city correction tables

// City data is REQUIRED in the constructor — pass a pack's registrar.
// data/all.dart links all cities; a region pack (e.g. data/india.dart → registerIndia)
// links only that region so the tree-shaker drops the rest.
final panchang = Panchang([registerAllCities]);

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

> **There is no zero-arg `Panchang()`.** The constructor requires a list of
> data-pack registrars, so you can't accidentally run with no city data. Choosing
> which packs to import is also what lets the tree-shaker drop unused cities (an
> India-only consumer links ~30 cities, not 230). Registrars are idempotent, so
> constructing repeatedly is cheap.

## Data packs

| Import | Pass to constructor | Links |
|--------|---------------------|-------|
| `package:tithi_engine/data/all.dart` | `Panchang([registerAllCities])` | all 230 cities |
| `package:tithi_engine/data/india.dart` | `Panchang([registerIndia])` | India (30 cities) |

Combine packs: `Panchang([registerIndia, registerEurope])`.

## API

`Panchang` is the single entry point. Value types (`TithiInfo`, `LunarMonth`,
`MonthSystem`, `Paksha`, `FestivalDef`, `MuhurtaRule`, `festivals`, `FestivalDate`,
`City`, `CityLocation`) are exported; the engine internals are not.

| Method | Description |
|--------|-------------|
| `Panchang(data, {system})` | Construct with city-data registrars (`data` required) |
| `panchang.forDate(date, city, {utcOffset})` | Gregorian date → full TithiInfo (time-of-day aware) |
| `panchang.getDate(month, paksha, tithi, year, city)` | Tithi spec → Gregorian date |
| `panchang.getDates(month, paksha, tithi, year, city)` | Tithi spec → all dates (adhika-aware) |
| `panchang.dateFor(festival, year, city)` | Festival → date with muhurta rules |
| `panchang.recurringDates(festival, year, city)` | Recurring festival → all occurrences in the year |
| `panchang.findNext(month, paksha, tithi, city)` | Next occurrence from today |
| `panchang.transitionTime(date, {utcOffset})` | UTC moment the tithi changes that day |
| `TithiInfo.fromStored(...)` | Render a saved tithi (with optional Purnimant↔Amant display conversion) |

## Accuracy

| Metric | Value |
|--------|-------|
| Tithi vs Swiss Ephemeris | 0 mismatches (230 cities × 73,049 days, 1900–2100) |
| Month boundaries (Purnimant) | 100% (200 years, verified cities) |
| Festival dates vs Drik Panchang | 22/22 (2025–2026) |
| Test coverage | 519 tests, ~87% core line coverage |

## Cross-Platform

This is the Dart implementation of [tithi-engine](https://github.com/misrilibrary/tithi-engine) (Java). Both produce identical tithi/panchang results, validated against Swiss Ephemeris.

## License

Licensed under the [Apache License 2.0](LICENSE).
