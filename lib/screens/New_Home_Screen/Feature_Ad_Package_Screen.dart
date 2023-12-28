import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:umonda/my_theme.dart';

import '../../app_config.dart';
import '../../data_model/PackageList_Model_Screen.dart';
import '../../data_model/SellerpackageModel.dart';
import '../../helpers/shared_value_helper.dart';
import '../login.dart';
import 'package:http/http.dart' as http;

import '../seller_package_screen.dart';

class Feature_ad_package_Screen extends StatefulWidget {



  @override
  State<Feature_ad_package_Screen> createState() => _Feature_ad_package_ScreenState();
}


class _Feature_ad_package_ScreenState extends State<Feature_ad_package_Screen> {
  String package_id;
  double amount;
  @override

  void initState() {
    // TODO: implement initState
    sellerpackage();
    super.initState();
  }// Track the selected value


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body:
      Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // listview(),
          bodyy(),
        ],),);
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, // Change the color of the back icon here
      ),
      backgroundColor: Colors.white,

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
          Icon(Icons.notifications,color: Colors.white,),
          Icon(Icons.notifications,color: Colors.white,),
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Widget bodyy(){
    return

      Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //listview(),
            Text("Featured Ad Packages",style: TextStyle(color: MyTheme.accent_color,fontSize: 22,fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Accelearte the sale of your product, get it featured on Home page",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            ),
            SizedBox(height: 10,),
            Text("Buy a Package Today !",style: TextStyle(color: MyTheme.accent_color,fontSize: 18,fontWeight: FontWeight.w600),),
            SizedBox(height: 30,),
            offergridview(),
          ],),
      );
  }


  Widget alertDialog(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return Stack(
            children: [
              // Background content
              Container(
                color: Colors.black.withOpacity(0.5), // Color overlay
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
                  child: Container(
                    color: Colors.transparent, // Transparent to apply blur
                  ),
                ),
              ),
              // AlertDialog with a blur effect
              AlertDialog(
                scrollable: true,
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Purchase Your Package",style: TextStyle(fontSize: 17),),
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.cancel)),
                      ],
                    ),
                    Divider(color: Colors.grey,)
                  ],
                ),
                content: Container(
                  // width: 400,
                  //padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment method :",style: TextStyle(fontWeight: FontWeight.w600,color: MyTheme.accent_color),),
                        SizedBox(height: 5,),
                        SizedBox(
                          //height: 50,
                          //width: 250,
                          child: TextField(
                            enabled: false,
                            //controller: pricecontroller,
                            //keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),
                              hintText: 'Stripe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              //labelText: 'Password',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [

                  Container(
                    padding: EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          child: Text("Cancel",style: TextStyle(color:Colors.black),),
                          onPressed: () {
                            // makeanofferapi(pricecontroller.text);
                            // print("Your Price ${pricecontroller.text}");
                            Navigator.pop(context);
                            //pricecontroller.clear();
                            // Your code for submitting the form.
                          },
                        ),
                        SizedBox(width: 5,),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(MyTheme.accent_color),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          child: Text("Confirm",),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Seller_package_Screen(amount: amount,package_id: package_id,)));

                            // makeanofferapi(pricecontroller.text);
                            // print("Your Price ${pricecontroller.text}");
                            //Navigator.pop(context);
                            //pricecontroller.clear();
                            // Your code for submitting the form.
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          );
        }
    );
  }

  Widget offergridview(){
    return

      FutureBuilder(
        future: sellerpackage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust the number of items in each row
                      crossAxisSpacing: 8.0, // Add spacing between items horizontally
                      mainAxisSpacing: 8.0, // Add spacing between items vertically
                    ),
                    itemBuilder: (context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))],
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/silver.png',
                              width: 100,
                              height: 80,
                            ),
                            SizedBox(height: 10),
                            Text(snapshot.data.data[index].name.toString()),

                            Text("AED ${snapshot.data.data[index].amount.toString()} | ${snapshot.data.data[index].duration.toString()} Day"),

                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 25,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(MyTheme.accent_color),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(color: MyTheme.accent_color),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  print("ID");
                                  package_id =snapshot.data.data[index].id.toString();
                                  amount =double.parse(snapshot.data.data[index].amount.toString());
                                  print(snapshot.data.data[index].id.toString());
                                  print("Package id var ${package_id}");
                                  print("Package id var ${amount}");

                                  if (is_logged_in.$ == false) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                  } else {
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Seller_package_Screen()));



                                  }
                                },
                                child: Text(
                                  "Purchase package",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.data.length,
                  ),

                ],
              ),
            );
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
  }


  Future<Sellerpackagemodel> sellerpackage() async {
    var headers = {
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IkZmdDRqVXZVUkhqb2pGZnRvbmF0UUE9PSIsInZhbHVlIjoid244NjRDVVhoOG85bGpldkc0SEpDZ2t5YU5FZURWRStIczlJNDc2aWI2bkVJenF4THoxVk9XdTU1UUg0VU1nOXBadTQ3UDFHdlNsbHF4aHBBcUViT1pZVWRJR3NwbnB5amZBVzVBTHNuTnlOVTNnd2xVK1Y0aVUzT2RxdHM0MVQiLCJtYWMiOiJiNDUxODM4MWI2ZWU2NDI3YjUwZGY4MjRmY2MwZTkyN2E4YjY4NmYyNzc2Nzg2MzdjMjJiMGZmMjNkM2IyMGQ1IiwidGFnIjoiIn0%3D; umonda_online_marketplace_session=eyJpdiI6IjE2SjJ4ZjN1MzZWMzNiMEpqeXFER0E9PSIsInZhbHVlIjoiekhpZldYWEZNY2xVWmFOallQSVpTWFZFSXRaQXlZeTVNRFB1cHZoL1Z0Ti84UVh1T1AwdkMrcFc1S0RSWmFKZWtBZ0FkSVVBaGpxWHNDcVU3ZjNVZEtOY28wNkxRbFlvNTVYQmNaVU5PNW1qcnNrd3VtWUlKQmx5QmFBZS9KZk8iLCJtYWMiOiI0MzNlZGFlNzkzZGU4ZmNmZDk2ZjNmOWQ4OThmNThkMGI5NjAwZDE4NjNlZmQ1MGYwMDE3NGVkOWNkZmY4OTE2IiwidGFnIjoiIn0%3D'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://webcluestechnology.com/demo/erp/umonda/api/v2/seller-package/',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      print("purchase package");
      //globalResponseBody=response.data;
      //print("Global data:: ${globalResponseBody}");
      return Sellerpackagemodel.fromJson(response.data);
      print("purchase package");
      //print(response.data);
    }
    else {
      print(response.statusMessage);
    }
  }


}