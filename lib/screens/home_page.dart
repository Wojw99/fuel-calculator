import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/components/alert_dialog.dart';
import 'package:fuel_calculator/components/card_slider.dart';
import 'package:fuel_calculator/components/double_input_dialog.dart';
import 'package:fuel_calculator/components/double_text.dart';
import 'package:fuel_calculator/components/input_dialog.dart';
import 'package:fuel_calculator/constants/colors.dart';
import 'package:fuel_calculator/constants/strings.dart';
import 'package:fuel_calculator/screens/settings_page.dart';
import 'package:fuel_calculator/services/calculator_service.dart';
import 'package:fuel_calculator/services/settings_handler.dart';
import 'package:fuel_calculator/services/url_launcher_service.dart';
import 'package:share/share.dart';

enum Field {
  road,
  fuelPrice,
  combustion,
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// * * * * * * * * * * PROPERTIES * * * * * * * * * *
  SettingsHandler settingsHandler;
  CalculatorService calculatorService;

  /// * * * * * * * * * * SAVE DEFAULT VALUES * * * * * * * * * *
  void saveDefaultValues() {
    settingsHandler.settings.fuelPriceDefault = calculatorService.fuelPrice;
    settingsHandler.settings.combustionDefault = calculatorService.combustion;
    settingsHandler.settings.roadDefault = calculatorService.road;
    settingsHandler.saveData();
  }

  /// * * * * * * * * * * SHOW INPUT DIALOG * * * * * * * * * *
  void showInputDialog({
    @required Field fieldToChange,
    String title = 'Alert',
  }) {
    var dialog = InputDialog(
      context: context,
      title: title,
    );
    dialog.showInputDialog().then((value) {
      setState(() {
        var number = double.tryParse(value);
        if (number != null) {
          if (fieldToChange == Field.road &&
              number < settingsHandler.settings.roadMax &&
              number > settingsHandler.settings.roadMin)
            calculatorService.road = number;
          else if (fieldToChange == Field.combustion &&
              number < settingsHandler.settings.combustionMax &&
              number > settingsHandler.settings.combustionMin)
            calculatorService.combustion = number;
          else if (fieldToChange == Field.fuelPrice &&
              number < settingsHandler.settings.fuelPriceMax &&
              number > settingsHandler.settings.fuelPriceMin)
            calculatorService.fuelPrice = number;
        }
      });
    });
  }

  /// * * * * * * * * * * SHARE RESULT * * * * * * * * * *
  void shareResult() {
    var cUnit = settingsHandler.settings.currencyUnit;
    var fUnit = settingsHandler.settings.fuelUnit;
    var rUnit = settingsHandler.settings.roadUnit;
    var wPrice = calculatorService.countWholePrice().toStringAsPrecision(3);
    var wFuel = calculatorService.countWholeFuel().toStringAsPrecision(3);
    var textRoad = calculatorService.road.toStringAsPrecision(3);
    var textFuelPrice = calculatorService.fuelPrice.toStringAsPrecision(3);
    var textCombustion = calculatorService.combustion.toStringAsPrecision(3);
    var text = '#$sTitle#' +
        '\n$sWholePrice: $wPrice$cUnit.' +
        '\n$sWholeFuel: $wFuel$fUnit.' +
        '\n$sCounted: ' +
        '$textRoad$rUnit, ' +
        '$textFuelPrice$cUnit/$fUnit, ' +
        '$textCombustion$fUnit/100$rUnit.';
    Share.share(text);
  }

  /// * * * * * * * * * * CHECK FUEL PRICE * * * * * * * * * *
  void checkFuelPrice() {
    var urlService = UrlLauncherService();
    urlService.launchFuelPriceUrl();
  }

  /// * * * * * * * * * * CHECK COMBUSTION * * * * * * * * * *
  // TODO: add third part with a generation
  // (generation and model will be not required to write by the user)
  Future<void> checkCombustion() async {
    var urlLauncher = UrlLauncherService();
    var fullName = '';

    var dialog = DoubleInputDialog(
      context: context,
      title: sInputDialogTitle,
    );
    await dialog.showInputDialog().then((value) {
      var parts = value.split(',');
      var markPart = parts[0].toLowerCase().trim().replaceAll(' ', '-');
      var modelPart = parts[1].toLowerCase().trim().replaceAll(' ', '-');

      urlLauncher.addToCombustionUrl(markPart);
      urlLauncher.addToCombustionUrl(modelPart);
      fullName = '$markPart $modelPart';
    });

    // TextField with mark is empty
    if (fullName == ' ') return;

    try {
      await urlLauncher.launchCombustionUrl();
    } catch (ex) {
      // given URL is not valid
      var myAlertDialog = MyAlertDialog(
        context: context,
        title: '\"$fullName\" - $sAlertFailTitle',
        text: sAlertFailText,
      );
      myAlertDialog.showThisDialog();
    }
  }

  /// * * * * * * * * * * NAVIGATE TO SETTINGS * * * * * * * * * *
  void navigateToSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );

    settingsHandler.readData();
  }

  /// * * * * * * * * * * INIT STATE * * * * * * * * * *
  @override
  void initState() {
    settingsHandler = SettingsHandler(dataLoaded: () {
      setState(() {
        print('home init state');
        calculatorService = CalculatorService(this.settingsHandler);
      });
    });
    settingsHandler.readData();
    calculatorService = CalculatorService(this.settingsHandler);
    super.initState();
  }

  /// * * * * * * * * * * BUILD * * * * * * * * * *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(sTitle),
        backgroundColor: kBlack,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: shareResult,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: navigateToSettings,
          ),
        ],
      ),
      backgroundColor: kBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /// * * * * * * * * * * Row 1 - RESULT * * * * * * * * * *
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0), // 23
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0), // 15
                  gradient: LinearGradient(
                    colors: <Color>[kMainLight, kMainDark],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DoubleText(
                      value: calculatorService.countWholePrice(),
                      valueUnit: settingsHandler.settings.currencyUnit,
                      paragraph: sWholePrice,
                      titleFontSize: 42.0,
                      paragraphFontSize: 18.0,
                    ),
                    DoubleText(
                      value: calculatorService.countWholeFuel(),
                      valueUnit: settingsHandler.settings.fuelUnit,
                      paragraph: sWholeFuel,
                      titleFontSize: 26.0,
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// * * * * * * * * * * Row 2 - COLUMN * * * * * * * * * *
          Expanded(
            flex: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// * * * * * * * * * * Row 1 - ROAD * * * * * * * * * *
                CardSlider(
                  label: sRoad,
                  value: calculatorService.road,
                  valueUnit: settingsHandler.settings.roadUnit,
                  minValue: settingsHandler.settings.roadMin,
                  maxValue: settingsHandler.settings.roadMax,
                  onSliderChanged: (double newValue) {
                    setState(() {
                      calculatorService.road = newValue;
                    });
                  },
                  onEditIconPressed: () {
                    showInputDialog(fieldToChange: Field.road, title: sRoad);
                    saveDefaultValues();
                  },
                  onSliderChangeEnd: (double newValue) {
                    saveDefaultValues();
                  },
                ),

                /// * * * * * * * * * * Row 2 - FUEL PRICE * * * * * * * * * *
                CardSlider(
                  label: sFuelPrice,
                  value: calculatorService.fuelPrice,
                  valueUnit:
                      '${settingsHandler.settings.currencyUnit}/${settingsHandler.settings.fuelUnit}',
                  minValue: settingsHandler.settings.fuelPriceMin,
                  maxValue: settingsHandler.settings.fuelPriceMax,
                  onSliderChanged: (double newValue) {
                    setState(() {
                      calculatorService.fuelPrice = newValue;
                    });
                  },
                  onEditIconPressed: () {
                    showInputDialog(
                        fieldToChange: Field.fuelPrice, title: sFuelPrice);
                    saveDefaultValues();
                  },
                  onSearchIconPressed: checkFuelPrice,
                  onSliderChangeEnd: (double newValue) {
                    saveDefaultValues();
                  },
                ),

                /// * * * * * * * * * * Row 3 - COMBUSTION * * * * * * * * * *
                CardSlider(
                  label: sCombustion,
                  value: calculatorService.combustion,
                  valueUnit:
                      '${settingsHandler.settings.fuelUnit}/100${settingsHandler.settings.roadUnit}',
                  minValue: settingsHandler.settings.combustionMin,
                  maxValue: settingsHandler.settings.combustionMax,
                  onSliderChanged: (double newValue) {
                    setState(() {
                      calculatorService.combustion = newValue;
                    });
                  },
                  onEditIconPressed: () {
                    showInputDialog(
                        fieldToChange: Field.combustion, title: sCombustion);
                    saveDefaultValues();
                  },
                  onSearchIconPressed: checkCombustion,
                  onSliderChangeEnd: (double newValue) {
                    saveDefaultValues();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
