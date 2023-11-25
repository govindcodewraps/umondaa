import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:umonda/my_theme.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../Models/AmountListModel.dart';
import '../../Models/withdwawalamountmodel.dart';
import '../../app_config.dart';
import '../../helpers/shared_value_helper.dart';
import 'moneywithdrawal.dart';
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
    withdrawalaccount();
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
        padding:  EdgeInsets.only(top: 15,bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

              withdrawalaccount_widget(),

              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Moneywithdrawalrewuest()));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                  height: 150,
                  width: MediaQuery.of(context).size.width*0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      //border: Border.all(color: MyTheme.accent_color),
                      boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.add,size: 57,color: MyTheme.accent_color,),
                      Text("Send Withdrawal Request",style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
              ),
            ],),
            SizedBox(height: 16,),

            listview(),
            //SizedBox(height: 260,),

          ],

        ),
      ),
    );
  }
  Widget withdrawalaccount_widget() {
    return
      FutureBuilder(
          future: withdrawalaccount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return
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
                  child:Column(
                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height:4),
                      Text("AED " + (snapshot.data[0].adminToPay ?? "").toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                      SizedBox(height:4),
                      Text("Pending Balance", style: TextStyle(fontSize: 15,)),
                    ],
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

  Widget listview() {
    return FutureBuilder(
      future: fetchData(),
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
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Container(
            child: Center(
              child: Text('No data available.'),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.only(bottom: 60),
            height: 450,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))],
            ),
            child: ListView.builder(
              reverse: false,
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                                Text("Id :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                Text("Amount :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                Text("Date :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                Text("Status :", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                              ],
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[index].id.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                Text("AED " + snapshot.data[index].amount.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                Text(snapshot.data[index].createdAt.toString().substring(0, 10), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                SizedBox(height: 4),
                                if (snapshot.data[index].status == 0)
                                  Text("Pending", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.orangeAccent)),
                                if (snapshot.data[index].status == 1)
                                  Text("Successful", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.green)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: snapshot.data.length,
            ),
          );
        }
      },
    );
  }


  Future<List<Withdrawalamount>> withdrawalaccount() async {
    var url = Uri.parse('${AppConfig.BASE_URL}/money-withdraw-requests/${user_id.$}');
   // var url = Uri.parse('${AppConfig.BASE_URL}/money-withdraw-requests/138');

    final response = await http.get(url);

    if (response.statusCode == 200) {

      List<dynamic> jsonList = json.decode(response.body);

      List<Withdrawalamount> itemList = jsonList.map((json) => Withdrawalamount.fromJson(json)).toList();

      print("Withdrawalamount${response.body}");
      //print(response.body);

      return itemList;

    } else {
      throw Exception('Failed to load data');
    }
  }


  Future<List<amountlistmodel>> fetchData() async {
    var url = Uri.parse('${AppConfig.BASE_URL}/withdraw-requests-list/${user_id.$}');

    final response = await http.get(url);

    if (response.statusCode == 200) {

      List<dynamic> jsonList = json.decode(response.body);

      List<amountlistmodel> itemList = jsonList.map((json) => amountlistmodel.fromJson(json)).toList();

      print("HHHHHHHH${response.body}");
      print("user iddddd${user_id.$}");
      //print(response.body);

      return itemList;

    } else {
      throw Exception('Failed to load data');
    }
  }

}
