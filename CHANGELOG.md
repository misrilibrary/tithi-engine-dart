# Changelog

## 2.2.0

City **display-name disambiguation**. **No breaking changes** — map keys, the
`City` name constants, and every calculation are unchanged; the new metadata is
display-only.

- `CityLocation.region` — a region/country qualifier, now populated for **all**
  cities (US state, Canada province, otherwise country). Null only for
  self-qualifying names (Singapore, Hong Kong, Bahrain, Washington DC).
- `City.qualifiedName(name)` — always-qualified label for pickers / search
  lists (e.g. `'Seattle'` → `'Seattle, WA'`, `'Tokyo'` → `'Tokyo, Japan'`);
  bare for self-qualifying/unknown names.
- `City.displayName(name)` — compact label that qualifies **only** the 14
  commonly-confused names (e.g. `'Redmond'` → `'Redmond, WA'`; `'Delhi'` →
  `'Delhi'`). It is the selective subset of `qualifiedName`.


## 2.1.0

Engine accuracy overhaul. **No public API change.** Output is identical for every
supported city, both month-systems, and every day 1900-2100 (verified by a
comprehensive 460-file regression: 230 cities x {purnimant, amanta} x every day).
Behaviour only changes — for the better — for dates outside the tabled range,
which now use a much more accurate astronomical fallback.

Engine:
- Evaluate the Meeus Sun/Moon series in Terrestrial Time via a pure-Dart
  Espenak-Meeus delta-T (UT -> TT); fixes the dominant, time-growing error.
- Moon longitude now carries the same nutation term as the Sun, so nutation
  cancels in the Moon-Sun elongation (tithi) and the Moon is apparent
  (correct for nakshatra / Moon-rasi).
- Replace the low-accuracy Meeus Ch.25 Sun with a truncated VSOP87 series
  (mean ~1.5", max ~6.6" vs Swiss Ephemeris over 1900-2100).

Data / size:
- All 230 per-city correction tables regenerated against the improved engine
  (invariant Meeus + corrections = Swiss preserved exactly).
- Removed the unused internal `SankrantiCorrections` tables (month naming uses
  the sidereal Sun sign at the new-moon moment, not a sankranti table).
- Net: published library ~42% smaller (lib 675 -> 392 KB; correction data
  582 -> 296 KB; correction entries 32,603 -> 13,109).

## 2.0.3

Tests only — no API or behavior change (engine output identical to 2.0.x).

- Remove the platform-brittle `golden_facade_parity` hash test from the package.
  Its exact FNV-1a hash over ~39.7k astronomy outputs depends on libm `sin`/`cos`,
  which aren't bit-identical across platforms, so it could fail on a different
  platform than where the baseline was locked. Correctness is covered portably by
  the Drik-truth tests and the day-level vriddhi/kshaya invariant test.

## 2.0.2

Packaging only — no API or behavior change (golden hash `ef8a845c5a74b8c6` unchanged).

- Exclude generated `doc/` from the published archive (2.0.1 accidentally shipped
  ~165 KB of dartdoc output because `.pubignore` replaces `.gitignore`); archive
  back to ~226 KB via a comprehensive `.pubignore`.

## 2.0.1

Tooling/formatting only — no API or behavior change (golden hash
`ef8a845c5a74b8c6` unchanged).

- Apply `dart format` to all sources (2.0.0 shipped unformatted files, costing
  pub.dev points).
- Add `tools/preflight.sh` (format → analyze --fatal-infos → test → publish
  dry-run) and make CI run the format check first with `--fatal-infos`.
- Exclude dev-only `tools/` and `coverage/` from the published package via
  `.pubignore`.

## 2.0.0

Major redesign: a single public entry point and registration-based city data,
mirroring the Java `tithi-engine`. Numerical output is **unchanged** — a
facade-driven golden parity test reproduces the locked characterization hash
`ef8a845c5a74b8c6` (39,710 lines) bit-for-bit.

### Breaking changes
- **`Panchang` is the single public entry point.** The barrel
  (`package:tithi_engine/tithi_engine.dart`) no longer exports the engine
  internals — `TithiCalculator`, the tithi-number utilities (`getTithiName` /
  `getPaksha` / `tithiInPaksha` / `calculateTithi`), `convertMonth`, and the free
  functions `findFestivalDate` / `findRecurringDates`. Drive everything through
  `Panchang` (`dateFor` / `recurringDates` / …).
- **`Panchang` requires a city-data registrar list; the zero-arg constructor is
  removed:**
  ```dart
  Panchang(List<void Function()> data, {MonthSystem system = MonthSystem.purnimant})
  // e.g. Panchang([registerAllCities])  or  Panchang([registerIndia])
  ```
  This makes it impossible to construct a `Panchang` without city data (no silent
  Meeus fallback) while letting the tree-shaker drop unused cities.
- **City data is registration-based.** The core holds a mutable registry that
  consumers populate via data packs; the static all-cities registry is gone.
  - `package:tithi_engine/data/all.dart` → `registerAllCities()` (all 230 cities)
  - `package:tithi_engine/data/india.dart` → `registerIndia()` (30 cities; region pack)
  - A city that is never registered resolves to empty corrections (Meeus fallback).
  - **Subset win:** importing only `data/india.dart` compiles to ~112 KB JS vs
    ~404 KB for all-cities (**−72%**) — the tree-shaker drops unused cities.

### Added
- `Panchang.forDate(date, city, {utcOffset})` — time-of-day (birth-time) precision.
- `Panchang.recurringDates(festival, year, city)` → `List<FestivalDate>`.
- `Panchang.transitionTime(date, {utcOffset})` — intra-day tithi transition moment.
- `TithiInfo.fromStored({tithiNumber, month, storedSystem, isAdhika, displaySystem})`
  — render a saved tithi, with optional Purnimant↔Amant month-name conversion.
- Re-exported `tithiNames` (the 15 canonical names).
- Region data packs + `registerCity` / idempotent registrars.

### Performance
- Per-city `LunarMonthResolver` caching: non-default cities no longer rebuild the
  resolver (and recompute month spans) on every call. Month-grid latency for
  non-default cities dropped ~27–54× (e.g. Seattle 53,168 → 993 µs/grid); all
  cities now converge to ~1 ms/grid.

### Tests
- Public-API + day-level coverage (`getDate`/`findNext`/`transitionTime`,
  time-of-day `forDate`, `TithiInfo.fromStored`, Meeus fallback, registry
  contract, day-level vriddhi/kshaya). Core line coverage ~87%, 520 tests.

## 1.0.9

- Fix kshaya tithi detection at 30→1 wraparound (Shukla Pratipada)
- Fix kshaya detection at month span start (e.g. Krishna Pratipada in Purnimant)
- Affected: findInYear now correctly returns the previous day for skipped tithis

## 1.0.8

- Fix medellín directory encoding issue (CI)
- 230 cities total

## 1.0.7

- Add 21 cities (230 total): Honolulu, Tampa, Pittsburgh, Columbus, Indianapolis, Kansas City, St. Louis, Sacramento, Halifax, Regina, Gothenburg, Lyon, Naples, Zagreb, Krakow, Thessaloniki, Porto, Rotterdam, Beirut, Ankara, Redmond

## 1.0.0

- Initial release
- Tithi calculation: date → tithi number, name, paksha, lunar month
- Festival dates with muhurta rules (nishita, madhyahna, pradosh, sunrise)
- Month resolution: adhika/kshaya detection, Purnimant & Amant systems
- Date finding: tithi → Gregorian date(s) in any year
- 157 supported cities with per-city sunrise corrections
- 200-year accuracy (1900–2100), validated against Swiss Ephemeris

## 1.0.6

- Fix dart format for all generated files
- CI green (actions/checkout@v5)

## 1.0.5

- Fix LICENSE: use exact canonical Apache 2.0 text from apache.org

## 1.0.4

- Fix LICENSE recognition (full Apache 2.0 text for pub.dev detection)
- Fix all static analysis issues (50/50 pub.dev score)

## 1.0.3

- Reduce package size by 67% (1.8 MB → 586 KB) by stripping date comments from correction files
- No API or behavior change

## 1.0.2

- Expand city coverage from 157 → 209 cities worldwide
- New regions: Pakistan (3), Caribbean (5), Africa (7), Europe (12), Americas (12), Asia (4), Oceania (3)
- All new cities verified 100% accurate against Swiss Ephemeris (1900–2100)

## 1.0.1

- Export additional symbols: getPaksha, tithiInPaksha, calculateTithi, convertMonth
