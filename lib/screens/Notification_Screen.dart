import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data_model/Infomation_Model.dart';

class Notification_Screen extends StatefulWidget {

  // Notification_Screen({super.key});

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    notification_list();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [

        notificationlist(),
        Text("data"),
      ],),),
    );
  }


  Widget notificationlist() {
    bool isExpanded = false;
    return FutureBuilder(
      future: notification_list(),
      builder: (context, snapshot) {
        print("object");

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(child: Text("No more notification")),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data.data != null) {
            print(snapshot.data.data.length);
            print("object");

            return Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return

                        InkWell(
                          onTap: () {
                            print("govind kkk");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Time slot:"),
                                          //Text(snapshot.data.data.length.toString()),
                                          SizedBox(width: 5,),
                                          // Text(snapshot.data.data[index]
                                          //     .appointmentTime.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Date :"),
                                      SizedBox(width: 10,),
                                      Text(""
                                        // DateFormat('yyyy-MM-dd').format(
                                        //   snapshot.data.data[index]
                                        //       .appointmentDate.toLocal(),
                                        // ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Name :"),
                                      Text(snapshot.data.data[index]..toString()),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Email:"),
                                      SizedBox(width: 2,),
                                     // Text(snapshot.data.data[index].email.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Contact :"),
                                      SizedBox(width: 10,),
                                      Text("+91 98765432121"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                    itemCount: snapshot.data.data.length,
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Center(child: Text("No data available")),
            );
          }
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Future<NotificationListModel> notification_list() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var data = json.encode({
        "id": 198,
      });

      var dio = Dio();
      var response = await dio.request(
        'https://webcluestechnology.com/demo/erp/umonda/api/v2/notifications',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        print(response.data);
        print("print response notification ");

        // Check if the response is a string, then decode it to a Map
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;

        return NotificationListModel.fromJson(responseData);

        print(json.encode(response.data));
      } else {
        print('Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}
