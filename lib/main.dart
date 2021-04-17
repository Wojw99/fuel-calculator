import 'package:flutter/material.dart';
import 'package:fuel_calculator/constants/colors.dart';
import 'package:fuel_calculator/constants/strings.dart';
import 'package:fuel_calculator/screens/home_page.dart';

void main() {
  runApp(FuelCalculator());
}

class FuelCalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: sTitle,
      theme: ThemeData(
        primaryColor: kMainDark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'FiraSans',
      ),
      home: HomePage(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Tekst1'),
          Text('Tekst3'),
        ],
      ),
    );
  }
}
