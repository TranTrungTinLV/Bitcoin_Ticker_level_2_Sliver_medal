import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currentList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> crypto = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURl = 'https://rest.coinapi.io/v1/exchangerate';
const APIkey = 'API-YOUR-KEY';

class Coindata {
  Future getCoinData(String? selectcurrently) async {
    String request = '$coinAPIURl/BTC/$selectcurrently?apikey=$APIkey';

    http.Response response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      //8. Get the last price of bitcoin with the key 'last'.
      double lastPrice = decodedData['rate'];
      return lastPrice.toStringAsFixed(0);
    } else {
      print(response.statusCode);
      throw 'Problem with get request';
    }
  }
}
