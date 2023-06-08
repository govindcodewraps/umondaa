
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/currency_response.dart';

class CurrencyRepository{
Future<CurrencyResponse> getListResponse() async{
  Uri url = Uri.parse('${AppConfig.BASE_URL}/currencies');

  final response = await http.get(url);
  //print("adons ${response.body}");
  return currencyResponseFromJson(response.body);
}
}