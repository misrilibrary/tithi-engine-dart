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
- **230 cities** — per-city correction tables verified against JPL Swiss Ephemeris (`.se1`)
- **Sunrise convention** — upper-limb "first ray" (default) or centre-of-disc "half disk visible", both Swiss-corrected
- **Pure Dart** — no dependencies, works in Flutter, server, CLI, and web (WASM)
- **200-year accuracy** — exhaustively validated 1900–2100 (33.77M city-days, 14/14 compute points 🟢)

## Installation

```yaml
dependencies:
  tithi_engine: ^5.0.0
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
final birthTithi = panchang.tithiAtInstant(birthUtc, City.of('Austin'), offset: cdt);
print(birthTithi.displayName);

// Festival date
final shivaratri = panchang.dateFor(
  festivals.firstWhere((f) => f.name == 'Maha Shivaratri'), 2026, City.ujjain);
print('Maha Shivaratri 2026: ${shivaratri?.date}');

// Tithi → Date (typed: pass a Tithi and a City)
final date = panchang.findDate(
  LunarMonth.bhadrapada, Tithi.krishna(8), 2026, City.seattle);
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
| `package:tithi_engine/data/all_center.dart` | `Panchang([registerAllCities, registerAllCitiesCenterDisc], convention: SunriseConvention.centerDisc)` | centerDisc tables for all 230 cities (opt-in) |

Combine packs: `Panchang([registerIndia, registerEurope])`.

## API

`Panchang` is the single entry point. Value types (`TithiInfo`, `TithiSegment`,
`LunarMonth`, `MonthSystem`, `Paksha`, `Tithi`, `SunriseConvention`, `FestivalDef`,
`MuhurtaRule`, `festivals`, `FestivalDate`, `City`, `Location`, `LocationSource`) are
exported; the engine internals are not.

`FestivalDate` carries `month` (actual `LunarMonth` of the occurrence) and `isAdhika`,
computed from `tithiOnDate` at the occurrence date — so recurring festivals show the
correct month (not the definition's placeholder).

The time-aware API is **UTC-instant based**: you pass true UTC instants and, where
a civil day matters, the DST-aware offset in effect (the engine does no timezone
resolution — resolve the offset yourself, e.g. via `package:timezone`).

> **Breaking in 5.0.0:** every city-keyed method now takes a `City` (not a
> `String`) and `findNext` is typed (`findNext(month, Tithi, city, {from})`).
> `City.*` constants are now `City` instances and `City.values` returns
> `List<City>`. The 4.x deprecated surface — `getDate`/`getDates`, the primitive
> `findNext`, `tithiNames`, `supportedCities`, `CityLocation`, `getLocationForCity`,
> and `FestivalDate.festival` — has been **removed**. Use the typed value types
> `Tithi` (`Tithi.shukla(8)`, `Tithi.krishna(11)`, `Tithi.ofNumber(23)`;
> `.number`/`.name` own the Purnima/Amavasya rule) and `City`
> (`City.of(name)` / `City.tryOf(name)`, `City.ujjain`, `resolveCityName`).
> Construct a `City` at the boundary; persisted data can stay string-keyed.
>
> See [Migrating from 4.x to 5.0](#migrating-from-4x-to-50) for the full mapping.

| Method | Description |
|--------|-------------|
| `Panchang(data, {system, convention})` | Construct with city-data registrars (`data` required); `convention` selects the sunrise definition (default `upperLimb`) |
| `panchang.tithiOnDate(date, city)` | Sunrise tithi of the panchang day (display/observance) |
| `panchang.tithiAtInstant(utcInstant, city, {offset})` | Tithi at an exact UTC moment (birth-time) |
| `panchang.tithiSegments(windowStartUtc, windowEndUtc, city, {offset})` | Every tithi segment in a UTC window (N transitions → N+1 segments) |
| `panchang.findDate(month, Tithi, year, city)` | Tithi spec → Gregorian date |
| `panchang.findDates(month, Tithi, year, city)` | Tithi spec → all dates, adhika-aware |
| `panchang.dateFor(festival, year, city)` | Festival → date with muhurta rules |
| `panchang.recurringDates(festival, year, city)` | Recurring festival → all occurrences in the year |
| `panchang.findNext(month, Tithi, city, {from})` | Next occurrence of a tithi on/after `from` (defaults to now) |
| `panchang.at(location)` | Bind to a `Location` (city name or raw `lat/lng`) → `PanchangAt` (same methods, no `city` arg) |
| `panchang.sunrise(date, city)` / `sunset(date, city)` | Sunrise/sunset UTC `DateTime` (Meeus, ~1 min; no per-city correction) |
| `TithiInfo.fromStored(...)` | Render a saved tithi (with optional Purnimant↔Amant display conversion) |

### City names

Every city-keyed method takes a `City`. Construct one with `City.of('Name')`
(throws `ArgumentError` if unsupported) or `City.tryOf('Name')` (returns `null`),
or use a convenience constant like `City.seattle`. Either way a `City` value always
denotes a **supported** city. Name resolution is **case- and space-insensitive** and
accepts the qualified `"City, Region"` form, so all of these resolve to the same city:

```dart
City.of('New York');               // canonical
City.of('new york');               // case-insensitive
City.tryOf('Atlantis');            // unsupported → null
resolveCityName('New York, NY');   // qualified form → 'New York'
```

The canonical identity is the **(city, region)** pair: the bare name maps to the
*primary* city for that name, and the qualified `"City, Region"` form selects a
specific one when several share a name (e.g. a future `'Vancouver, WA'` vs
`'Vancouver, BC'`). There is **no fuzzy/region-stripping match** — a wrong region
(`'Vancouver, WA'` when only BC exists) is treated as unknown.

An **unsupported name is rejected at construction**: `City.of` throws `ArgumentError`
(the engine never silently substitutes another location, because a wrong location
produces wrong sunrise-based tithis and festival dates). To validate without throwing,
use `City.tryOf(name)` (or `resolveCityName(name)`); enumerate with `City.values`. Need
a city added? Open an issue:
<https://github.com/misrilibrary/tithi-engine-dart/issues>.

### By coordinates

Have raw `lat/lng` (a GPS fix, a map pin) instead of a name? Bind a `Location` with
`Panchang.at(...)`:

```dart
final panchang = Panchang([registerAllCities]);

// A point that rounds into a supported city's 0.1° cell reuses that city
// wholesale (Swiss-corrected). offset is optional here.
final here = panchang.at(Location.at(47.61, -122.33));
final info = here.tithiOnDate(DateTime.utc(2026, 2, 15));
here.source; // LocationSource.cityCorrected

// A point outside every city's cell is Meeus-only (~99.97%) and REQUIRES the
// DST-aware UTC offset (used to frame the civil day).
final remote = panchang.at(Location.at(0.0, -140.0, offset: Duration(hours: -9)));
remote.source; // LocationSource.meeusRaw

// Location.city(name) is the named-city form of the same binding.
panchang.at(Location.city('Seattle')).tithiOnDate(DateTime.utc(2026, 2, 15));
```

`PanchangAt` exposes the same read methods as `Panchang` minus the `city` argument
(`tithiOnDate`, `tithiAtInstant`, `tithiSegments`, `findDate`/`findDates`, `findNext`,
`dateFor`, `recurringDates`, `sunrise`/`sunset`). Cities are stored at ~0.1° (~11 km),
so any point within a city's cell is treated as that city.

> **Recommendation:** prefer `Location.city(name)` (or a coordinate that lands in a
> supported city's cell) when you can. A named city carries Swiss‑Ephemeris correction
> tables — guaranteed accuracy. Off‑grid coordinates are Meeus‑only (~99.97% on
> day‑assignment): excellent, but the rare knife‑edge days a city's correction would fix
> are not covered. Use raw coordinates only when no nearby supported city exists.

### Sunrise convention

The instant of "sunrise" — which the whole sunrise-tithi/observance model hinges
on — has two common definitions. Pick one at construction (default is unchanged):

```dart
import 'package:tithi_engine/data/all.dart';
import 'package:tithi_engine/data/all_center.dart';

// Default: upper limb at the horizon ("first ray"), −0.833° (34′ refraction +
// 16′ semidiameter). Omitting `convention` reproduces the original behavior.
final p = Panchang([registerAllCities]);

// Centre of the disc on the horizon ("half disk visible"), −0.5667° (refraction
// only). Sunrise lands ~1–4 min later (sunset earlier), latitude-dependent.
// REQUIRES the centerDisc data pack for Swiss accuracy.
final pc = Panchang([registerAllCities, registerAllCitiesCenterDisc],
    convention: SunriseConvention.centerDisc);
```

Both conventions are **Swiss-corrected** when their data pack is registered
(0 mismatches over 230 cities × 73,414 days). The convention threads through
`tithiOnDate`, `tithiAtInstant`, `tithiSegments`, month boundaries, festival
muhurtas, and `sunrise`/`sunset`. If you register `centerDisc` but want the
default behavior, just construct without the `convention` argument — the two
table sets are independent and the upper-limb path is untouched.

## Migrating from 4.x to 5.0

5.0 is a breaking release that removes the 4.x deprecated surface and makes the
city/tithi API fully typed. The calculations are **unchanged** (byte-identical to
4.4.0, verified against `.se1`) — only the API surface changed. If you adopted the
4.4.0 replacements already, most of this is done.

**Removed symbol → replacement**

| Removed in 5.0 | Use instead |
|---|---|
| `getDate(month, paksha, tithiInPaksha, year, city)` | `findDate(month, Tithi.shukla(n)` / `Tithi.krishna(n), year, City.of(city))` |
| `getDates(...)` | `findDates(month, Tithi, year, City)` |
| `findNext(month, paksha, tithiInPaksha, city)` (primitive) | `findNext(month, Tithi, City, {from})` (typed) |
| `tithiNames[i]` | `getTithiName(n)` (owns the Purnima/Amavasya rule) |
| `supportedCities` (`Map<String, CityLocation>`) | `City.values` (`List<City>`) |
| `supportedCities.containsKey(c)` / `City.isSupported(c)` | `City.tryOf(c) != null` |
| `CityLocation` | removed — coordinates via `Location`, offsets via your own tz layer |
| `getLocationForCity(c)` | `Panchang.at(Location.city(c))`; the engine no longer exposes city geo/offset data |
| `FestivalDate.festival` | direct getters: `result.month`, `.name`, `.tithiNumber`, `.paksha`, `.tithiInPaksha`, `.muhurta`, `.recurring` |

**Every city-keyed method now takes a `City`, and tithi specs take a `Tithi`:**

```dart
// 4.x
panchang.tithiOnDate(date, 'Ujjain');
panchang.getDates(LunarMonth.kartika, Paksha.shukla, 11, 2026, 'Seattle');
panchang.findNext(LunarMonth.chaitra, Paksha.shukla, 9, 'Delhi');

// 5.0
panchang.tithiOnDate(date, City.of('Ujjain'));            // or City.ujjain
panchang.findDates(LunarMonth.kartika, Tithi.shukla(11), 2026, City.of('Seattle'));
panchang.findNext(LunarMonth.chaitra, Tithi.shukla(9), City.of('Delhi'));
```

**Constructing a `City`.** `City` has no public default constructor — it validates
at construction, so a `City` value always denotes a supported city:

```dart
City.of('Ujjain');         // throws ArgumentError if unsupported
City.tryOf('Ujjain');      // City? — null if unsupported
City.ujjain;               // a const convenience instance
```

For persisted/user-supplied names, resolve at the boundary and fall back to the
engine-provided `defaultCity` (itself a `City`, always supported):

```dart
final city = City.tryOf(savedName) ?? defaultCity;
```

**`Tithi`** is likewise factory-only: `Tithi.shukla(1..15)`, `Tithi.krishna(1..15)`,
or `Tithi.ofNumber(1..30)`; `.number`/`.name`/`.paksha`/`.dayInPaksha` read it back.

**Type changes to remember:** `City.values` now returns `List<City>` (was
`List<String>`); the `City.*` constants are `City` instances (was `String`);
`defaultCity` is a `City` (was a `String`). Persisted data can stay string-keyed —
construct a `City` only at the boundary.

## Accuracy

Source of truth: **JPL Swiss Ephemeris (`.se1`)**, exhaustively verified 1900–2100,
all 230 cities, both conventions (upper limb / centre of disc), both month systems.

| Metric | Value |
|--------|-------|
| Day-tithi vs `.se1` (tithiOnDate) | **0 mismatches** (33.77M city-days: 230 cities × 73,414 days × 2 conventions) |
| Transition instants vs `.se1` | **0 >30 s** (all 74,582 transitions, global correction applied) |
| Sunrise/sunset vs `.se1` | **0 >60 s**, max 15.7 s (33.77M, both conventions) |
| Lunar month + adhika vs `.se1` | **0 mismatches** (all 2,486 new moons, both systems) |
| `getDates` (tithi→date, reverse + forward) | **0 mismatches** (16.9M, kshaya/vriddhi-aware) |
| `tithiAtInstant` (birth-time) | **0 whole-day-shift days**; 0.0145% near-transition residual ≤30 s |
| Festival dates vs Drik Panchang | 22/22 (2025–2026) |
| Test coverage | 586 tests |

All 14 compute points are 🟢 at the minute-level accuracy bar. The only residual
is sub-minute (≤30 s near-transition slivers, provably below display resolution).
Full benchmark: [`ACCURACY_BENCHMARK.md`](ACCURACY_BENCHMARK.md).

## Performance

Per-call latency of the public API, timed the way a client calls it (warm VM, a
reused `City`) with the `bench_api` tool, the same business outcome benchmarked
against each engine version. Absolute numbers are machine-dependent (measured on
an Apple-silicon laptop, `minMs=400`) — read them as orders of magnitude and
relative cost, not a spec.

| API (µs/call) | 4.3.1 | 4.4.0 | 5.0.0 |
|--------|------:|------:|------:|
| `sunrise` / `sunset` | 2.55 | 2.56 | 2.56 |
| `tithiOnDate` | 11.3 | 12.3 | 11.3 |
| `tithiSegments` (1-day window) | 33.5 | 33.8 | 33.2 |
| `tithiAtInstant` | 80.8 | 77.3 | 76.5 |
| `findDate` | 220 | 222 | 223 |
| `findDates` | 224 | 220 | 219 |
| `dateFor` (festival + muhurta) | 276 | 281 | 274 |
| `findNext` | 802 | 763 | 774 |
| `recurringDates` (full year) | 1646 | 1907 | 1895 |

**The 5.0 typed-API migration adds no measurable latency** — every column matches
4.4 within run-to-run noise (the compute is identical; only the surface types
changed). The typed value types are effectively free: `City.of(name)` ~0.4 µs and
`Tithi.shukla(n)` ~0.02 µs, below the noise floor of every operation above and a
one-time cost when a `City` is reused.

The one intentional difference is `recurringDates`, ~15% slower in 4.4/5.0 than
4.3 — since 4.4 its year scan uses the Swiss-corrected day tithi (the
masik-festival accuracy fix) instead of raw astronomy, a deliberate
accuracy-for-latency trade carried unchanged into 5.0.

## Cross-Platform

This is the Dart implementation of [tithi-engine](https://github.com/misrilibrary/tithi-engine) (Java). Both compute identical tithi/panchang results, validated against the Swiss Ephemeris.

The two packages **version independently** — each version string is a semver compatibility contract for *that* ecosystem. What stays locked in step is the **astronomy engine revision** (the correctness-critical part) and the feature parity tracked below.

- **Engine revision:** `r3` — VSOP87 Sun + Meeus Moon in Terrestrial Time (Espenak–Meeus ΔT), nutation cancelled in the Moon–Sun elongation, **global tithi-transition correction** (16,266 delta-encoded entries vs JPL `.se1`), **iterative sunrise/sunset** (3-iter refinement, latitude-robust). Per-city correction tables regenerated against `.se1`. Dart `4.3.0+` ⟷ Java _(pending)_. Verified: 0 mismatches over 230 cities × 73,414 days × 2 conventions (33.77M city-days).

| Capability | Dart (tithi_engine) | Java (tithi-engine) |
|---|---|---|
| Astronomy engine rev `r2` (VSOP87/TT) | `2.1.0+` | `1.1.0+` |
| 230 cities, Swiss-verified tables | `2.1.0+` | `1.1.0+` |
| City display-name disambiguation (`region` / `qualifiedName` / `displayName`) | `2.2.0+` | `2.0.0+` |
| Time-aware API (`tithiOnDate` / `tithiAtInstant` / `tithiSegments`) | `3.0.0+` | `2.0.0+` |
| `recurringDates` / `findNext` / `TithiInfo.fromStored` | `2.0.0+` | `2.0.0+` |
| Strict city resolution (`resolveCityName`, fail-fast on unknown, `"City, Region"` form) | `4.0.0+` | `3.0.0+` |
| Coordinate input (`Location` / `Panchang.at`, 0.1° cell reuse) | `4.0.0+` | `3.0.0+` |
| Sunrise / sunset (`sunrise` / `sunset`, Meeus) | `4.1.0+` | `3.1.0+` |
| Sunrise-convention toggle (`SunriseConvention`, centerDisc Swiss tables) | `4.2.0+` | _(pending)_ |
| Engine rev `r3`: global transition correction + iterative sunrise (JPL `.se1` parity) | `4.3.0+` | _(pending)_ |
| `FestivalDate.month` actual month (not def placeholder) for recurring festivals | `4.3.1+` | _(pending)_ |
| `Tithi` + `City` value types, typed `findDate`/`findDates`, `getTithiName`/`resolveCityName` exports (legacy surface deprecated) | `4.4.0+` | _(pending)_ |

> **API generation:** Dart `3.x` and Java `2.x` are the same (UTC-instant)
> API generation. Dart `4.0.0` ⟷ Java `3.0.0` add strict city resolution
> (unknown cities now throw — a behavior break) and coordinate input
> (`Location` / `Panchang.at`); Dart `4.1.0` ⟷ Java `3.1.0` add sunrise/sunset.
> Dart `4.2.0` adds the sunrise-convention toggle (upper-limb default / centerDisc
> half-disk, Swiss-corrected). Dart `4.3.0` upgrades to engine revision `r3`:
> **JPL `.se1` parity** via global transition correction + iterative sunrise
> (a data+precision improvement — the public API is unchanged from 4.2.0).
> Dart `4.3.1` adds `FestivalDate.month` (actual month of occurrence for recurring
> festivals). Java counterparts for 4.2+ are pending.
> The version numbers differ only because each follows its own ecosystem's semver.

## License

Licensed under the [Apache License 2.0](LICENSE).
