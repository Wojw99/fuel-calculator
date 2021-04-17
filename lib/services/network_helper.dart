import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({@required this.url});

  final String url;

  Future<bool> isUrlCorrect() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
