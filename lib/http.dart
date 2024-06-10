import 'package:http/http.dart';

const String apiKey = '8FD458B7-288B-4B9C-85C9-D4A58A90D9BD';
const String url = 'https://rest.coinapi.io/v1/exchangerate/';

class NetworkHelper {
  final String virtualCurrency;
  final String internationalCurrency;

  NetworkHelper({required this.virtualCurrency, required this.internationalCurrency});

  
}
