import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../Models/AmountListModel.dart';
class Moneywithdrawal extends StatefulWidget {
  //const Moneywithdrawal({super.key});

  @override
  State<Moneywithdrawal> createState() => _MoneywithdrawalState();
}

class _MoneywithdrawalState extends State<Moneywithdrawal> {
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body:Body(),

    );
  }
  Widget Body(){
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Container(
                padding: EdgeInsets.only(top: 27,left: 10,right: 10),
                height: 150,
               // width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    //border: Border.all(color: MyTheme.accent_color),
                    boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("User :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                        SizedBox(height:4),
                        Text("Admin To Pay :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                        SizedBox(height:4),
                      ],),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Govind",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                        SizedBox(height:4),
                        Text("1400.00",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                        SizedBox(height:4),

                      ],),
                  ],
                ),
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    //border: Border.all(color: MyTheme.accent_color),
                    boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                ),
                child: Center(child: Text("Withdrawal Request")),
              ),
            ],),
      SizedBox(height: 16,),



        // FutureBuilder(
        //     future: amounlist(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return
        //
        //       }
        //       else{
        //         return
        //           Container(
        //               child: Center(child: CircularProgressIndicator()));
        //       }
        //     }
        // ),

        // Container(
        //   height: 450,
        //   width: MediaQuery.of(context).size.width*1,
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(12),
        //       //border: Border.all(color: MyTheme.accent_color),
        //       boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
        //   ),
        //   child:
        //
        //   ListView.builder(
        //
        //       shrinkWrap: true,
        //       //physics:  NeverScrollableScrollPhysics(),
        //       itemBuilder: (context, int index) {
        //         return Column(
        //           //crossAxisAlignment: CrossAxisAlignment.end,
        //           //mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //
        //             Padding(
        //               padding: const EdgeInsets.all(12.0),
        //               child: Container(
        //                 padding: EdgeInsets.only(left:10,right:10,top: 10,bottom: 10),
        //                 decoration: BoxDecoration(
        //                     color: Colors.white,
        //                     borderRadius: BorderRadius.circular(12),
        //                     //border: Border.all(color: MyTheme.accent_color),
        //                     boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
        //                 ),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                   children: [
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text("Id :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //                         SizedBox(height:4),
        //                         Text("User_ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //                         SizedBox(height:4),
        //                         Text("Seller Earning :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //                         SizedBox(height:4),
        //                         Text("Created At :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //
        //
        //                       ],),
        //                     SizedBox(width: 8,),
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //
        //                       children: [
        //                         Text("id",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //                         SizedBox(height:4),
        //                         Text("User id",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //                         SizedBox(height:4),
        //                         Text("amount",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //                         SizedBox(height:4),
        //                         Text("created",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        //
        //
        //                       ],),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //
        //             //SizedBox(height: 25,),
        //
        //           ],);
        //       },
        //       itemCount: 3

        //     // itemCount: snapshot.data.lenght,
        //   ),
        //
        // ),
            listview(),


          ],
        ),
      ),
    );
  }


  Widget listview() {
    return
      FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                Container(
                  height: 450,
                  width: MediaQuery.of(context).size.width*1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      //border: Border.all(color: MyTheme.accent_color),
                      boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                  ),
                  child:

                  ListView.builder(

                      shrinkWrap: true,
                      //physics:  NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return Column(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                padding: EdgeInsets.only(left:10,right:10,top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    //border: Border.all(color: MyTheme.accent_color),
                                    boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Id :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text("User_ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text("Seller Earning :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text("Created At :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),


                                      ],),
                                    SizedBox(width: 8,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                       Text(snapshot.data[1].id.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text("User id",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text("amount",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text("created",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),


                                      ],),
                                  ],
                                ),
                              ),
                            ),

                            //SizedBox(height: 25,),

                          ],);
                      },
                      itemCount: 3
                    // itemCount: snapshot.data.lenght,
                  ),

                );


               /* Container(

                  //padding: EdgeInsets.only(top: 23),
                  child:

                  ListView.builder(

                    shrinkWrap: true,
                    //physics:  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return

                        Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  //border: Border.all(color: MyTheme.accent_color),
                                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.33,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            // //color: Colors.grey[300],

                                            //borderRadius: BorderRadius.circular(12),
                                            //border: Border.all(color: MyTheme.accent_color),

                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text("Id :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),

                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.33,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text("Order ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.33,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text("User_ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.33,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text("Seller Earning :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.33,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text("Created At :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.33,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text("updated At :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),

                                    ],),
                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text(snapshot.data.data[index].id.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text(snapshot.data.data[index].orderId.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text(snapshot.data.data[index].userId.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text(snapshot.data.data[index].sellerEarning.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text(snapshot.data.data[index].createdAt.toString().substring(0,10),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                      SizedBox(height:4),
                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                            //color: Colors.grey[300],
                                            //border: Border.all(color: MyTheme.accent_color)
                                          ),
                                          child: Text(snapshot.data.data[index].updatedAt.toString().substring(0,10),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),

                                    ],),
                                ],
                              ),
                            ),
                          ),

                          //SizedBox(height: 25,),

                        ],);
                    },
                    itemCount: snapshot.data.data.length,
                  ),
                );*/
            }
            else{
              return
                Container(


                    child: Center(child: CircularProgressIndicator()));
            }
          }
      );
  }




    // Future<AmountListModel> amounlist() async {
    //   // try {
    //   //   Dio dio = Dio();
    //   //   Response response = await dio.get(
    //   //     'https://webcluestechnology.com/demo/erp/umonda/api/v2/withdraw-requests-list/138',
    //   //     // You can add query parameters if needed like this:
    //   //     // queryParameters: {'param1': 'value1', 'param2': 'value2'},
    //   //   );
    //   //
    //   //   if (response.statusCode == 200) {
    //   //     print(response.data);
    //   //     return AmountListModel.fromJson(response.data);// Use response.data to access the response body
    //   //   } else {
    //   //     print('Request failed with status: ${response.statusCode}');
    //   //   }
    //   // } catch (error) {
    //   //   print('Error: $error');
    //   // }
    //
    //
    //   // Create Dio instance
    //   Dio dio = Dio();
    //
    //   // Define the headers
    //   Map<String, String> headers = {
    //     'Authorization': 'Bearer 131|V1SPLBTs7BaNNUwZth5gTGjZfC1nc2qQ1EB6fpTs',
    //     'Cookie':
    //     'XSRF-TOKEN=dT0lZnI5OsbNxA88TLF4S2x45edCmnKMTwmze0oJ; umonda_online_marketplace_session=k3LCVR020r4kAVJFwu2R66nEtLr7CtFTN7ekl25M'
    //
    //     //'Authorization': 'Bearer 272|zOSOR7ks4vioa05Rp8YwM61GTFAIpybBUSiX3WYv',
    //   };
    //
    //   // Define the API endpoint
    //   String url = "https://webcluestechnology.com/demo/erp/umonda/api/v2/withdraw-requests-list/138";
    //
    //   try {
    //     // Make the API call
    //     Response response = await dio.get(url, options: Options(headers: headers));
    //
    //     // Handle the response
    //     if (response.statusCode == 200) {
    //        final List<dynamic> data = json.decode(response.data);
    //       // return List<Map<String, dynamic>>.from(data);
    //      return AmountListModel.fromJson(data as Map<String, dynamic>);
    //
    //       // API call successful
    //       //print(response.data);
    //     }
    //
    //     else if(response.statusCode == 500){
    //
    //       print("500 Internal Server Error........... ");
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
    //
    //
    // }





  Future<List<Map<String, AmountListModel>>> fetchData() async {
    var url = Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/withdraw-requests-list/138');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);



    //  final List<dynamic> data = json.decode(response.body);
     // return List<Map<String, AmountListModel>>.from(data);
      final List<dynamic> data = json.decode(response.body);
      print("HHHHHHHH${data}");
      return data;

    } else {
      throw Exception('Failed to load data');
    }
  }


}
