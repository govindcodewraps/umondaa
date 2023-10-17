import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../custom/useful_elements.dart';
import '../../data_model/My_ads_list_model.dart';
import '../../data_model/flash_deal_response.dart';
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

  @override
  void initState() {
    super.initState();
    fetchDataaa();
  }

  Future<void> fetchDataaa() async {
    final response = await http.get(
      Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/products/seller/163?page=1'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      products = data.map((item) => Product.fromJson(item)).toList();

      setState(() {}); // Update the UI with the fetched data
    } else {
      throw Exception('Failed to load data');
    }
  }








  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
          children: [
            listview(),
          ],
      ),
        ),),
    );
  }



  Widget listview(){
    return

      // ListView.builder(
      //   itemCount: products.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(products[index].name.toString()),
      //       //subtitle: Text(products[index].mainPrice.toString()),
      //     );
      //   },
      // );



      FutureBuilder(
          future: fetchDataaa(),

          builder: (context, snapshot) {

            if (snapshot.hasData) {
              print("AAAAAAAAAAAAAA ${snapshot.data[0].name.toString()}");
              return
                ListView.builder(
                  itemCount: snapshot.data.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[1].products[1].name.toString()),
                      //subtitle: Text(products[index].mainPrice.toString()),
                    );
                  },
                );
            }
            else{
              return
                Container(
                    child: Center(child: CircularProgressIndicator()));
            }
          }
      );




      /*Container(
      //padding: EdgeInsets.only(top: 23),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          // Your separator builder logic here
          return Divider(); // Example: Using a Divider as the separator
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context , int index){
          return Column(children: [
           // Text("Govind"),
            Container(
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
                  ),
                SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                        //border: Border.all(color: MyTheme.accent_color),
                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                    ),

                    height: 100,
                    width: MediaQuery.of(context).size.width *0.6,
                    child: Column(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ],),
                  ),
                ],
              ),
            )
          ],);

        },
        itemCount: 51,
      ),
    );*/
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

  Future<MyAdsListModel> myadsapicall()  async {
    var headers = {
      'Cookie':
      'XSRF-TOKEN=eyJpdiI6IkpzZEJucwT1iZDRmYzQzATEwNDYwNmE4Njg5MGNiNzcxM2RiIiwidGFnIjoiIn0%3D; umonda_online_marketplace_session=eyJpdiI6IkFFM0M0RHVaZ3RDN25sbGFqd0VES3c9PSIsInZhbHVlIjoiNjZzQ1g0djlhcVhnM0ZWb1QzaCtpQ3U1Yk1oKzB4Z3ZZaTc5SzJRNk1MWmpWb2N6ek1oTDNMcUN6V2FlSVQ3Z0ZQNE03UzNBdEVWUnVxc3T1iLCJtYWMiOiI2NjlkNTBiOWRiOTNiYTQ2Yjk1ZjQ1MmFlZGEyMTRlMDE3MWY2YjczYjQ1YjgwNjEwODQ3ABcQzOGJlZTgyNjE1IiwidGFnIjoiIn0%3D',
    };

    try {
      var response = await http.get(
        Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/products/seller/163?page=1'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print(jsonEncode(response.body));
        print("Govind My Ads list ${jsonEncode(response.body)}");
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

}
