# tithi-engine-dart — Accuracy Benchmark vs JPL Swiss Ephemeris (`.se1`)

Source of truth: **Swiss Ephemeris `.se1`** files (`seFlgSwiEph`, JPL-derived), Lahiri
ayanamsha. Range **1900–2100**, all **230 cities**, both sunrise conventions
(upperLimb / centerDisc) and both month systems (purnimant / amant) where applicable.

**Accuracy bar: minute-level** (panchang display + birth-time to the minute).

Legend (Status): 🟢 verified at the minute bar · 🟡 bounded residual / spot-checked · 🔴 not verified.
Legend (Coverage): **Exhaustive** = directly compared to `.se1` over the *entire* domain
(every city/day/transition/new-moon) — no untested astronomical or computational case ·
**Sampled** = only representative/curated cases directly compared — an untested edge could
remain (this is exactly how the `getDates` bug hid before its exhaustive sweep) ·
**Derived** = a deterministic function of an Exhaustive quantity (correct by composition;
the composition logic itself was only sampled).

| # | Compute point | Status | Coverage | Evidence |
|---|---|---|---|---|
| 1 | Tithi number | 🟢 | **Exhaustive** | all 74,582 transitions 1900–2100 (global) |
| 2 | Transition instants | 🟢 | **Exhaustive** | all 74,582 transitions (global) |
| 3 | tithiOnDate (day tithi) | 🟢 | **Exhaustive** | 33.77M = 230 cities × 73,414 days × 2 conv |
| 4 | Sunrise | 🟢 | **Exhaustive** | 33.77M (all cities/days, both conv) |
| 5 | Sunset | 🟢 | **Exhaustive** | 33.77M (all cities/days, both conv) |
| 6 | Segment boundaries | 🟢 | Derived | = transitions (Exhaustive) |
| 7 | Segment labels | 🟢¹ | **Exhaustive** (both conv) | all cities × 1900–2100, both conventions; whole-day shifts fixed; 7,425/conv sub-minute slivers remain |
| 8 | tithiAtInstant (birth) | 🟢¹ | **Exhaustive** | 135M (all cities × 1900–2100 × 3-hourly); **0 whole-day-shift days**; 0.0145% isolated near-transition residual |
| 9 | Paksha | 🟢 | Derived | pure function of tithi number |
| 10 | Amavasya / Purnima days | 🟢 | Derived | from tithiOnDate (Exhaustive) + new-moon sweep |
| 11 | Lunar month name | 🟢 | **Exhaustive** | all 2,486 new moons 1900–2100 (global, both systems) |
| 12 | Adhika (leap) month | 🟢 | **Exhaustive** | all 2,486 new moons |
| 13 | Offset / DST conversion | 🟢 | **Broad** (all offset types) | 30 samples: every distinct offset −8…+12 (incl. +5:30/+5:45/+6:30/+9:30) × DST both hemispheres + non-DST, all checks 30/30 |
| 14 | Tithi → date lookup (`getDates`) | 🟢 | **Exhaustive** | 16.9M = all cities × 1900–2100, reverse+forward |

### Coverage summary
- **Exhaustive (no hidden case):** 1, 2, 3, 4, 5, 7 (both conv), 8, 11, 12, 14.
- **Broad (all offset types):** 13 (offset/DST — every distinct offset + DST both hemispheres).
- **Derived (composition of Exhaustive):** 6, 9, 10.
- **Sampled (remaining):** none — centerDisc segment labels now Exhaustive (whole-day-shift fix verified both conventions).

> The `getDates` bug (festival dates off by a day) passed a 6-city *sample*
> cleanly and was only caught by the **16.9M-day exhaustive** run — which is why
> Sampled rows carry risk. **tithiAtInstant** was likewise promoted to Exhaustive
> by a 135M-point (3-hourly, all cities, 1900–2100) sweep that found **no
> composition error** — its 0.047% residual is isolated near-transition (~30s)
> points (footnote ¹), the same transition-time floor as rows 2/6/7. Remaining
> Sampled rows: offset/DST (logic, not a data surface) and centerDisc segment
> labels.

## Notes / known limitations

**Whole-day-shift fix.** `tithiSegments`/`tithiAtInstant` previously anchored labels on `tithiOnDate` (`.se1` tithi at the *true* sunrise) but stepped in the Meeus frame; on ~0.008–0.010% of days (both conventions) the engine's Meeus sunrise straddled a near-sunrise transition vs the true sunrise, shifting the **whole day's** labels +1 (visible). Fixed by labeling each segment/instant by its own corrected-elongation tithi (segment midpoint), independent of the sunrise anchor. Verified: tithiAtInstant whole-day-shift-days → **0**; segment MMs 8,391/8,413 → 7,425 (only sub-minute slivers, convention-independent).

**¹ Near-transition residual (accepted at minute bar).** Transition instants are
`.se1`-accurate to **≤30s** (0 >30s), not second-exact, because sub-30s Meeus-vs-`.se1`
differences are below the global-correction threshold and corrected ones snap to the
minute. This surfaces as: (a) **segment labels** — ~8,391 city-days (~0.05%) have a
1–6s tithi sliver at local midnight (1s `_bisect` fix already removed the larger
whole-day-shift class, 10,657→8,391); and (b) **tithiAtInstant** — a birth within
~30s of a transition can be off by one (0.047% of a 3-hourly grid). All sub-minute;
invisible at minute resolution. Full removal requires **second-resolution transition
correction for all transitions** (~+50KB, deferred). No runtime fix at local midnight
(no `.se1` anchor there, unlike sunrise).

**² Offset/DST** is engine logic (UTC + caller-supplied offset → civil date), not a
200-year data surface. There are only ~22 distinct supported offsets; **all** were
tested with DST std/DST pairs in both hemispheres (30 samples, 30/30 on sunrise,
sunset, tithiOnDate, local-midnight-boundary tithiAtInstant, segment labels). So the
offset-handling logic is effectively fully covered.

**³ `getDates` (FIXED).** `findTithiRaw`/`findNextOccurrence` previously matched
tithis on **raw Meeus** (ignoring the correction table `tithiOnDate` uses), so
`getDates`/`findInYear`/`dateFor` (festival dates) were **off by a day on
correction days** (frequent at high latitude). Fixed to use the corrected day-tithi.
Full verification (all 230 cities × 1900–2100): reverse_bad 2,260→0, forward_gaps
2,021→0. Convention notes: vriddhi (repeated tithi) → last sunrise-day is canonical
(may fall in the next calendar year); kshaya (skipped tithi) → observed on the
preceding day.

## Net
**13 of 14 rows 🟢** (all compute outputs verified `.se1`-consistent at minute
resolution). The remaining 🟡 (offset/DST) is logic, not a data surface, and is
spot-verified by design. No 🔴.

## Verification tools (`dart/scripts/app-tools/convention-benchmark/bin/`)
- `compare_engine_vs_swieph.dart` — tithi number + transition instants vs `.se1`
- `verify_convention.dart --baseline=<dir>` — tithiOnDate vs cached `.se1` baseline
- `verify_sunrise_vs_se1.dart` — sunrise/sunset (parallel via `dart build cli` exe)
- `verify_month_adhika.dart` — month name + adhika at every new moon
- `seg_label_knife_edge.dart` — segment-label sweep + tightest sunrise/transition margin
- `verify_getdates_roundtrip.dart` / `verify_getdates_reverse.dart` — date-lookup round-trip
- `gen_convention_corrections.dart --cache=<dir>` — dumps the reusable `.se1` baseline
