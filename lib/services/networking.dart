import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper {

  NetworkHelper({required this.url, required this.currencyChanger});

  final String url;
  final String currencyChanger;

  Future getData() async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if(response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['exchange_rates'][currencyChanger];
      return lastPrice;
    }
    else {
      print(response.statusCode);
    }
  }


}