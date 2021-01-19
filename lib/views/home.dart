import 'dart:ui';
import 'package:capstone/model/cases.dart';
import 'package:capstone/utils/covidUtils.dart';
import 'package:capstone/views/countryList.dart';
import 'package:capstone/widgets/iconText.dart';
import 'package:capstone/widgets/tapableCard.dart';
import 'package:flutter/material.dart';
import 'package:capstone/service/covidapi.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cases> cases = List();

  @override
  void initState() {
    super.initState();
    fetchAllCases();
  }

  void fetchAllCases() async {
    var response = await CovidApi().getAllCases();
    setState(() {
      cases = response;
    });
  }

  void goToCountryList() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CountryListPage(
                cases: cases,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(60),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'lib/assets/images/stephan-schmitz-illustration.jpg')),
                ),
                child: Center(
                    child: Text(
                  'Covid 19',
                  style: TextStyle(
                    fontSize: 42, 
                    fontFamily: 'Bebas',
                    fontStyle: FontStyle.normal,
                  ),
                ))),
            Container(
              child: Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TapableCard(
                        onTap: goToCountryList,
                        title: Text("Covid worlwide"),
                        subtitle: Text(
                            'Get all information about Covid-19 in all countries'),
                        color: Colors.lightGreen,
                        elevation: 5.0,
                        body: [
                          IconText(
                            text: Text(
                              "Covid information",
                              style: TextStyle(
                                  color: Colors.lightGreen[900], fontSize: 14),
                            ),
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.lightGreen[900],
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                      TapableCard(
                        onTap: () {},
                        title: Text("Worlwide confirmed cases"),
                        alignment: MainAxisAlignment.center,
                        color: Colors.lightGreen[100],
                        body: [
                          Text(
                            CovidUtils().sumConfirmed(cases).toString(),
                            style: TextStyle(
                                fontSize: 24, 
                                color: Colors.lightGreen[600],
                                fontFamily: 'Bebas'),
                          )
                        ],
                      ),
                      TapableCard(
                        onTap: () {},
                        title: Text("Worlwide deaths"),
                        alignment: MainAxisAlignment.center,
                        color: Colors.lightGreen[100],
                        body: [
                          Text(
                            CovidUtils().sumDeath(cases).toString(),
                            style: TextStyle(
                                fontSize: 24, 
                                color: Colors.lightGreen[600],
                                fontFamily: 'Bebas'),
                          )
                        ],
                      ),
                      TapableCard(
                        onTap: () {},
                        title: Text("Country with more confirmed cases"),
                        alignment: MainAxisAlignment.center,
                        color: Colors.lightGreen[100],
                        body: [
                          Text(
                            '${CovidUtils().maxConfirmed(cases).all.country} - ${CovidUtils().maxConfirmed(cases).all.continent}',
                            style: TextStyle(
                                fontSize: 24, 
                                color: Colors.lightGreen[600],
                                fontFamily: 'Bebas'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
