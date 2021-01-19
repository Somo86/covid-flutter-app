import 'dart:ui';

import 'package:capstone/model/cases.dart';
import 'package:capstone/utils/covidUtils.dart';
import 'package:capstone/views/countryDetails.dart';
import 'package:capstone/widgets/tableData.dart';
import 'package:capstone/widgets/typeField.dart';
import 'package:flutter/material.dart';

class CountryListPage extends StatelessWidget {
  final List<Cases> cases;

  CountryListPage({@required this.cases});

  @override
  Widget build(BuildContext context) {
    Iterable<Map<String, String>> getSuggestedCountries(String pattern) {
      return CovidUtils()
          .getCountryList(cases)
          .where((element) => element?.contains(pattern) ?? false)
          .map((suggested) => {'name': suggested});
    }

    List<Padding> generateCell(Cases countryCase) {
      return [
        Padding(
            padding: EdgeInsets.all(4),
            child: Text(countryCase.all.country ?? '')),
        Padding(
            padding: EdgeInsets.all(4),
            child: Text(countryCase.all.confirmed ?? '')),
        Padding(
            padding: EdgeInsets.all(4),
            child: Text(countryCase.all.deaths ?? '')),
        Padding(
            padding: EdgeInsets.all(4),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CountryDetails(
                          countryData: countryCase.all,
                          regionsData: countryCase.regionCases,
                          regions: countryCase.regions,
                        )),
              ),
              child: Icon(Icons.arrow_forward),
            ))
      ];
    }

    List<TableRow> generateRows() {
      return cases
          .map((_case) {
            return (_case.all.country != null)
                ? TableRow(children: generateCell(_case))
                : null;
          })
          .toList()
          .where((element) => element != null)
          .toList();
    }

    void onSuggestionSelected(suggestion) {
      Cases selectedCountry =
          cases.where((_case) => _case.all.country == suggestion['name']).first;
      if (selectedCountry != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CountryDetails(
                      countryData: selectedCountry.all,
                      regionsData: selectedCountry.regionCases,
                      regions: selectedCountry.regions,
                    )));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
      ),
      body: Container(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find by country',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    TypeField(
                        getSuggested: getSuggestedCountries,
                        onSuggestionSelected: onSuggestionSelected),
                  ],
                )),
            Container(
                child: TableData(
              head: [
                Text("Country"),
                Text("Confirmed"),
                Text("Deaths"),
                Text("")
              ],
              rows: generateRows(),
            ))
          ],
        ),
      )),
    );
  }
}
