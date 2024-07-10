
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:umonda/my_theme.dart';
import '../../Models/payment_model.dart';
import '../../app_config.dart';
import '../../helpers/shared_value_helper.dart';

class PaymentScreen extends StatefulWidget {

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentdataa();
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

      body:listvieww(),
    ));
  }

  Widget listvieww() {
    return
      FutureBuilder(
        future: paymentdataa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Container(
              padding: EdgeInsets.only(top: 190),
              child: Center(child: Column(
                children: [
                  Icon(Icons.history,size: 88,color: MyTheme.font_grey),
                  Center(
                      child: Text(
                        "No Payment History.",
                        style: TextStyle(color: MyTheme.font_grey),
                      )),
                ],
              )),
            );
          } else if (snapshot.hasData) {
            var appointmentsListModel =
            snapshot.data as PaymenthistoryModel;

            return
              Container(
              //padding: EdgeInsets.only(top: 23),
              child:

              ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, int index) {
                  //final datum = snapshot.data.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10,left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
                        ],
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Payment Type : ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    // TextSpan(
                                    //   text: paymentType,
                                    //   style: TextStyle(color: MyTheme.accent_color),
                                    // ),
                                    TextSpan(
                                      text: snapshot.data.data[index].paymentType.toString(),
                                      style: TextStyle(color: MyTheme.accent_color),
                                    ),

                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Date : ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: snapshot.data.data[index].date.toString(),
                                      style: TextStyle(color: MyTheme.accent_color),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Amount	 : ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: snapshot.data.data[index].grandTotal.toString() ?? "",
                                      style: TextStyle(color: MyTheme.accent_color),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )


            );



          } else {
            return Container(
              padding: EdgeInsets.only(top: 258),
              child: Column(
                children: [

                  Icon(Icons.history,size: 88,color: MyTheme.font_grey),
                  Center(
                      child: Text(
                        "No Payment History.",
                        style: TextStyle(color: MyTheme.font_grey),
                      )),

                ],
              ),
            );
          }
        },
      );

  }



  Future<PaymenthistoryModel> paymentdataa() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      'Cookie': 'XSRF-TOKEN=dT0lZnI5OsbNxA88TLF4S2x45edCmnKMTwmze0oJ; umonda_online_marketplace_session=k3LCVR020r4kAVJFwu2R66nEtLr7CtFTN7ekl25M'
    };

    //String url = "https://umonda.com/api/v2/payment-history/138";
    String url = "${AppConfig.BASE_URL}/payment-history/${user_id.$}";

    try {
      Response response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        print("Payments screen data ${response.data}");
        return PaymenthistoryModel.fromJson(response.data);
      } else {
        print('API call failed with status code ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('An error occurred: $error');
      throw error;
    }
  }

}




