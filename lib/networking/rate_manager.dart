import 'dart:convert';
import 'package:http/http.dart' as http;

class RateManager {

  final apiKey = '8085B18D-0BF8-492F-848D-93378500293A';

  Future<dynamic> getCryptocurrencyRate(String currency, String coin) async {
    var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=$apiKey');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['rate'];

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

}// End of class