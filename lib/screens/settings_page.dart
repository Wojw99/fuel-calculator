import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/components/card_button.dart';
import 'package:fuel_calculator/components/input_dialog.dart';
import 'package:fuel_calculator/constants/colors.dart';
import 'package:fuel_calculator/constants/strings.dart';
import 'package:fuel_calculator/constants/styles.dart';
import 'package:fuel_calculator/services/settings_handler.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsHandler settingsHandler;

  /// * * * * * * * * * * INIT STATE * * * * * * * * * *
  @override
  void initState() {
    settingsHandler = SettingsHandler(dataLoaded: () {
      setState(() {
        print('UI rebuilt');
      });
    });
    settingsHandler.readData();
    super.initState();
  }

  /// * * * * * * * * * * DEACTIVATE * * * * * * * * * *
  @override
  void deactivate() {
    super.deactivate();
  }

  /// * * * * * * * * * * NAVIGATE BACK AND SAVE * * * * * * * * * *
  void navigateBackAndSave() {
    settingsHandler.saveData();
    Navigator.pop(context, 'saved');
  }

  /// * * * * * * * * * * BUILD * * * * * * * * * *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(sSettings),
        backgroundColor: kBlack,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Container(
                color: kBlack,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// * * * * * * * * * * ROAD * * * * * * * * * *
                      TextSection(
                        text: sRoad,
                      ),
                      SettingRow(
                        label: '$sValueMin: ',
                        value: settingsHandler.settings.roadMin.toString(),
                        onPressed: () {
                          var dialog = InputDialog(
                            context: context,
                            title: sValueMin,
                          );
                          dialog.showInputDialog().then((value) {
                            setState(() {
                              var number = double.tryParse(value);
                              if (number != null) {
                                settingsHandler.settings.roadMin = number;
                                var max = settingsHandler.settings.roadMax;
                                var min = settingsHandler.settings.roadMin;
                                settingsHandler.settings.roadDefault =
                                    (max + min) / 2;
                              }
                            });
                          });
                        },
                      ),
                      SettingRow(
                        label: '$sValueMax: ',
                        value: settingsHandler.settings.roadMax.toString(),
                        onPressed: () {
                          var dialog = InputDialog(
                            context: context,
                            title: sValueMax,
                          );
                          dialog.showInputDialog().then((value) {
                            setState(() {
                              var number = double.tryParse(value);
                              if (number != null) {
                                settingsHandler.settings.roadMax = number;
                                var max = settingsHandler.settings.roadMax;
                                var min = settingsHandler.settings.roadMin;
                                settingsHandler.settings.roadDefault =
                                    (max + min) / 2;
                              }
                            });
                          });
                        },
                      ),
                      // SettingRow(
                      //   label: '$sValueDefault: ',
                      //   value: settingsHandler.settings.roadDefault.toString(),
                      //   onPressed: () {
                      //     var dialog = InputDialog(
                      //       context: context,
                      //       title: sValueDefault,
                      //     );
                      //     dialog.showInputDialog().then((value) {
                      //       setState(() {
                      //         var number = double.tryParse(value);
                      //         if (number != null &&
                      //             number > settingsHandler.settings.roadMin &&
                      //             number < settingsHandler.settings.roadMax)
                      //           settingsHandler.settings.roadDefault = number;
                      //       });
                      //     });
                      //   },
                      // ),
                      SectionDivider(),

                      /// * * * * * * * * * * FUEL PRICE * * * * * * * * * *
                      TextSection(
                        text: sFuelPrice,
                      ),
                      SettingRow(
                        label: '$sValueMin: ',
                        value: settingsHandler.settings.fuelPriceMin.toString(),
                        onPressed: () {
                          var dialog = InputDialog(
                            context: context,
                            title: sValueMin,
                          );
                          dialog.showInputDialog().then((value) {
                            setState(() {
                              var number = double.tryParse(value);
                              if (number != null) {
                                settingsHandler.settings.fuelPriceMin = number;
                                var max = settingsHandler.settings.fuelPriceMax;
                                var min = settingsHandler.settings.fuelPriceMin;
                                settingsHandler.settings.fuelPriceDefault =
                                    (max + min) / 2;
                              }
                            });
                          });
                        },
                      ),
                      SettingRow(
                        label: '$sValueMax: ',
                        value: settingsHandler.settings.fuelPriceMax.toString(),
                        onPressed: () {
                          var dialog = InputDialog(
                            context: context,
                            title: sValueMax,
                          );
                          dialog.showInputDialog().then((value) {
                            setState(() {
                              var number = double.tryParse(value);
                              if (number != null) {
                                settingsHandler.settings.fuelPriceMax = number;
                                var max = settingsHandler.settings.fuelPriceMax;
                                var min = settingsHandler.settings.fuelPriceMin;
                                settingsHandler.settings.fuelPriceDefault =
                                    (max + min) / 2;
                              }
                            });
                          });
                        },
                      ),
                      // SettingRow(
                      //   label: '$sValueDefault: ',
                      //   value: settingsHandler.settings.fuelPriceDefault
                      //       .toString(),
                      //   onPressed: () {
                      //     var dialog = InputDialog(
                      //       context: context,
                      //       title: sValueDefault,
                      //     );
                      //     dialog.showInputDialog().then((value) {
                      //       setState(() {
                      //         var number = double.tryParse(value);
                      //         if (number != null &&
                      //             number >
                      //                 settingsHandler.settings.fuelPriceMin &&
                      //             number <
                      //                 settingsHandler.settings.fuelPriceMax)
                      //           settingsHandler.settings.fuelPriceDefault =
                      //               number;
                      //       });
                      //     });
                      //   },
                      // ),
                      SectionDivider(),

                      /// * * * * * * * * * * COMBUSTION * * * * * * * * * *
                      TextSection(
                        text: sCombustion,
                      ),
                      SettingRow(
                        label: '$sValueMin: ',
                        value:
                            settingsHandler.settings.combustionMin.toString(),
                        onPressed: () {
                          var dialog = InputDialog(
                            context: context,
                            title: sValueMin,
                          );
                          dialog.showInputDialog().then((value) {
                            setState(() {
                              var number = double.tryParse(value);
                              if (number != null &&
                                  number <
                                      settingsHandler
                                          .settings.combustionDefault)
                                settingsHandler.settings.combustionMin = number;
                            });
                          });
                        },
                      ),
                      SettingRow(
                        label: '$sValueMax: ',
                        value:
                            settingsHandler.settings.combustionMax.toString(),
                        onPressed: () {
                          var dialog = InputDialog(
                            context: context,
                            title: sValueMax,
                          );
                          dialog.showInputDialog().then((value) {
                            setState(() {
                              var number = double.tryParse(value);
                              if (number != null &&
                                  number >
                                      settingsHandler
                                          .settings.combustionDefault)
                                settingsHandler.settings.combustionMax = number;
                            });
                          });
                        },
                      ),
                      // SettingRow(
                      //   label: '$sValueDefault: ',
                      //   value: settingsHandler.settings.combustionDefault
                      //       .toString(),
                      //   onPressed: () {
                      //     var dialog = InputDialog(
                      //       context: context,
                      //       title: sValueDefault,
                      //     );
                      //     dialog.showInputDialog().then((value) {
                      //       setState(() {
                      //         var number = double.tryParse(value);
                      //         if (number != null &&
                      //             number >
                      //                 settingsHandler.settings.combustionMin &&
                      //             number <
                      //                 settingsHandler.settings.combustionMax)
                      //           settingsHandler.settings.combustionDefault =
                      //               number;
                      //       });
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: CardButton(
              text: sButtonSave,
              onPressed: navigateBackAndSave,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: SizedBox(
        height: 20.0,
        child: Divider(
          color: Colors.white,
        ),
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  TextSection({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

class SettingRow extends StatelessWidget {
  SettingRow({
    this.label = 'label',
    this.value = 'value',
    @required this.onPressed,
  });

  final String label;
  final String value;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 23.0, right: 23.0, top: 25.0),
        child: Container(
          color: kBlack,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: kMainLight,
                  fontSize: 23.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
