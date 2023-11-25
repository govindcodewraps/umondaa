
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Models/Commission_History_Model.dart';
import '../../Models/payment_model.dart';
import '../../app_config.dart';
import '../../helpers/shared_value_helper.dart';

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
      appBar: AppBar(
        centerTitle:true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // Change this to your desired color
        ),
        title: Row(
          children: [
            Spacer(),
            Image.asset(
              'assets/appbarlogo.png',width:100,height: 80,
              //height: 40,
              //width: 250,
            ),
            Spacer(),
            Icon(Icons.notifications,color: Colors.white,),
            Icon(Icons.notifications,color: Colors.white,),


          ],
        ),
      ),
      body:listview(),
    ));
  }



  Widget listview() {
    return FutureBuilder(
      future: paymentdata(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data.data.isEmpty) {
          return Container(
            child: Center(
              child: Text('No data available.'),
            ),
          );
        } else {
          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ... your existing code ...

                                // Example: Display "No data" message if id is null
                                if (snapshot.data.data[index].id == null)
                                  Text("No data", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                // Add similar checks for other fields

                              ],
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ... your existing code ...
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: snapshot.data.data.length,
            ),
          );
        }
      },
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
    String url = "${AppConfig.BASE_URL}/commission-history/${user_id.$}";
    //String url = "https://webcluestechnology.com/demo/erp/umonda/api/v2/commission-history/138";

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



