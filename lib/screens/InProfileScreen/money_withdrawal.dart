import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../Models/AmountListModel.dart';
import '../../Models/withdwawalamountmodel.dart';
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
        padding: const EdgeInsets.only(top: 15),
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
                  height: 150,
                  width: MediaQuery.of(context).size.width*0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      //border: Border.all(color: MyTheme.accent_color),
                      boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                  ),
                  child: Center(child: Text("Withdrawal Request",style: TextStyle(fontSize: 15),)),
                ),
              ),
            ],),
            SizedBox(height: 16,),

            listview(),


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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          SizedBox(height:4),
                          Text("Balance :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          SizedBox(height:4),
                        ],),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Govind",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          SizedBox(height:4),
                          Text(snapshot.data[0].adminToPay.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          SizedBox(height:4),

                        ],),
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
                                       Text(snapshot.data[index].id.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text(snapshot.data[index].userId.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text(snapshot.data[index].amount.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                                        SizedBox(height:4),
                                        Text(snapshot.data[index].createdAt.toString().substring(0,10),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),


                                      ],),
                                  ],
                                ),
                              ),
                            ),

                            //SizedBox(height: 25,),

                          ],);
                      },
                     itemCount:3,
                    //itemCount: snapshot.data.lenght,
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


  Future<List<Withdrawalamount>> withdrawalaccount() async {
    var url = Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/money-withdraw-requests/138');

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
    var url = Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/withdraw-requests-list/138');

    final response = await http.get(url);

    if (response.statusCode == 200) {

      List<dynamic> jsonList = json.decode(response.body);

      List<amountlistmodel> itemList = jsonList.map((json) => amountlistmodel.fromJson(json)).toList();

      print("HHHHHHHH${response.body}");
      //print(response.body);

      return itemList;

    } else {
      throw Exception('Failed to load data');
    }
  }

}
