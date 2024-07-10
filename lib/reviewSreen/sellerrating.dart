import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:umonda/reviewSreen/sellerratingmodel.dart';

import '../my_theme.dart';

class Sellerratingscreen extends StatefulWidget {
  final int id;

  Sellerratingscreen({Key key, this.id}) : super(key: key);

  @override
  State<Sellerratingscreen> createState() => _SellerratingscreenState();
}

class _SellerratingscreenState extends State<Sellerratingscreen> {
  Future<Sellerrating> _futureSellerRating;

  @override
  void initState() {
    super.initState();
    _futureSellerRating = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Seller ID: ${widget.id}',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),

           // SizedBox(height: 16),
            FutureBuilder<Sellerrating>(
              future: _futureSellerRating,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: CircularProgressIndicator(),
                  ));
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Column(
                      children: [

                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star_border,size: 55,),
                            Icon(Icons.star_border,size: 55,),
                            Icon(Icons.star_border,size: 55,),
                            Icon(Icons.star_border,size: 55,),
                            Icon(Icons.star_border,size: 55,),

                          ],
                        ),
SizedBox(height: 30,),
                        Text('No Ratings Yet !',style: TextStyle(fontSize: 20),),

                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data.products.isEmpty) {
                  return Center(child: Column(
                    children: [
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_border,size: 55,),
                          Icon(Icons.star_border,size: 55,),
                          Icon(Icons.star_border,size: 55,),
                          Icon(Icons.star_border,size: 55,),
                          Icon(Icons.star_border,size: 55,),

                        ],
                      ),
                      SizedBox(height: 30,),
                      Text('No Ratings Yet !'),
                    ],
                  ));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Average Rating of Seller: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: RatingBar.builder(
                                    //initialRating: 2,
                                    initialRating:snapshot.data.averageRating.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    glowColor: Colors.amber,
                                    itemSize: 20.0,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        //  _my_rating = rating;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16,),
                            Text(
                              'Other Products: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.products.length,
                        itemBuilder: (context, index) {
                          var product = snapshot.data.products[index];
                          return ListTile(
                            title: Container(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
                              //height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Text(
                                product.productName.toString(),
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                           // subtitle: Text('Rating: ${product.productRating}'),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(CupertinoIcons.arrow_left, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Seller Ratings",
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Future<Sellerrating> fetchData() async {
    var dio = Dio();

    try {
      var response = await dio.request(
        //'https://umonda.com/api/v2/reviews/seller/420',
        'https://umonda.com/api/v2/reviews/seller/${widget.id}',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print("print seller rating response ${response.data}");
        return sellerratingFromJson(json.encode(response.data));
      } else {
        throw Exception('Failed to load data: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioError) {
        // Handle DioError
        print('Dio error: ${e.message}');
        throw e;
      } else {
        // Handle other errors
        print('Unexpected error: $e');
        throw e;
      }
    }
  }
}
