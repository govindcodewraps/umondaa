
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Models/Commission_History_Model.dart';
import '../../Models/payment_model.dart';

class CommissionHistoryScreen extends StatefulWidget {

  @override
  State<CommissionHistoryScreen> createState() => _CommissionHistoryScreenState();
}

class _CommissionHistoryScreenState extends State<CommissionHistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:listview(),
    ));
  }




  Widget listview() {
    return
      FutureBuilder(
          future: paymentdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                Container(
                  //padding: EdgeInsets.only(top: 23),
                  child: ListView.builder(

                    shrinkWrap: true,
                    //physics:  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Id :                          ", textAlign: TextAlign.start,),
                              SizedBox(width: 30,),
                              Text(snapshot.data.data[index].id.toString(),),
                            ],),
                          Row(
                            children: [
                              Text("Order ID :              "),
                              SizedBox(width: 30,),
                              Text(snapshot.data.data[index].orderId.toString(),),

                            ],),
                          Row(
                            children: [
                              Text("User_ID :               "),
                              SizedBox(width: 30,),
                              Text(snapshot.data.data[index].userId.toString(),),

                            ],),
                          Row(
                            children: [
                              Text("Seller Earning :   "),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].sellerEarning.toString(),),

                            ],),
                          Row(
                            children: [
                              Text("Created At :          "),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].createdAt.toString(),),

                            ],),
                          Row(
                            children: [
                              Text("updated At :         "),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].updatedAt.toString(),),

                            ],),

                          SizedBox(height: 25,),

                        ],);
                    },
                    itemCount: snapshot.data.data.length,
                  ),
                );
            }
            else{
              return
                Container(


                    child: Center(child: CircularProgressIndicator()));
            }
          }
      );
  }


  Future<CommisionHistoryModel> paymentdata() async {
    // Create Dio instance
    Dio dio = Dio();

    // Define the headers
    Map<String, String> headers = {
      'Authorization': 'Bearer 131|V1SPLBTs7BaNNUwZth5gTGjZfC1nc2qQ1EB6fpTs',
      'Cookie':
      'XSRF-TOKEN=dT0lZnI5OsbNxA88TLF4S2x45edCmnKMTwmze0oJ; umonda_online_marketplace_session=k3LCVR020r4kAVJFwu2R66nEtLr7CtFTN7ekl25M'

      //'Authorization': 'Bearer 272|zOSOR7ks4vioa05Rp8YwM61GTFAIpybBUSiX3WYv',
    };

    // Define the API endpoint
    String url = "https://umonda.com/api/v2/commission-history/138";

    try {
      // Make the API call
      Response response = await dio.get(url, options: Options(headers: headers));

      // Handle the response
      if (response.statusCode == 200) {
        return CommisionHistoryModel.fromJson(response.data);

        // API call successful
        //print(response.data);
      } else {
        // API call failed
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors
      print('An error occurred: $error');
    }
  }

}



