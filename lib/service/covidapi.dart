import 'dart:convert' as convert;
import 'package:capstone/model/cases.dart';
import 'package:http/http.dart' as http;

const API_BASE = "https://covid-api.mmediagroup.fr/v1";
const CASES_BASE = "/cases";
const HISTORY_BASE = "/history";

class CovidApi {
  static final CovidApi _covidapi = CovidApi._internal();

  factory CovidApi() {
    return _covidapi;
  }

  CovidApi._internal();

  Future<List<Cases>> getAllCases() async {
    var response = await http.get(API_BASE + CASES_BASE);
    if (response.statusCode == 200) {
      var cases = convert.jsonDecode(response.body);
      return cases.values.map<Cases>((value) => Cases(value)).toList();
    } else {
      throw ('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<Cases> getCountryCases(String ab) async {
    var country = (ab != null) ? "?${ab}" : "";
    var response = await http.get(API_BASE + CASES_BASE + country);
    if (response.statusCode == 200) {
      return Cases(convert.jsonDecode(response.body));
    } else {
      throw ('Request failed with status: ${response.statusCode}.');
    }
  }
}
