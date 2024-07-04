
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


  Widget listviewwr() {
    return FutureBuilder(
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
          var appointmentsListModel = snapshot.data as PaymenthistoryModel;

          return Container(
            child:
            ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, int index) {
                // Mapping function to convert enum-like string to a readable format
                String paymentType = snapshot.data.data[index].paymentType.toString().split('.')[1].replaceAll('_', ' ');

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Payment Type : ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: paymentType,
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
                                  text: snapshot.data.data[index].grandTotal.toString(),
                                  style: TextStyle(color: MyTheme.accent_color),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
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

  Widget listviewww() {
    return FutureBuilder(
      future: paymentdataa(),
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
            padding: EdgeInsets.only(top: 250),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.folder_off_outlined, size: 88, color: MyTheme.font_grey),
                  Center(
                    child: Text(
                      "No Commission available.",
                      style: TextStyle(color: MyTheme.font_grey),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {

          return
            Container(
            child: ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, int index) {

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
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
                                  text: snapshot.data.data[index].paymentType. toString() ?? "" ,
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
                                  text: snapshot.data.data[index].grandTotal.toString(),
                                  style: TextStyle(color: MyTheme.accent_color),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }


  Widget listviewwb() {
    return FutureBuilder(
      future: paymentdataa(),
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
            padding: EdgeInsets.only(top: 250),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.folder_off_outlined, size: 88, color: MyTheme.font_grey),
                  Center(
                    child: Text(
                      "No Commission available...",
                      style: TextStyle(color: MyTheme.font_grey),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {

          return Container(
            child: ListView.builder(
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, int index) {

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
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
                                  text: snapshot.data.data[index].paymentType. toString() ?? "" ,
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
                                  text: snapshot.data.data[index].grandTotal.toString(),
                                  style: TextStyle(color: MyTheme.accent_color),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
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
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      text: snapshot.data.data[index].paymentType. toString() ?? "" ,
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
                                      text: snapshot.data.data[index].grandTotal.toString(),
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












  // Widget listview() {
  //   return FutureBuilder(
  //     future: paymentdataa(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Container(
  //           child: Center(child: CircularProgressIndicator()),
  //         );
  //       } else if (snapshot.hasError) {
  //         return Container(
  //           child: Center(
  //             child: Text('Error: ${snapshot.error}'),
  //           ),
  //         );
  //       } else if (!snapshot.hasData || snapshot.data.data.isEmpty) {
  //         return Container(
  //           padding: EdgeInsets.only(top: 250),
  //           child: Center(
  //             child: Column(
  //               children: [
  //
  //                 Icon(Icons.folder_off_outlined,size: 88,color: MyTheme.font_grey),
  //                 Center(
  //                     child: Text(
  //                       "No Commission available.",
  //                       style: TextStyle(color: MyTheme.font_grey),
  //                     )),
  //                 //Text('No data available.'),
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         return Container(
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemBuilder: (context, int index) {
  //               return Column(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(12.0),
  //                     child: Container(
  //                       padding: EdgeInsets.only(top: 10, bottom: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(12),
  //                         boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))],
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               // ... your existing code ...
  //
  //                               // Example: Display "No data" message if id is null
  //                               //if (snapshot.data.data[index].id == null)
  //                               //Text(snapshot.data.data[index].id.toString()),
  //                               Text(snapshot.data.data[index].grandTotal.toString()),
  //
  //                               // Text("No data", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
  //                               // Add similar checks for other fields
  //
  //                             ],
  //                           ),
  //
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             },
  //             itemCount: snapshot.data.data.length,
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
  //
  //
  //
  // Future<PaymenthistoryModel> paymentdataa() async {
  //   // Create Dio instance
  //   Dio dio = Dio();
  //
  //   // Define the headers
  //   Map<String, String> headers = {
  //    // 'Authorization': 'Bearer 131|V1SPLBTs7BaNNUwZth5gTGjZfC1nc2qQ1EB6fpTs',
  //    // 'Authorization': access_token.$,
  //     'Cookie':
  //     'XSRF-TOKEN=dT0lZnI5OsbNxA88TLF4S2x45edCmnKMTwmze0oJ;'
  //         ' umonda_online_marketplace_session=k3LCVR020r4kAVJFwu2R66nEtLr7CtFTN7ekl25M'
  //
  //     //'Authorization': 'Bearer 272|zOSOR7ks4vioa05Rp8YwM61GTFAIpybBUSiX3WYv',
  //   };
  //
  //   // Define the API endpoint
  //
  //   // String url = "https://umonda.com/api/v2/payment-history/${user_id.$}";
  //    //String url = "${AppConfig.BASE_URL}/payment-history/${user_id.$}";
  //   String url = "https://umonda.com/api/v2/payment-history/138";
  //
  //   try {
  //     // Make the API call
  //     Response response = await dio.get(url, options: Options(headers: headers));
  //
  //     // Handle the response
  //     if (response.statusCode == 200) {
  //       print("user idnbd${user_id.$}");
  //       print("Payments screen data ${response.data}");
  //       return PaymenthistoryModel.fromJson(response.data);
  //
  //       // API call successful
  //       //print(response.data);
  //     }
  //
  //    else if(response.statusCode == 401){
  //
  //       print("500 Internal Server Error........... ");
  //       print("user id${user_id.$}");
  //       print(response.data);
  //     }
  //
  //     else {
  //       // API call failed
  //       print('API call failed with status code ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     // Handle any errors
  //     print('An error occurred: $error');
  //   }
  // }
}




