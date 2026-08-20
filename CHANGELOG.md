## 5.2.0

- **Fixed observance rule for `janmashtami_kashmiri` (Zarma Satam).** Changed
  `muhurta` from `MuhurtaRule.nishita` to `MuhurtaRule.sunrise`. The festival is
  now assigned to whichever day holds Krishna Saptami (tithi 7) at sunrise,
  matching the regular Kashmiri Pandit jantri convention, instead of checking
  for the tithi at midnight. This shifts the computed date for some
  year/city combinations (e.g. 2026, Seattle: Sep 2 → Sep 3) and means
  `FestivalDate.muhurtaStart`/`muhurtaEnd` are now `null` for this festival
  (no muhurta window is reported for `sunrise`-rule festivals). Not a breaking
  API change — only the returned `date`/`muhurtaStart`/`muhurtaEnd` values for
  this specific festival id are affected.

## 5.1.1

- **Internal cleanup (no public-API change).** Removed the unreachable `src/`-only
  `pinnedCities` and `orderedCityList` (city pinning/ordering is consumer UI
  policy, never exported through the barrel) and the dead `astronomy.dart`
  re-export that referenced them (`defaultCity` is unaffected). Marked the
  internal `CityLocation` and `cityRegistry` as not-public-API in their doc
  comments. No symbol reachable via `package:tithi_engine/tithi_engine.dart`
  changed — hence a patch, not a breaking release.

## 5.1.0

- **Added 15 US cities**, each with Swiss-Ephemeris-corrected tables for both sunrise
  conventions (upper-limb + center-disc), verified 0 mismatches vs `.se1` across
  1900–2100:
  - Kentucky: **Louisville**, **Lexington**
  - South Carolina: **Columbia**, **Charleston**, **Greenville**
  - Ohio: **Cleveland**
  - New Jersey: **Edison**, **Jersey City**
  - Virginia: **Ashburn**, **Fairfax**
  - Maryland: **Rockville**  · Connecticut: **Stamford**
  - Texas: **San Antonio**  · Wisconsin: **Milwaukee**  · New York: **Buffalo**
  Registry now 245 cities.

## 5.0.0

**BREAKING** — the cutover release that completes the 4.4.0 API evolution. All
symbols deprecated in 4.4.0 are now removed, and the city/tithi method surface is
fully typed. Migrate off the deprecated APIs on 4.4.0 first (zero
`// ignore: deprecated_member_use`), then bump to 5.0.0.

**Removed (were deprecated in 4.4.0):**
- `FestivalDate.festival` — use the direct getters (`id`, `name`, `month`,
  `tithiNumber`, `paksha`, `tithiInPaksha`, `muhurta`, `recurring`, `isAdhika`).
- `tithiNames` — use `getTithiName(int)`.
- `supportedCities` — use `City.values` + `City.tryOf` (or `resolveCityName`).
- `CityLocation` — retracted from the public surface (the engine no longer
  publishes city geo/timezone data; resolve coordinates via `Location` and
  offsets via IANA).
- `getLocationForCity` — use `Panchang.at(Location.city(name))`.
- `getDate` / `getDates` — use `findDate` / `findDates` with a `Tithi`.
- primitive `findNext(month, paksha, tithiInPaksha, city)` — replaced by the
  typed signature below.

**Changed (breaking):**
- Every city-keyed `Panchang`/`PanchangAt` method now takes a `City` (not a
  `String`): `tithiOnDate`, `tithiAtInstant`, `tithiSegments`, `findDate`,
  `findDates`, `dateFor`, `recurringDates`, `sunrise`, `sunset`. Construct a
  `City` at the boundary (`City.of('Seattle')` or `City.seattle`); persisted data can
  stay string-keyed. `region` is display-only and never affects a calculation.
- `findNext` is now typed: `findNext(LunarMonth month, Tithi tithi, City city,
  {DateTime? from})` (and `PanchangAt.findNext(month, tithi, {from})`).
- `City.*` convenience constants (`City.ujjain`, `City.seattle`, …) are now `City`
  instances instead of `String`s.
- `City.values` now returns `List<City>` (was `List<String>`).
- `defaultCity` is now a `City` instance (was a `String`).
- **`City` has no public default constructor.** Construct via `City.of(String)`
  (throws `ArgumentError` if unsupported) or `City.tryOf(String)` (returns `null`),
  so a `City` value always denotes a supported city — symmetric with `Tithi`'s
  validated factories. The `region` is taken from the registry (callers don't
  supply it). Use at the persisted-data boundary: `City.tryOf(saved) ?? defaultCity`.
- `City.isSupported(String)` is **removed** — it is exactly `City.tryOf(name) != null`.

**Public city surface (string-level only):** `City.of`, `City.tryOf`, `City.values`,
`resolveCityName`, `City.qualifiedName`, `City.displayName`, `defaultCity`.

## 4.4.0

Additive, non-breaking release that introduces typed value types and replacement
APIs, and deprecates the symbols they replace (all deprecated symbols are removed
in 5.0.0).

- **Fixed:** `recurringDates` (masik festivals) used raw Meeus tithi instead of the
  corrected day-tithi, causing off-by-one dates on correction days (high-latitude
  especially) — the same class as the 4.3.0 `getDates` fix, which had missed
  `findRecurringDates`. Now uses the corrected `tithiOnDate`. Verified vs `.se1`-proven
  tithiOnDate across all 230 cities × 2000–2030 (0 mismatches; `findNext` was clean).

**Added:**
- `Tithi` value type — `Tithi.shukla(n)`, `Tithi.krishna(n)`, `Tithi.ofNumber(1–30)`;
  getters `number`, `paksha`, `dayInPaksha`, `name` (owns the paksha-dependent
  Purnima/Amavasya naming rule).
- `City` value type — concrete `const City(name, {region})` coexisting with the
  existing `City.*` string constants; plus `City.isSupported(String)`.
- Typed `findDate(month, Tithi, year, city)` / `findDates(...)` on `Panchang` and
  `PanchangAt` (the `city` argument stays `String` this release).
- Exported `getTithiName(int 1–30)` and `resolveCityName(String) → String?`.
- `FestivalDate` direct getters: `id`, `tithiInPaksha`, `muhurta`, `recurring`
  (so `.festival` is never needed).
- Fail-fast guard for a genuinely ambiguous bare city name (no collisions today).

**Deprecated (removed in 5.0.0):**
- `FestivalDate.festival` → access fields directly on `FestivalDate`.
- `tithiNames` → `getTithiName(int)`.
- `supportedCities` → `City.values` + `City.tryOf` (or `resolveCityName`).
- `getLocationForCity` → `Panchang.at(Location.city(name))`.
- `getDate` / `getDates` → `findDate` / `findDates` (typed `Tithi`).
- `findNext` → typed `findNext(Tithi)` arrives in 5.0.

## 4.3.1
- FestivalDate now carries the actual lunar month of the occurrence (computed via
  tithiOnDate), not the placeholder month from the FestivalDef. Fixes recurring
  festivals (Ekadashi, Purnima, Amavasya, etc.) always showing "Chaitra".
- Added convenience getters: name, tithiNumber, paksha on FestivalDate.

# Changelog

## 4.3.0

**Iterative sunrise/sunset.** `computeSunrise`/`computeSunset` now refine the
Sun's declination / equation-of-time **at the rise/set instant** (3 iterations)
instead of at noon, at full resolution (no minute rounding). This removes a
systematic, latitude-growing sunrise error (engine-vs-Swiss **18–38s → 4–6s**),
most pronounced at high latitude.

**Correction tables regenerated for all 230 cities, both conventions**, against
the iterative sunrise and **verified 0 mismatches vs Swiss Ephemeris**
(1900–2100, every supported city):
- upperLimb: 6215 → 3932 entries (**−37%**)
- centerDisc: regenerated (3972 entries)

586/586 engine tests pass. Generated via the unified engine-backed
`gen_convention_corrections`; the drifted standalone `gen_city_corrections` was
deprecated. (A higher-fidelity ELP elongation pass toward the ~1–6/city
irreducible floor remains as future work.)

**Global tithi-transition-time correction.** Tithi *transition times* (used for
displayed transition instants and birth-time `tithiAtInstant`) were previously
raw Meeus — up to **~134s off Swiss** on days not covered by the sunrise-tithi
table (the old per-city snapping only fixed days where the sunrise tithi itself
disagreed). Because a tithi transition is a **geocentric** event (the instant is
identical worldwide), the per-city transition tables were both incomplete and
redundant. They are replaced by a **single city-independent Swiss correction
list** (delta-encoded, 16,219 entries) applied at the astronomy layer:
- Every transition is now **within 30s of Swiss** worldwide — verified across
  **74,582 transitions (1900–2100), 0 remaining off**.
- `tithiAtInstant` and `tithiSegments` now share one anchored model (corrected
  sunrise tithi + step across corrected transitions), so they always agree.
- The 230 per-city `TransitionMinutesMap` tables (~6.2k entries) were removed;
  net the published archive is **smaller** (173 KB vs 175 KB) despite the more
  complete correction, thanks to delta encoding.

**Source of truth = JPL `.se1` (Swiss Ephemeris), and redundant tables removed.**
All correction tables were regenerated against the JPL-derived Swiss Ephemeris
(`seFlgSwiEph`) instead of Moshier. Verified vs `.se1` over 1900–2100:
- **tithiOnDate**: 230 cities × 73,414 days × both conventions = **33.77M checks,
  0 mismatches**.
- **Sunrise/sunset**: full coverage, **0 days >60s** off `.se1` (max ~16s, high
  latitude far from epoch).
- **Amavasya/Purnima correction tables removed** (565 entries): with the day-tithi
  now `.se1`-exact, the resolver derives new-moon/full-moon boundary days from the
  corrected sequence, making the boundary tables dormant (0 fired, 0 double-dip) —
  removal is output-neutral.
- **Tithi → date lookup / festival dates corrected.** `findTithiRaw` /
  `findNextOccurrence` (behind `getDates`, `findInYear`, `dateFor`) matched on raw
  Meeus tithi, ignoring the correction table — so festival dates were off by a day
  on correction days (frequent at high latitude). Now use the corrected day-tithi.
  Full verification (all 230 cities × 1900–2100, 16.9M days): 0 invalid dates, 0
  missing dates vs `tithiOnDate` (kshaya/vriddhi conventions verified).
- **Segment / birth-time labels corrected on sunrise-straddle days.**
  `tithiSegments` and `tithiAtInstant` anchored their labels on `tithiOnDate` (the
  `.se1` tithi at the *true* sunrise) but stepped in the engine's Meeus frame. On
  ~0.008–0.010% of days (both conventions), where the engine's Meeus sunrise lands
  on the opposite side of a near-sunrise transition from the true sunrise, the
  anchor was placed on the wrong segment and the **whole day's** tithi labels /
  birth-time tithi shifted by one. Now each segment/instant is labeled by its own
  Swiss-corrected elongation tithi (segment midpoint), independent of the sunrise
  anchor (`tithiOnDate` remains a separate, correct day label). Exhaustive
  verification: `tithiAtInstant` whole-day-shift days **→ 0** (135M samples);
  segment-label mismatches **8,391/8,413 → 7,425** per convention — the remainder
  being only sub-minute slivers at near-midnight transitions (the ≤30s
  transition-time floor, accepted at minute resolution).

## 4.2.0

Added a **sunrise convention** toggle: `SunriseConvention.upperLimb` (the classic
"first ray" / upper-limb-at-horizon definition, −0.833°) and
`SunriseConvention.centerDisc` ("half disk visible" / centre-of-disc, −0.5667°).
Pass it to the constructor — `Panchang(data, {convention})` — defaulting to
`upperLimb`, so omitting it leaves existing behavior **byte-for-byte unchanged**
(verified across all 230 cities × 73,414 days × both month systems).

The convention is threaded through every sun-time-derived calculation
(`tithiOnDate`, `tithiAtInstant`, `tithiSegments`, month boundaries, festival
muhurtas, `sunrise`/`sunset`).

**centerDisc is Swiss-corrected, not Meeus-only.** New opt-in data pack
`package:tithi_engine/data/all_center.dart` (`registerAllCitiesCenterDisc`) ships
per-city centerDisc correction tables for all 230 cities; register it alongside
`registerAllCities`:

```dart
final p = Panchang([registerAllCities, registerAllCitiesCenterDisc],
    convention: SunriseConvention.centerDisc);
```

Verified: `tithiOnDate` + centerDisc tables == Swiss Ephemeris (disc-center) with
**0 mismatches over 230 cities × 73,414 days** (16,885,220 city-days), matching the
upper-limb guarantee. Transition minutes are convention-independent and reused
from the upper-limb tables (not duplicated). Pure upper-limb consumers omit the
new pack and pay **zero** added size.

## 4.1.0

Added **sunrise/sunset** to the public API: `Panchang.sunrise(date, city)` and
`Panchang.sunset(date, city)` (also on `Panchang.at(location)`), returning UTC
instants. Meeus astronomy (~1-minute accuracy); no per-city correction (the
correction tables adjust tithi, not sun times). Inherits strict city resolution
(throws on unknown city).

## 4.0.1

Festival data corrections (curated against the Kashmiri jantri):
- **Zang Trayi** corrected to Chaitra Shukla **3** (was Shukla 2).
- Removed duplicate entries: **Holika Dahan** (use **Holi**, both Phalguna S.15)
  and **Thal Buth Vuchun** (use **Navreh**, both Chaitra S.1).
- Removed **Thal Barun (Navreh)** — it is a *relative* observance (the day before
  Navreh, i.e. Chaitra K.15 normally but K.14 when Chaitra S.1 is kshaya), which a
  fixed tithi cannot represent. Deferred pending relative-festival support.

**36 built-in festivals.**

## 4.0.0

Added recurring festival **Shukla Ashtami** (`masik_shukla_ashtami`) — monthly
bright-fortnight Ashtami. Also added 11 curated festivals from the Kashmiri
jantri (Samvat 2082): Navreh, Thal Buth Vuchun, Zang Trayi, Durga Ashtami,
Nirjala Ekadashi, Zyeth Ashtami, Haar Ashtami, Navratri (Sharad) Begins,
Maha Navami, Karva Chauth, Bhai Dooj, Khichdi Amavasya, Gauri Tritiya, Kaav
Punim (Magh Purnima), Huri Aukdoh, Huri Ashtami.

Fixed: the festival/date finder no longer mis-attributes a previous month's
kshaya Purnima/Amavasya to the next month's span (e.g. getDates(Pausha, Shukla,
15) wrongly returning Margashirsha purnima dates); boundary-kshaya now applies
only to paksha-leading tithis (Pratipada).

Nishita Kaal muhurta window now uses the precise classical definition — the
**8th of the night's 15 muhurtas** (the central muhurta) — instead of the coarse
"third quarter of the night." Displayed Nishita windows now match Drik Panchang
(e.g. Janmashtami Smarta for Seattle 2026: 12:47–01:30 AM). Festival **dates are
unchanged** (the day-attribution moment is still the night midpoint, the centre
of this muhurta). No API change.

**City name resolution.** Lookup is now case- and space-insensitive and accepts the
qualified `"City, Region"` form, so `getLocationForCity('new york')` and
`'New York, NY'` resolve the same as `'New York'`. The canonical identity is the
`(city, region)` pair — the bare name maps to the *primary* city, the qualified form
selects a specific one when several share a name; there is **no fuzzy/region-stripping
match**. New `resolveCityName(name)` returns the canonical name or `null` (non-throwing
probe).

**Behavior change — unsupported cities now fail fast.** `getLocationForCity(name)`
(and therefore every `Panchang` call) throws `ArgumentError` for an unknown or
wrong-region city instead of silently using the default reference city. A wrong
location yields wrong sunrise-based tithis/festival dates, so the engine refuses to
guess. Validate with `resolveCityName(name)` (returns `null`) or `supportedCities`.
The correction-registry getters are unaffected (still return empty for an unregistered
city). Request new cities at <https://github.com/misrilibrary/tithi-engine-dart/issues>.

**Coordinate input.** New `Location` + `Panchang.at(Location)`: `Location.city(name)`
or `Location.at(lat, lng, {offset})`. A point that rounds into a supported city's
**0.1° cell** reuses that city wholesale (Swiss-corrected, `LocationSource.cityCorrected`);
a point outside every cell is Meeus-only (`LocationSource.meeusRaw`) and requires an
`offset`. Usage: `panchang.at(loc).tithiOnDate(date)` (and the other read methods).

## 3.0.0

Time-aware API redesign: **UTC-instant + explicit offset** (breaking). The
library now does **no timezone work** — callers resolve the DST-correct offset
and pass true UTC instants; the engine handles location-correct astronomy and
correction-table indexing. Tithi/month/festival *numerical output is unchanged*;
only the time-of-day entry points change shape.

### Breaking changes
- **`Panchang.forDate(date, city, {utcOffset})` is removed**, split into two
  intent-revealing methods:
  - `tithiOnDate(DateTime date, String city)` — sunrise tithi for the panchang
    day (observance/calendar display). No offset; sunrise is astronomical. This
    replaces the old date-only `forDate`.
  - `tithiAtInstant(DateTime utcInstant, String city, {required Duration offset})`
    — tithi active at an exact moment (birth-time precision). `utcInstant` must
    be a true UTC instant (asserted); `offset` is the DST-aware offset in effect
    at that instant, used *only* to derive the civil date for correction-table
    selection. This replaces the old time-of-day `forDate`.
  - This also removes the old `hasTime = hour!=0||minute!=0` heuristic, so a
    birth at exactly local midnight is no longer mis-read as a date-only query.
- **`Panchang.transitionTime(date, {utcOffset})` is removed**, replaced by
  `tithiSegments(DateTime windowStartUtc, DateTime windowEndUtc, String city,
  {required Duration offset})`. The caller frames the window (e.g. a civil day's
  local-midnight→midnight converted to UTC, DST-aware so 23h/25h on a changeover)
  and the engine enumerates **every** tithi transition inside it, returning N+1
  `TithiSegment`s — not just a single boundary. Each segment carries its own
  fully-resolved `TithiInfo` (paksha/month resolved per segment) and bounding
  instants.

### Added
- `TithiSegment` value type (`startUtc`, `endUtc`, `tithi`, `startIsTransition`,
  `endIsTransition`), exported from the barrel.
- Hybrid segment accuracy (Phase 1): transition *instants* come from astronomy
  with the table-known boundary snapped to its corrected instant; segment tithi
  *labels* are anchored to the corrected sunrise tithi and stepped ±1 across each
  boundary, so labels stay Swiss-accurate even where Meeus alone would be off.
  (Multi-transition days carry interim ~1-min precision on extra boundaries until
  a future correction-table regeneration; common single-transition days are
  Swiss-exact.)

### Why
The previous `forDate`/`transitionTime` accepted a wall-clock `DateTime` and
silently fell back to a city's fixed *standard* offset when none was supplied —
wrong by the DST hour near a transition. Centering the contract on UTC instants
removes that whole class of day-attribution bug (e.g. Austin birthdays around
local midnight). Correction-table indexing now flows through a single
`civil-date = instant + offset` path, so evening births that cross UTC midnight
select the correct day's corrections.

### Tests
- Migrated the suite to the new surface; added UTC-instant edge cases
  (evening UTC-midnight-crossing birth, exact-midnight, near-midnight DST),
  multi-transition / paksha-crossing `tithiSegments` days, and Drik cross-checks
  (Austin 2026). 536 tests pass.

## 2.2.1

Bug fix: `transitionTime` now honours `utcOffset`.

- `Panchang.transitionTime(date, utcOffset:)` frames its search by the caller's
  **local calendar day** instead of the fixed Ujjain (IST) day. Previously the
  offset was accepted but ignored, so for western-hemisphere cities a tithi
  boundary landing in the 00:00-08:00 UTC band was attributed to the wrong local
  date (e.g. Austin 2006-05-30 reported the May-29 evening boundary). With an
  offset it now returns the boundary that actually falls on that local date;
  without one it keeps the previous reference-day behaviour. No API change.

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
