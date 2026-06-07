# Changelog

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
