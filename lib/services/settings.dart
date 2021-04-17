class Settings {
  String currencyUnit;
  String fuelUnit;
  String roadUnit;

  double roadMin;
  double roadMax;
  double roadDefault;

  double fuelPriceMin;
  double fuelPriceMax;
  double fuelPriceDefault;

  double combustionMin;
  double combustionMax;
  double combustionDefault;

  Settings(
    this.currencyUnit,
    this.fuelUnit,
    this.roadUnit,
    this.roadMin,
    this.roadMax,
    this.roadDefault,
    this.fuelPriceMin,
    this.fuelPriceMax,
    this.fuelPriceDefault,
    this.combustionMin,
    this.combustionMax,
    this.combustionDefault,
  );

  Settings.fromJson(Map<String, dynamic> json)
      : currencyUnit = json['currencyUnit'],
        fuelUnit = json['fuelUnit'],
        roadUnit = json['roadUnit'],
        roadMin = json['roadMin'],
        roadMax = json['roadMax'],
        roadDefault = json['roadDefault'],
        fuelPriceMin = json['fuelPriceMin'],
        fuelPriceMax = json['fuelPriceMax'],
        fuelPriceDefault = json['fuelPriceDefault'],
        combustionMin = json['combustionMin'],
        combustionMax = json['combustionMax'],
        combustionDefault = json['combustionDefault'];

  Map<String, dynamic> toJson() => {
        'currencyUnit': currencyUnit,
        'fuelUnit': fuelUnit,
        'roadUnit': roadUnit,
        'roadMin': roadMin,
        'roadMax': roadMax,
        'roadDefault': roadDefault,
        'fuelPriceMin': fuelPriceMin,
        'fuelPriceMax': fuelPriceMax,
        'fuelPriceDefault': fuelPriceDefault,
        'combustionMin': combustionMin,
        'combustionMax': combustionMax,
        'combustionDefault': combustionDefault,
      };
}
