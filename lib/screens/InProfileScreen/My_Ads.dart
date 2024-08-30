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


  List<Product> products = [];
  String product_Id;
  String product_name;
  String product_price;
  String product_des;

  //
  @override
  void initState() {
    super.initState();
    myadsapicall();
  }
  Future<void> _onPageRefresh() async {
    myadsapicall();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    myadsapicall();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          appBar: buildAppBar(context),
          body:
          buildBody()


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

  Widget listview() {
    return FutureBuilder(
      future: myadsapicall(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data.data.isEmpty) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Center(
                child: Column(
                  children: [

                    Icon(Icons.folder_off_outlined,size: 88,color: MyTheme.font_grey),
                    Center(
                        child: Text(
                          "No ads available.",
                          style: TextStyle(color: MyTheme.font_grey),
                        )),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              padding: EdgeInsets.only(bottom: 9),
              child: Column(
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
                            if(snapshot.data.data[index].soldStatus==0)

                              Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_placead(Product_ID: product_Id,Product_Name: product_name,Product_Price: product_price)))
                                  .then((value){ if(value != null && value)
                              {
                                setState(() {
                                  myadsapicall();
                                });
                              };
                              });

                            print("Govind >>>>>>>>>>>>>>");
                            product_Id = snapshot.data.data[index].id.toString();
                            product_name = snapshot.data.data[index].name.toString();
                            product_price = snapshot.data.data[index].mainPrice.toString();

                            product_des = snapshot.data.data[2].published.toString();
                            print("PUBLISH   ${product_des}");
                            //nvbndm
                            //snapshot.data.data[index].name.toString(),

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

                                        height: MediaQuery.of(context).size.height * 0.09,
                                        //height:double.infinity,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: thumbnailImage == null
                                            ? Image.asset("assets/silver.png", fit: BoxFit.fill)
                                            : Image.network(
                                          thumbnailImage,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data.data[index].name.toString(),
                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                              maxLines: 2,  // Set maximum lines to 2
                                              overflow: TextOverflow.ellipsis,  // Handle overflow with ellipsis (...)
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              snapshot.data.data[index].mainPrice.toString(),
                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                            ),
                                            // SizedBox(height: 5),
                                            // Text(
                                            //   snapshot.data.data[index].published.toString(),
                                            //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                            // ),


                                            //
                                            Row(children: [
                                              Text("Status:"),
                                              Text(
                                                snapshot.data.data[index].soldStatus == 0 ? 'Not Sold' : 'Product Sold',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: snapshot.data.data[index].soldStatus == 0 ? Colors.red : Colors.green,
                                                ),
                                              ),
                                            ],),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                               if(snapshot.data.data[index].soldStatus==0)
                                Positioned(
                                  right: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      product_Id = snapshot.data.data[index].id.toString();
                                      print("print product iddddddd ${product_Id}");
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        product_Id = snapshot.data.data[index].id.toString();
                                        print("print product id Delete ${product_Id}");
                                        deleteapicall(product_Id);
                                      },
                                      child: Center(
                                        child: PopupMenuButton<int>(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem<int>(
                                                value: 0,
                                                child: Text("Edit"),
                                              ),
                                              PopupMenuItem<int>(
                                                value: 1,
                                                child: Text("Delete"),
                                              ),
                                            ];
                                          },
                                          onSelected: (value) {
                                            if (value == 0) {
                                              //product_Id = snapshot.data.data[index].id.toString();
                                              product_Id = snapshot.data.data[index].id.toString();
                                              product_name = snapshot.data.data[index].name.toString();
                                              product_price = snapshot.data.data[index].mainPrice.toString();
                                              print("print product id Edit ${product_Id}");

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_placead(Product_ID: product_Id,Product_Name: product_name,Product_Price: product_price)))
                                                  .then((value){ if(value != null && value)
                                              {
                                                setState(() {
                                                  myadsapicall();
                                                });
                                              };
                                              });


                                              // Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_placead(Product_ID: product_Id)));
                                              print("Edit  menu is selected.");
                                            } else if (value == 1) {
                                              product_Id = snapshot.data.data[index].id.toString();
                                              print("print product id Delete ${product_Id}");
                                              deleteapicall(product_Id);
                                            }
                                          },
                                          child: Icon(Icons.more_vert),
                                          offset: Offset(0, 0,),
                                          elevation: 0,
                                        ),
                                      ),
                                    ),
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
              ),
            ),
          );
        }
      },
    );
  }



  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.black,)),
      title: Row(
        children: [

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
      'Cookie':
      'XSRF-TOKEN=eyJpdiI6IkpzZEJucwT1iZDRmYzQzATEwNDYwNmE4Njg5MGNiNzcxM2RiIiwidGFnIjoiIn0%3D; umonda_online_marketplace_session=eyJpdiI6IkFFM0M0RHVaZ3RDN25sbGFqd0VES3c9PSIsInZhbHVlIjoiNjZzQ1g0djlhcVhnM0ZWb1QzaCtpQ3U1Yk1oKzB4Z3ZZaTc5SzJRNk1MWmpWb2N6ek1oTDNMcUN6V2FlSVQ3Z0ZQNE03UzNBdEVWUnVxc3T1iLCJtYWMiOiI2NjlkNTBiOWRiOTNiYTQ2Yjk1ZjQ1MmFlZGEyMTRlMDE3MWY2YjczYjQ1YjgwNjEwODQ3ABcQzOGJlZTgyNjE1IiwidGFnIjoiIn0%3D',
    };

    String url = '${AppConfig.BASE_URL}/products/seller/${user_id.$}?page=1';
    //String url = 'https://webcluestechnology.com/demo/erp/umonda/api/v2/products/seller/${user_id.$}?page=1';

    try {
      // Make the API call
      Response response = await dio.get(url, options: Options(headers: headers));
print("print url::  ${url}");
      // Handle the response
      if (response.statusCode == 200) {
        print("user iddddd${user_id.$}");
        //print("Govind My Ads list ${jsonEncode(response.data)}");
        print("Govind My Ads list ${response.data}");
        return MyAdsListModel.fromJson(response.data);

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