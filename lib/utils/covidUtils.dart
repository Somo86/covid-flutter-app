import 'package:capstone/model/cases.dart';
import 'dart:math';

class CovidUtils {
  static final CovidUtils _covidapi = CovidUtils._internal();

  factory CovidUtils() {
    return _covidapi;
  }

  CovidUtils._internal();

  Iterable<String> getRegionsList(List<Cases> cases) {
    return cases.map((_case) => _case.regions).expand((_case) => _case);
  }

  Iterable<String> getCountryList(List<Cases> cases) {
    return cases.map((_case) => _case.all.country);
  }

  int sumConfirmed(List<Cases> cases) {
    return cases.fold(
        0, (value, _case) => value + int.parse(_case.all.confirmed));
  }

  int sumDeath(List<Cases> cases) {
    return cases.fold(0, (value, _case) => value + int.parse(_case.all.deaths));
  }

  Cases maxConfirmed(List<Cases> cases) {
    var maxConfirmed =
        cases.where((_case) => _case.all.country != null)
        .map((_case) => int.parse(_case.all.confirmed))
        .reduce(max);
    return cases
        .where((_case) => int.parse(_case.all.confirmed) == maxConfirmed)
        .first;
  }
}
