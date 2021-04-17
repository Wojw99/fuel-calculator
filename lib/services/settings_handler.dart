import 'dart:convert';

import 'package:fuel_calculator/services/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsHandler {
  SettingsHandler({this.dataLoaded});

  Settings settings = Settings(
      'zł', 'l', 'km', 1.0, 250.0, 20.0, 1.0, 10.0, 5.0, 1.0, 20.0, 6.0);
  final Function dataLoaded;
  String _jsonName = 'fuel_calculator_settings_json';

  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(settings);
    prefs.setString(_jsonName, json);
    print('SettingHandler data saved.');
  }

  Future readData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_jsonName)) {
      var json = prefs.getString(_jsonName);
      Map settingsMap = jsonDecode(json);
      settings = Settings.fromJson(settingsMap);
      print('SettingHandler data loaded.');
      dataLoaded();
    } else {
      print('SettingHandler save data does not exist yet.');
    }
  }
}
