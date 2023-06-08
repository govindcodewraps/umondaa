
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

import '../screens/main.dart';
import 'auth_helper.dart';

class ResponseCheck{

  static bool apply(response){

    // print("ResponseCheck ${response}");
    try {
      var responseData  = jsonDecode(response);

      if(responseData is Map && responseData.containsKey("result") && !responseData['result'])
      {
       if(responseData.containsKey("result_key") && responseData['result_key'] == "banned"){
         AuthHelper().clearUserData();
         Navigator.pushAndRemoveUntil(OneContext().context, MaterialPageRoute(builder: (context)=>Main()), (route) => false);
       }
       return false;
      }
    } on Exception catch (e) {
      // TODO
    }
    return true;

  }

}