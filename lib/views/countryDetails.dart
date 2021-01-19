import 'package:capstone/model/allCases.dart';
import 'package:capstone/model/regionCases.dart';
import 'package:capstone/views/regionsList.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatelessWidget {
  final AllCases countryData;
  final List<RegionCases> regionsData;
  final List<String> regions;

  CountryDetails(
      {@required this.countryData,
      @required this.regionsData,
      @required this.regions});

  Iterable<Map<String, String>> getSuggestedRegions(String pattern) {
    return regions
        .where((element) => element.contains(pattern))
        .map((suggested) => {'name': suggested});
  }

  @override
  Widget build(BuildContext context) {
    List<Padding> generateCell(RegionCases regionCase) {
      return [
        Padding(padding: EdgeInsets.all(4), child: Text(regionCase.name ?? '')),
        Padding(
            padding: EdgeInsets.all(4),
            child: Text(regionCase.confirmed ?? '')),
        Padding(
            padding: EdgeInsets.all(4), child: Text(regionCase.deaths ?? ''))
      ];
    }

    List<TableRow> generateRows() {
      return regionsData
          .map((region) {
            return (region.name != null)
                ? TableRow(children: generateCell(region))
                : null;
          })
          .toList()
          .where((element) => element != null)
          .toList();
    }

    void onPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegionsList(
          countryData: countryData,
          regionsData: regionsData,
        )),
      );
    }

    Map<String, dynamic> CountryDataToList() {
      return Map.from({
        'abbrevation': countryData.abbreviation,
        'capitalCity': countryData.capital_city,
        'confirmed-Cov19': countryData.confirmed,
        'deaths-Cov19': countryData.deaths,
        'elevation': countryData.elevation_in_meters,
        'pupulation': countryData.population
      });
    }

    var data = CountryDataToList();
    return Scaffold(
      appBar: AppBar(
        title: Text(countryData.country),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                child: Column(
              children: [
                Image(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'lib/assets/images/town.png',
                    )),
                (regions.length > 0) ? ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Padding(padding: EdgeInsets.all(5),
                    child: ElevatedButton(onPressed: onPressed, child: Text('Region details')),
                  )
                ) : null
              ].where((element) => element != null).toList(),
            )),
            Container(
              child: Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(data.length, (index) {
                  return Container(
                    color: Colors.green[100 * index],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.keys.elementAt(index),
                        ),
                        Text(
                          data.values.elementAt(index) ?? '-',
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                  );
                }),
              )),
            )
          ],
        ),
      ),
    );
  }
}
