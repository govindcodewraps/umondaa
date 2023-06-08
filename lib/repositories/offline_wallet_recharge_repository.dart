import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/check_response_model.dart';
import '../data_model/offline_wallet_recharge_response.dart';
import '../helpers/response_check.dart';
import '../helpers/shared_value_helper.dart';

class OfflineWalletRechargeRepository{

 Future<dynamic> getOfflineWalletRechargeResponse({@required String amount,
  @required String name,
  @required String trx_id,
  @required int photo})async{


    var post_body = jsonEncode({
      "amount": "$amount",
      "payment_option": "Offline Payment",
      "trx_id": "$trx_id",
      "photo": "$photo",
    });
    Uri url = Uri.parse("${AppConfig.BASE_URL}/wallet/offline-recharge");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);

    bool checkResult = ResponseCheck.apply(response.body);

    if(!checkResult)
      return responseCheckModelFromJson(response.body);

    return offlineWalletRechargeResponseFromJson(response.body);
  }
}