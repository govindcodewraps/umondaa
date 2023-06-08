
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter/foundation.dart';

import '../app_config.dart';
import '../data_model/check_response_model.dart';
import '../data_model/simple_image_upload_response.dart';
import '../helpers/response_check.dart';
import '../helpers/shared_value_helper.dart';

class FileRepository {
  Future<dynamic> getSimpleImageUploadResponse(
      @required String image, @required String filename) async {
    var post_body = jsonEncode({"image": "${image}", "filename": "$filename"});
    //print(post_body.toString());

    Uri url = Uri.parse("${AppConfig.BASE_URL}/file/image-upload");
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

    //print(response.body.toString());
    return simpleImageUploadResponseFromJson(response.body);
  }
}
