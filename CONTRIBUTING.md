# Contributing to tithi_engine

Thank you for considering contributing! Here's how to get started.

## Development Setup

```bash
git clone https://github.com/misrilibrary/tithi-engine-dart.git
cd tithi-engine-dart
dart pub get
dart test        # run all 415 tests
dart analyze     # zero issues expected
dart format .    # auto-format
```

## Pull Request Process

1. Fork the repo and create a feature branch
2. Make your changes
3. Ensure `dart analyze`, `dart format --set-exit-if-changed .`, and `dart test` pass
4. Submit a PR against `main`

## Adding a City

Add coordinates to `lib/src/cities.dart` in the `supportedCities` map, then generate a correction table using the benchmark tool and add it under `lib/src/regions/<city>/`.

## Adding a Festival

Add a `FestivalDef` to `lib/src/festival_def.dart` with the appropriate muhurta rule.

## Code Style

- Follow `package:lints/recommended.yaml`
- Add `///` doc comments to all public APIs
- No external dependencies allowed (pure Dart)

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.
