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
  tithi_engine: ^3.0.0
```

## Quick Start

```dart
import 'package:tithi_engine/tithi_engine.dart';
import 'package:tithi_engine/data/all.dart'; // city correction tables

// City data is REQUIRED in the constructor — pass a pack's registrar.
// data/all.dart links all cities; a region pack (e.g. data/india.dart → registerIndia)
// links only that region so the tree-shaker drops the rest.
final panchang = Panchang([registerAllCities]);

// Date → Tithi (sunrise tithi of the panchang day; for display/observance)
final info = panchang.tithiOnDate(DateTime.utc(2026, 2, 15), City.ujjain);
print(info.displayName); // "Phalguna Krishna Trayodashi"

// Exact moment → Tithi (birth-time precision). Pass a true UTC instant plus the
// DST-aware offset that was in effect (the app resolves the offset, e.g. via
// package:timezone). The offset is used only to pick the civil day's data.
final cdt = const Duration(hours: -5);
final birthUtc = DateTime.utc(2006, 5, 30, 20, 0).subtract(cdt); // 8 PM CDT → UTC
final birthTithi = panchang.tithiAtInstant(birthUtc, 'Austin', offset: cdt);
print(birthTithi.displayName);

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

`Panchang` is the single entry point. Value types (`TithiInfo`, `TithiSegment`,
`LunarMonth`, `MonthSystem`, `Paksha`, `FestivalDef`, `MuhurtaRule`, `festivals`,
`FestivalDate`, `City`, `CityLocation`) are exported; the engine internals are not.

The time-aware API is **UTC-instant based**: you pass true UTC instants and, where
a civil day matters, the DST-aware offset in effect (the engine does no timezone
resolution — resolve the offset yourself, e.g. via `package:timezone`).

| Method | Description |
|--------|-------------|
| `Panchang(data, {system})` | Construct with city-data registrars (`data` required) |
| `panchang.tithiOnDate(date, city)` | Sunrise tithi of the panchang day (display/observance) |
| `panchang.tithiAtInstant(utcInstant, city, {offset})` | Tithi at an exact UTC moment (birth-time) |
| `panchang.tithiSegments(windowStartUtc, windowEndUtc, city, {offset})` | Every tithi segment in a UTC window (N transitions → N+1 segments) |
| `panchang.getDate(month, paksha, tithi, year, city)` | Tithi spec → Gregorian date |
| `panchang.getDates(month, paksha, tithi, year, city)` | Tithi spec → all dates (adhika-aware) |
| `panchang.dateFor(festival, year, city)` | Festival → date with muhurta rules |
| `panchang.recurringDates(festival, year, city)` | Recurring festival → all occurrences in the year |
| `panchang.findNext(month, paksha, tithi, city)` | Next occurrence from today |
| `TithiInfo.fromStored(...)` | Render a saved tithi (with optional Purnimant↔Amant display conversion) |

### City names

Every method takes a `city` name. Resolution is **case- and space-insensitive** and
accepts the qualified `"City, Region"` form, so all of these resolve to the same city:

```dart
getLocationForCity('New York');      // canonical
getLocationForCity('new york');      // case-insensitive
getLocationForCity('New York, NY');  // qualified form (as City.qualifiedName emits)
```

The canonical identity is the **(city, region)** pair: the bare name maps to the
*primary* city for that name, and the qualified `"City, Region"` form selects a
specific one when several share a name (e.g. a future `'Vancouver, WA'` vs
`'Vancouver, BC'`). There is **no fuzzy/region-stripping match** — a wrong region
(`'Vancouver, WA'` when only BC exists) is treated as unknown.

An **unsupported city throws `ArgumentError`** — the engine never silently substitutes
another location, because a wrong location produces wrong sunrise-based tithis and
festival dates. To check without throwing, use `resolveCityName(name)` (returns `null`
if unsupported) or inspect `supportedCities`. Need a city added? Open an issue:
<https://github.com/misrilibrary/tithi-engine-dart/issues>.

## Accuracy

| Metric | Value |
|--------|-------|
| Tithi vs Swiss Ephemeris | 0 mismatches (230 cities × 73,049 days, 1900–2100) |
| Month boundaries (Purnimant) | 100% (200 years, verified cities) |
| Festival dates vs Drik Panchang | 22/22 (2025–2026) |
| Test coverage | 536 tests, ~87% core line coverage |

## Cross-Platform

This is the Dart implementation of [tithi-engine](https://github.com/misrilibrary/tithi-engine) (Java). Both compute identical tithi/panchang results, validated against the Swiss Ephemeris.

The two packages **version independently** — each version string is a semver compatibility contract for *that* ecosystem. What stays locked in step is the **astronomy engine revision** (the correctness-critical part) and the feature parity tracked below.

- **Engine revision:** `r2` — VSOP87 Sun + Meeus Moon in Terrestrial Time (Espenak–Meeus ΔT), nutation cancelled in the Moon–Sun elongation. Dart `2.1.0+` ⟷ Java `1.1.0+`. Verified: correction tables byte-identical across both, 0 mismatches over 230 cities × 73,414 days.

| Capability | Dart (tithi_engine) | Java (tithi-engine) |
|---|---|---|
| Astronomy engine rev `r2` (VSOP87/TT) | `2.1.0+` | `1.1.0+` |
| 230 cities, Swiss-verified tables | `2.1.0+` | `1.1.0+` |
| City display-name disambiguation (`region` / `qualifiedName` / `displayName`) | `2.2.0+` | `2.0.0+` |
| Time-aware API (`tithiOnDate` / `tithiAtInstant` / `tithiSegments`) | `3.0.0+` | `2.0.0+` |
| `recurringDates` / `findNext` / `TithiInfo.fromStored` | `2.0.0+` | `2.0.0+` |
| Strict city resolution (`resolveCityName`, fail-fast on unknown, `"City, Region"` form) | `4.0.0+` | `3.0.0+` |

> **API generation:** Dart `3.x` and Java `2.x` are the same (UTC-instant)
> API generation. Dart `4.0.0` ⟷ Java `3.0.0` add strict city resolution
> (unknown cities now throw — a behavior break). The version numbers differ
> only because each follows its own ecosystem's semver.

## License

Licensed under the [Apache License 2.0](LICENSE).
