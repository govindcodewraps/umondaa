import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/payment_model.dart';

class placead extends StatefulWidget {
 // const placead({super.key});

  @override
  State<placead> createState() => _placeadState();

}

class _placeadState extends State<placead> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    payments();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:Text(""),
    ));
  }




// Define your PaymenthistoryModel and other code here (as you provided)

  void payments() async {
    try {
      var headers = {
        'Authorization': 'Bearer 131|V1SPLBTs7BaNNUwZth5gTGjZfC1nc2qQ1EB6fpTs',
        'Cookie':
        'XSRF-TOKEN=dT0lZnI5OsbNxA88TLF4S2x45edCmnKMTwmze0oJ; umonda_online_marketplace_session=k3LCVR020r4kAVJFwu2R66nEtLr7CtFTN7ekl25M'
      };

      var request = http.Request(
          'GET', Uri.parse('https://umonda.com/api/v2/payment-history/138'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();

        // Parse the JSON response using your model
        final paymenthistoryModel = paymenthistoryModelFromJson(responseString);

        // Print the parsed data or access specific fields as needed
        print('Parsed Payment History Data:');
        print(paymenthistoryModel.toJson());
      } else {
        print('Request failed with status: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }


}
