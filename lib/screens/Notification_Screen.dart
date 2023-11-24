import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../app_config.dart';
import '../data_model/Infomation_Model.dart';
import '../helpers/shared_value_helper.dart';
import '../presenter/home_presenter.dart';
import 'main.dart';

class Notification_Screen extends StatefulWidget {

  // Notification_Screen({super.key});

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  Map responseData = {};

  @override
  void initState() {
    // TODO: implement initState
     notification_list();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(child: 
      SingleChildScrollView(
        child: Column(children: [
            SizedBox(height: 20,),
           notificationlist(),
          SizedBox(height: 20,),

        ],),
      ),),
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
        }
        // else if (snapshot.hasError) {
        //   return Container(
        //     child: Center(child: Text("No more notification")),
        //   );
        // }
        else if (snapshot.hasData) {
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order # ${snapshot.data.data[index].data.orderCode.toString()} has been ${snapshot.data.data[index].data.status.toString()}"),
                                  SizedBox(height: 7,),
                                  Text("${DateFormat('MMMM d y').format(snapshot.data.data[index].readAt.toLocal(),)}, ${DateFormat('h:mm a').format(snapshot.data.data[index].createdAt.toLocal(),)}"),

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
          } 
          // else {
          //   return Container(
          //     child: Center(child: Text("No data available")),
          //   );
          // }
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }


  Future<NotificationListModel> notification_list() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = json.encode({
      "id":user_id.$,
    });
    var dio = Dio();
    var response = await dio.request(
      //"${AppConfig.RAW_BASE_URL}/notifications",
       //'https://webcluestechnology.com/demo/erp/umonda/api/v2/notifications',
       'https://umonda.com/api/v2/notifications',

      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,

    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      print("purchase package");
      print(response.data);
      //globalResponseBody=response.data;
      //print("Global data:: ${globalResponseBody}");
      return NotificationListModel.fromJson(response.data);
      print("purchase package");
      //print(response.data);
    }
    else {
      print(response.statusMessage);
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading:InkWell(
          onTap: (){
            Provider.of<HomePresenter>(context,listen: false).dispose();


            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return Main();
            }),(newRoute)=>false);
           // Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.black,)),
      title: Row(
        children: [
          // Text(
          //   AppLocalizations.of(context).shopping_cart_ucf,
          //   style: TextStyles.buildAppBarTexStyle(),
          // ),
          Spacer(),
          Image.asset(
            'assets/appbarlogo.png',width:100,height: 80,
            //height: 40,
            //width: 250,
          ),
          Spacer(),
          Icon(Icons.notifications),
          Icon(Icons.notifications),

        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

}
