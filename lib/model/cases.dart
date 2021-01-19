import 'package:capstone/model/allCases.dart';
import 'package:capstone/model/regionCases.dart';

class Cases {
  AllCases all;
  List<RegionCases> regionCases = List();
  List<String> regions = List();

  Cases(Map<String, dynamic> cases) {
    cases.forEach((key, value) {
      if (key == 'All') {
        this.all = AllCases(
            confirmed: value['confirmed']?.toString(),
            recovered: value['recovered']?.toString(),
            deaths: value['deaths']?.toString(),
            country: value['country']?.toString(),
            population: value['population']?.toString(),
            sq_km_area: value['sq_km_area']?.toString(),
            life_expectancy: value['life_expectancy']?.toString(),
            elevation_in_meters: value['elevation_in_meters']?.toString(),
            continent: value['continent']?.toString(),
            abbreviation: value['abbreviation']?.toString(),
            location: value['location']?.toString(),
            iso: value['iso']?.toString(),
            capital_city: value['capital_city']?.toString(),
            lat: value['lat']?.toString(),
            long: value['long']?.toString(),
            updated: value['updated']?.toString());
      } else {
        this.regions?.add(key);
        this.regionCases?.add(RegionCases(
              name: key,
              lat: value['lat']?.toString(),
              long: value['long']?.toString(),
              confirmed: value['confirmed']?.toString(),
              recovered: value['recovered']?.toString(),
              deaths: value['deaths']?.toString(),
              updated: value['updated']?.toString(),
            ));
      }
    });
  }
}
