import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../app_config.dart';
import '../../custom/toast_component.dart';
import '../../custom/useful_elements.dart';
import '../../data_model/My_ads_list_model.dart';
import '../../data_model/flash_deal_response.dart';
import '../../helpers/shared_value_helper.dart';
import 'package:dio/dio.dart';

import '../../my_theme.dart';
import '../Edit_My_Ads_Screen.dart';
class My_adsScreen extends StatefulWidget {
  //const My_adsScreen({super.key});

  @override
  State<My_adsScreen> createState() => _My_adsScreenState();
}

class _My_adsScreenState extends State<My_adsScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   myadsapicall();
  // }



  List<Product> products = [];
  String product_Id;
  //
  @override
  void initState() {
    super.initState();
    //fetchDataaa();
    myadsapicall();
  }
  Future<void> _onPageRefresh() async {
    //reset();
    myadsapicall();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    myadsapicall();
    super.setState(fn);
  }

  // Future<void> fetchDataaa() async {
  //   final response = await http.get(
  //     Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/products/seller/163?page=1'),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body)['data'];
  //     products = data.map((item) => Product.fromJson(item)).toList();
  //
  //     setState(() {}); // Update the UI with the fetched data
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }








  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: buildAppBar(context),
        body:
        buildBody()


      //   SingleChildScrollView(
      //     child: Column(
      //     children: [
      //       listview(),
      //
      //     ],
      // ),
      //   ),

      ),
    );
  }


  RefreshIndicator buildBody() {
    return RefreshIndicator(
      color: MyTheme.accent_color,
      backgroundColor: Colors.red,
      onRefresh: _onPageRefresh,
      displacement: 10,
      child:      SingleChildScrollView(
        child: Column(
          children: [
            listview(),

          ],
        ),
      ),
    );
  }



  Widget listview(){
    return
      FutureBuilder(
          future: myadsapicall(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
             // final thumbnailImage = snapshot.data.data[index].thumbnailImage;
              return

                SingleChildScrollView(
                  child: Container(
                    //height: 600,
                    height: MediaQuery.of(context).size.height*1,
                    padding: EdgeInsets.only(bottom: 90),
                    child: 
                    Column(
                      children: [


                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // You can change this number based on the number of columns you want
                            ),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (context, index) {
                              final thumbnailImage = snapshot.data.data[index].thumbnailImage;
                              return InkWell(
                                onTap: () {
                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_placead(Product_ID:product_Id,)));
                                  print("Govind >>>>>>>>>>>>>>");
                                   product_Id = snapshot.data.data[index].id.toString();
                                   print("print product id ${product_Id}");
                                },
                                child: Container(

                                  padding: EdgeInsets.all(10),
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 20,
                                        child: Column(
                                          children: [
                                            Container(

                                              // height: MediaQuery.of(context).size.height * 0.11,
                                              // width: MediaQuery.of(context).size.width * 0.5,

                                              height: MediaQuery.of(context).size.height * 0.11,
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: thumbnailImage == null
                                                  ? Image.asset("assets/silver.png", fit: BoxFit.fill)
                                                  : Image.network(
                                                thumbnailImage,
                                                fit: BoxFit.fill,
                                              ),

                                            ),
                                            SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data.data[index].name.toString(),
                                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  snapshot.data.data[index].mainPrice.toString(),
                                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],

                                        ),
                                      ),

                                      Positioned(
                                        right: 1,
                                        child: GestureDetector(
                                          onTap: (){
                                            product_Id = snapshot.data.data[index].id.toString();
                                           print("print product iddddddd ${product_Id}");
                                          },
                                          child:  InkWell(
                                              onTap: (){
                                                product_Id = snapshot.data.data[index].id.toString();
                                                print("print product id Delete ${product_Id}");
                                                deleteapicall(product_Id);

                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius: BorderRadius.circular(100)
                                                    ),
                                                    child: Icon(Icons.delete,color: Colors.black,)),
                                              ))

                                          /*PopupMenuButton<int>(
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem<int>(
                                                  value: 0,
                                                  child: Icon(Icons.edit,color: Colors.green,),
                                                ),
                                                PopupMenuItem<int>(
                                                  value: 1,
                                                  child: Icon(Icons.delete,color: Colors.red,),
                                                ),
                                              ];
                                            },
                                            onSelected: (value) {
                                              if (value == 0) {
                                                product_Id = snapshot.data.data[index].id.toString();
                                                print("print product id Edit ${product_Id}");
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_placead(Product_ID:product_Id,),));
                                                print("Edit  menu is selected.");
                                                // Handle edit action
                                              } else if (value == 1) {
                                                product_Id = snapshot.data.data[index].id.toString();
                                                print("print product id Delete ${product_Id}");
                                                deleteapicall(product_Id);
                                                // Handle delete action
                                              }
                                            },
                                            child: Icon(Icons.more_vert), // Add an icon to trigger the popup
                                            offset: Offset(0, 20), // Optional: Adjust the position of the popup
                                            color: Colors.transparent, // Set the background color to transparent
                                            elevation: 0,
                                            //padding: EdgeInsets.only(left: 10),
                                           // Optional: Remove the shadow
                                          )*/


                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    )




                 /*   ListView.separated(
                      separatorBuilder: (context, index) {
                        // Your separator builder logic here
                        return Divider(); // Example: Using a Divider as the separator
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context , int index){
                        final thumbnailImage = snapshot.data.data[index].thumbnailImage;
                        return Column(children: [
                          // Text("Govind"),
                          InkWell(
                            onTap: (){
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_placead()));
                              print("print product id");
                              product_Id=snapshot.data.data[index].id.toString();
                             // print("print product id ${snapshot.data.data[index].id.toString()}");
                              print("print produc ${product_Id}");
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width *1,
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(12),
                                        //border: Border.all(color: MyTheme.accent_color),
                                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]

                                    ),

                                    height: 100,
                                    width: MediaQuery.of(context).size.width *0.3,
                                    //child: Image.asset("assets/silver.png",fit: BoxFit.fill,),


                     child:   thumbnailImage == null
                                           ? Image.asset("assets/silver.png",fit: BoxFit.fill,)
                                             : Image.network(thumbnailImage, fit: BoxFit.fill),

                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    padding: EdgeInsets.only(left: 16,top: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        //border: Border.all(color: MyTheme.accent_color),
                                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                                    ),

                                    height: 100,
                                    width: MediaQuery.of(context).size.width *0.6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data.data[index].name.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                                      SizedBox(height: 5,),
                                        Text(snapshot.data.data[index].mainPrice.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                                        //Text(snapshot.data.data[index].links[0].details.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                                      ],),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],);

                      },
                      //itemCount: 51,
                      itemCount: snapshot.data.data.length,
                    ),*/


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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // leading: Builder(
      //   builder: (context) =>
      //   widget.from_navigation ? UsefulElements.backToMain(context, go_back: false) : UsefulElements.backButton(context),
      // ),
      leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.black,)),
      title: Row(
        children: [
          //Icon(Icons.arrow_back_ios_new,color: Colors.black,),
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




  Future<MyAdsListModel> myadsapicall() async {
    // Create Dio instance
    Dio dio = Dio();

    // Define the headers
    Map<String, String> headers = {
      // 'Authorization': 'Bearer 131|V1SPLBTs7BaNNUwZth5gTGjZfC1nc2qQ1EB6fpTs',
      // 'Authorization': access_token.$,
      'Cookie':
      'XSRF-TOKEN=eyJpdiI6IkpzZEJucwT1iZDRmYzQzATEwNDYwNmE4Njg5MGNiNzcxM2RiIiwidGFnIjoiIn0%3D; umonda_online_marketplace_session=eyJpdiI6IkFFM0M0RHVaZ3RDN25sbGFqd0VES3c9PSIsInZhbHVlIjoiNjZzQ1g0djlhcVhnM0ZWb1QzaCtpQ3U1Yk1oKzB4Z3ZZaTc5SzJRNk1MWmpWb2N6ek1oTDNMcUN6V2FlSVQ3Z0ZQNE03UzNBdEVWUnVxc3T1iLCJtYWMiOiI2NjlkNTBiOWRiOTNiYTQ2Yjk1ZjQ1MmFlZGEyMTRlMDE3MWY2YjczYjQ1YjgwNjEwODQ3ABcQzOGJlZTgyNjE1IiwidGFnIjoiIn0%3D',

      //'Authorization': 'Bearer 272|zOSOR7ks4vioa05Rp8YwM61GTFAIpybBUSiX3WYv',
    };

    // Define the API endpoint
      String url = '${AppConfig.BASE_URL}/products/seller/${user_id.$}?page=1';
     //String url = 'https://webcluestechnology.com/demo/erp/umonda/api/v2/products/seller/${user_id.$}?page=1';
    //String url = "https://umonda.com/api/v2/payment-history/138";

    try {
      // Make the API call
      Response response = await dio.get(url, options: Options(headers: headers));

      // Handle the response
      if (response.statusCode == 200) {
        print("user iddddd${user_id.$}");
        //print("Govind My Ads list ${jsonEncode(response.data)}");
        print("Govind My Ads list ${response.data}");
        return MyAdsListModel.fromJson(response.data);

        // API call successful
        //print(response.data);
      }

      else if(response.statusCode == 401){

        print("500 Internal Server Error........... ");
        print("user iddddd${user_id.$}");
        print(response.data);
      }

      else {
        // API call failed
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors
      print('An error occurred: $error');
    }
  }



  // Future<MyAdsListModel> myadsapicall()  async {
  //   var headers = {
  //     'Cookie':
  //     'XSRF-TOKEN=eyJpdiI6IkpzZEJucwT1iZDRmYzQzATEwNDYwNmE4Njg5MGNiNzcxM2RiIiwidGFnIjoiIn0%3D; umonda_online_marketplace_session=eyJpdiI6IkFFM0M0RHVaZ3RDN25sbGFqd0VES3c9PSIsInZhbHVlIjoiNjZzQ1g0djlhcVhnM0ZWb1QzaCtpQ3U1Yk1oKzB4Z3ZZaTc5SzJRNk1MWmpWb2N6ek1oTDNMcUN6V2FlSVQ3Z0ZQNE03UzNBdEVWUnVxc3T1iLCJtYWMiOiI2NjlkNTBiOWRiOTNiYTQ2Yjk1ZjQ1MmFlZGEyMTRlMDE3MWY2YjczYjQ1YjgwNjEwODQ3ABcQzOGJlZTgyNjE1IiwidGFnIjoiIn0%3D',
  //   };
  //
  //   try {
  //     var response = await http.get(
  //       Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/products/seller/163?page=1'),
  //       headers: headers,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print(jsonEncode(response.body));
  //       print("Govind My Ads list ${jsonEncode(response.body)}");
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('An error occurred: $e');
  //   }
  // }


  // import 'package:dio/dio.dart';
  // import 'dart:convert';

  Future<void> deleteapicall(prductid) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };

      var data = json.encode({
        "user_id": user_id.$,
        "product_id": prductid
      });

      var dio = Dio();

      var response = await dio.request(
      //  '${AppConfig.BASE_URL}/api/v2/product/delete',
        '${AppConfig.BASE_URL}/product/delete',
      //  'https://webcluestechnology.com/demo/erp/umonda/api/v2/product/delete',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        print("deleted product message ${response.data}");
        Fluttertoast.showToast(
          msg: "Product deleted successfully",
          // toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        myadsapicall();
       // myadsapicall();
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }



}
