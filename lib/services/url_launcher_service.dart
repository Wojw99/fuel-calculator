import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class UrlLauncherService {
  String _fuelPriceUrl = 'https://www.autocentrum.pl/paliwa/ceny-paliw/';
  String _combustionUrl = 'https://www.autocentrum.pl/spalanie/';

  static const errorMessage = 'Could not launch given URL!';

  Future<void> launchFuelPriceUrl() async {
    if (await canLaunch(_fuelPriceUrl)) {
      await launch(_fuelPriceUrl);
    } else {
      // browser cannot launch given URL
      print(errorMessage);
    }
  }

  Future<void> launchCombustionUrl() async {
    http.Response response = await http.get(_combustionUrl);
    print(_combustionUrl);

    // because user can edit _combustionUrl with addToCombustionUrl(), we need
    // to check if url is correct
    if (response.statusCode == 404) {
      throw new Exception(errorMessage);
    }

    if (await canLaunch(_combustionUrl)) {
      await launch(_combustionUrl);
    } else {
      // browser cannot launch given URL
      print(errorMessage);
    }
  }

  void addToCombustionUrl(String part) {
    _combustionUrl += '$part/';
  }
}
