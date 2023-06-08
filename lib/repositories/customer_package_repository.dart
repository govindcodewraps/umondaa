import 'dart:convert';


import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/check_response_model.dart';
import '../data_model/common_response.dart';
import '../data_model/customer_package_response.dart';
import '../helpers/response_check.dart';
import '../helpers/shared_value_helper.dart';

class CustomerPackageRepository{
Future<CustomerPackageResponse> getList() async{
  Uri url = Uri.parse('${AppConfig.BASE_URL}/customer-packages');

  final response = await http.get(url, headers:
  {
  "Content-Type": "application/json",
  "Authorization": "Bearer ${access_token.$}",
  "App-Language": app_language.$,
  });

  return customerPackageResponseFromJson(response.body);
}

Future<dynamic> freePackagePayment(id) async{
  Uri url = Uri.parse('${AppConfig.BASE_URL}/free/packages-payment');

  var post_body = jsonEncode(
      {"package_id": "${id}"});
  final response = await http.post(url, headers:
  {
  "Content-Type": "application/json",
  "Authorization": "Bearer ${access_token.$}",
  "App-Language": app_language.$,
  },
    body: post_body
  );
  bool checkResult = ResponseCheck.apply(response.body);

  if(!checkResult)
    return responseCheckModelFromJson(response.body);


  return commonResponseFromJson(response.body);
}

Future<dynamic> offlinePackagePayment(
      {packageId, method, trx_id, photo}) async{
  Uri url = Uri.parse('${AppConfig.BASE_URL}/offline/packages-payment');

  var post_body = jsonEncode(
      {
        "package_id": "${packageId}",
        "payment_option": "${method}",
        "trx_id": "${trx_id}",
        "photo": "${photo}",
      });

  print(post_body);
  print(access_token.$);
  print(url.toString());
  final response = await http.post(url, headers:
  {
  "Content-Type": "application/json",
  "Authorization": "Bearer ${access_token.$}",
  "App-Language": app_language.$,
  },
    body: post_body
  );
  bool checkResult = ResponseCheck.apply(response.body);

  if(!checkResult)
    return responseCheckModelFromJson(response.body);


  return commonResponseFromJson(response.body);
}


}