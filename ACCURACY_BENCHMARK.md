# tithi_engine — Accuracy Benchmark vs JPL Swiss Ephemeris

Source of truth: **JPL Swiss Ephemeris `.se1` files** (`seFlgSwiEph`), Lahiri ayanamsha.
Range **1900–2100**, all **245 cities**, both sunrise conventions (upperLimb / centerDisc)
and both month systems (Purnimant / Amant).

**Accuracy bar: minute-level** (panchang display + birth-time to the minute).

## Verification matrix

| # | Compute point | Status | Coverage | Evidence |
|---|---|---|---|---|
| 1 | Tithi number | 🟢 | **Exhaustive** | all 74,582 transitions 1900–2100 (global) |
| 2 | Transition instants | 🟢 | **Exhaustive** | all 74,582 transitions; 0 exceed 30 s vs `.se1` |
| 3 | tithiOnDate (day tithi) | 🟢 | **Exhaustive** | 35.97M city-days (245 cities × 73,414 days × 2 conv) |
| 4 | Sunrise | 🟢 | **Exhaustive** | 35.97M; 0 exceed 60 s, max 15.7 s |
| 5 | Sunset | 🟢 | **Exhaustive** | 35.97M; 0 exceed 60 s, max 12.6 s |
| 6 | Segment boundaries | 🟢 | Derived | deterministic from transitions (row 2) |
| 7 | Segment labels | 🟢 | **Exhaustive** | all cities × 1900–2100, both conventions; 0 whole-day shifts¹ |
| 8 | tithiAtInstant (birth-time) | 🟢 | **Exhaustive** | 135M instants (3-hourly grid); 0 whole-day-shift days¹ |
| 9 | Paksha | 🟢 | Derived | pure function of tithi number |
| 10 | Amavasya / Purnima days | 🟢 | Derived | from tithiOnDate + new-moon sweep |
| 11 | Lunar month name | 🟢 | **Exhaustive** | all 2,486 new moons 1900–2100, both systems |
| 12 | Adhika (leap) month | 🟢 | **Exhaustive** | all 2,486 new moons |
| 13 | Offset / DST conversion | 🟢 | **Broad** | every distinct UTC offset (−8…+12, incl. half/quarter-hour) × DST both hemispheres; 30/30 |
| 14 | getDates / findDates (tithi → date) | 🟢 | **Exhaustive** | 16.9M (all cities × 1900–2100, reverse + forward, kshaya/vriddhi-aware) |
| 15 | Coordinate input (`Location.at`, meeusRaw) | 🟢 | **Broad (sampled)** | random off-grid coords × dates vs `.se1`: 99.98% day-tithi (off-by-one near-transition only; uncorrected Meeus path) |

**14 of 14 core markers 🟢.** All compute outputs verified `.se1`-consistent at minute resolution. Marker 15 (off-grid coordinate path) is the uncorrected Meeus path — ~99.98% day-accuracy by design (no per-city correction table).

## Coverage backlog (verification gaps to close over time)

The 14 markers verify the engine's astronomy for the **245 named cities, 1900–2100**. Known gaps:

- **findNext / recurringDates** — share finder logic with `getDates` (marker 14) but aren't independently swept; a recurring-festival bug once hid here. *Add a dedicated round-trip sweep.*
- **Polar / extreme-latitude no-rise/no-set days** — handling is a clamped approximation; not verified vs `.se1` at high latitudes around solstices.
- **Muhurta window times** (nishita/madhyahna/pradosh) — festival *dates* are 22/22 vs Drik (sampled); the window *times* are only spot-checked.
- **Historical civil offsets (pre-~1945)** — the engine frames civil days with a fixed modern offset; regions used different offsets historically (LMT, WWII). Narrow but affects real old DOBs near midnight.
- **Out-of-range dates** — behavior outside 1900–2100 is undefined (e.g. ancient/sentinel dates render IANA Local Mean Time). Document the supported range.
- **App IANA timezone/wall-clock layer** — out of scope for the engine benchmark (app-side; covered by app unit tests).

### Coverage legend
- **Exhaustive** — compared to `.se1` over the entire domain (every city, day, transition, new moon). No untested case.
- **Broad** — all input *types* tested (every distinct offset, both DST hemispheres), not every city×day.
- **Derived** — deterministic function of an Exhaustive quantity.

## Known residual (sub-minute, accepted)

¹ **Near-transition residual.** Transition instants are `.se1`-accurate to ≤30 s
(0 exceed 30 s). Within that window: segment labels show a sub-minute tithi sliver
at local midnight on ~0.05% of city-days, and a `tithiAtInstant` query within ~30 s
of a transition can be one tithi off (0.0145% of the 135M grid). All sub-minute —
invisible at minute-resolution display. Full removal would need second-resolution
transition correction for all 74,582 transitions (~+50 KB). Deferred.

## Notes on fixed issues

- **Whole-day-shift (4.3.0).** Segment/instant labeling now uses each segment's own
  corrected-elongation tithi at its midpoint, independent of the sunrise anchor.
  Verified: whole-day-shift days → 0.
- **getDates (4.3.0).** `findTithiRaw`/`findNextOccurrence` now match on the corrected
  day-tithi (not raw Meeus); festival dates exhaustively verified (16.9M), 0 mismatches.
- **Offset/DST (4.3.0).** Verified across every supported offset type with DST pairs in
  both hemispheres (30/30 on sunrise, sunset, tithiOnDate, midnight-boundary
  tithiAtInstant, and segment labels).
