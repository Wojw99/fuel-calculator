import 'settings_handler.dart';

class CalculatorService {
  final SettingsHandler settingsHandler;
  double road;
  double combustion;
  double fuelPrice;

  CalculatorService(this.settingsHandler) {
    road = settingsHandler.settings.roadDefault;
    combustion = settingsHandler.settings.combustionDefault;
    fuelPrice = settingsHandler.settings.fuelPriceDefault;
  }

  double countWholeFuel() => (road * combustion) / 100.0;
  double countWholePrice() => fuelPrice * countWholeFuel();
}
