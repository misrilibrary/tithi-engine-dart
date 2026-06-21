// Phase A truth-dump tool (tithi-engine Java parity).
//
// Emits, per supported city, the authoritative daily SUNRISE TITHI for every day
// 1900-01-01 .. 2100-12-31 (73414 days) as produced by the validated Dart engine
// (Meeus + Swiss-anchored corrections == Swiss truth). The Java side regenerates
// its own correction tables against THIS truth, so Java's tables encode exactly
// the days where Java's Meeus disagrees with Swiss — never a blind copy of Dart.
//
// Also dumps Dart's existing correction maps (tithi/transitions/purnima/amavasya)
// for cross-diff and transition-minute reuse.
//
// Usage:  dart run tool/dump_truth.dart <outDir>
//
// Keyed by the normalized display name (lowercase, spaces removed) so it lines up
// 1:1 with the Java library's CityCorrections resource key.

import 'dart:io';
import 'dart:typed_data';

import 'package:tithi_engine/src/astronomy.dart'
    show computeSunrise, sunLongitude, moonLongitude, getLocationForCity, supportedCities;
import 'package:tithi_engine/src/ayanamsha.dart' show toSidereal;
import 'package:tithi_engine/src/tithi.dart' as tithi_core;
import 'package:tithi_engine/src/regions/registry.dart'
    show getTithiCorrections, getTransitionMinutes, getAmavasyaCorrections, getPurnimaCorrections;
import 'package:tithi_engine/data/all.dart' show registerAllCities;

final _epoch = DateTime.utc(1900, 1, 1);
const _totalDays = 73414;

int _meeusTithiAt(DateTime utc) {
  final sun = toSidereal(sunLongitude(utc), utc);
  final moon = toSidereal(moonLongitude(utc), utc);
  return tithi_core.calculateTithi(moon, sun);
}

String _key(String name) => name.toLowerCase().replaceAll(RegExp(r'\s+'), '');

String _jsonStr(String s) => '"${s.replaceAll('\\', '\\\\').replaceAll('"', '\\"')}"';

String _mapJson(Map<int, int> m) {
  final keys = m.keys.toList()..sort();
  final sb = StringBuffer('{');
  var first = true;
  for (final k in keys) {
    if (!first) sb.write(',');
    sb.write('"$k":${m[k]}');
    first = false;
  }
  sb.write('}');
  return sb.toString();
}

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('Usage: dart run tool/dump_truth.dart <outDir>');
    exit(1);
  }
  registerAllCities();
  final outDir = args[0];
  Directory('$outDir/truth').createSync(recursive: true);
  Directory('$outDir/darttables').createSync(recursive: true);

  final names = supportedCities.keys.toList()..sort();
  stdout.writeln('Dumping truth for ${names.length} cities x $_totalDays days...');

  // City coordinates + region (feeds Java coord/region parity too).
  final citiesSb = StringBuffer('[');
  var cfirst = true;
  for (final name in names) {
    final loc = getLocationForCity(name);
    if (!cfirst) citiesSb.write(',');
    final reg = loc.region == null ? 'null' : '"${loc.region}"';
    citiesSb.write('{"key":"${_key(name)}","name":${_jsonStr(name)},'
        '"lat":${loc.latitude},"lon":${loc.longitude},'
        '"utcOffset":${loc.utcOffset},"region":$reg}');
    cfirst = false;
  }
  citiesSb.write(']');
  File('$outDir/cities.json').writeAsStringSync(citiesSb.toString());

  var n = 0;
  for (final name in names) {
    final key = _key(name);
    final loc = getLocationForCity(name);
    final corr = getTithiCorrections(name);

    final bytes = Uint8List(_totalDays);
    for (var d = 0; d < _totalDays; d++) {
      final date = _epoch.add(Duration(days: d));
      final t = corr[d] ?? _meeusTithiAt(computeSunrise(date, loc));
      bytes[d] = t; // 1..30 fits a byte
    }
    File('$outDir/truth/$key.bin').writeAsBytesSync(bytes);

    final sb = StringBuffer('{');
    sb.write('"tithi":${_mapJson(getTithiCorrections(name))},');
    sb.write('"transitions":${_mapJson(getTransitionMinutes(name))},');
    sb.write('"purnima":${_mapJson(getPurnimaCorrections(name))},');
    sb.write('"amavasya":${_mapJson(getAmavasyaCorrections(name))}');
    sb.write('}');
    File('$outDir/darttables/$key.json').writeAsStringSync(sb.toString());

    n++;
    if (n % 25 == 0) stdout.writeln('  $n/${names.length}');
  }
  stdout.writeln('Done: $n cities -> $outDir/{truth,darttables}/');
}
