
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../app_config.dart';
import '../data_model/check_response_model.dart';
import '../data_model/order_detail_response.dart';
import '../data_model/order_item_response.dart';
import '../data_model/order_mini_response.dart';
import '../data_model/purchased_ditital_product_response.dart';
import '../helpers/response_check.dart';
import '../helpers/shared_value_helper.dart';


class OrderRepository {
  Future<dynamic> getOrderList(
      {page = 1, payment_status = "", delivery_status = ""}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/purchase-history" +
        "?page=${page}&payment_status=${payment_status}&delivery_status=${delivery_status}");
    print("url:" +url.toString());
    print("token:" +access_token.$);
    final response = await http.get(url,headers: {
      "Authorization": "Bearer ${access_token.$}",
      "App-Language": app_language.$,
        });

    bool checkResult = ResponseCheck.apply(response.body);
    print("purchase historyyyyy ::${response.body}");


    if(!checkResult)
      return responseCheckModelFromJson(response.body);
    print("purchase history ::${response.body}");


    return orderMiniResponseFromJson(response.body);
  }

  Future<dynamic> getOrderDetails({@required int id = 0}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/purchase-history-details/"+id.toString());
       // "${AppConfig.BASE_URL}/purchase-history-details/$id");

    final response = await http.get(url,headers: {
      "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$,
        });
    bool checkResult = ResponseCheck.apply(response.body);
    print("order detailssss ::${response.body}");
    print("pur ::${id.toString()}");

    if(!checkResult)
      return responseCheckModelFromJson(response.body);
    print("order detailss ::${response.body}");
    return orderDetailResponseFromJson(response.body);



  }

  Future<dynamic> getOrderItems({@required int id = 0}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/purchase-history-items/" +id.toString());

        //"${AppConfig.BASE_URL}/purchase-history-items/$id");

    final response = await http.get(url,headers: {
      "Authorization": "Bearer ${access_token.$}",
      "App-Language": app_language.$,
        });
    bool checkResult = ResponseCheck.apply(response.body);
    print("purchase itemsssssss ::${response.body}");

    if(!checkResult)
      return responseCheckModelFromJson(response.body);
    print("purchase itemsss ::${response.body}");

    return orderItemlResponseFromJson(response.body);
  }

  Future<dynamic> getPurchasedDigitalProducts(
      {
        page = 1,
      }) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/digital/purchased-list?page=$page");
    print(url.toString());


    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
      "Authorization": "Bearer ${access_token.$}",
    });

    bool checkResult = ResponseCheck.apply(response.body);
    print("purchase purchased ::${response.body}");



    if(!checkResult)
      return responseCheckModelFromJson(response.body);
    return purchasedDigitalProductResponseFromJson(response.body);
  }
}
