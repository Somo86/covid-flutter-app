import 'package:capstone/model/allCases.dart';
import 'package:capstone/model/regionCases.dart';
import 'package:capstone/widgets/tableData.dart';
import 'package:flutter/material.dart';

class RegionsList extends StatelessWidget {
  final List<RegionCases> regionsData;
  final AllCases countryData;

  RegionsList({@required this.regionsData, @required this.countryData});

  @override
  Widget build(BuildContext context) {

    List<Padding> generateCell(RegionCases regionCase) {
      return [
        Padding(padding: EdgeInsets.all(4), child: Text(regionCase.name ?? '')),
        Padding(padding: EdgeInsets.all(4), child: Text(regionCase.confirmed ?? '')),
        Padding(padding: EdgeInsets.all(4), child: Text(regionCase.deaths ?? ''))
      ];
    }

    List<TableRow> generateRows() {
      return regionsData.map((region) {
        return (region.name != null) ? TableRow(children: generateCell(region)) : null;
      }).toList().where((element) => element != null).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(countryData.country),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                  child: TableData(
                    head: [
                      Text("Country"),
                      Text("Confirmed"),
                      Text("Deaths")
                    ],
                    rows: generateRows(),
                  )
                )
          ],
        ),
      ),
    );
  }
}