// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:provider/provider.dart';
//
// import '../../data_model/classified_ads_response.dart';
// import '../../helpers/shared_value_helper.dart';
// import '../../helpers/shimmer_helper.dart';
// import '../../presenter/home_presenter.dart';
// import '../../ui_elements/product_card.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import 'new_home_presenter.dart';
//
// int allProductPage = 1;
// int lastPageee=0;
// class Allnewads_Screen extends StatefulWidget {
//   @override
//   State<Allnewads_Screen> createState() => _Allnewads_ScreenState();
// }
//
// class _Allnewads_ScreenState extends State<Allnewads_Screen> {
//   AllHomePresenter homePresenterr;
//
//  // String lastPage;
//
//   @override
//   void initState() {
//     pagecountapi();
//
//     Future.delayed(Duration.zero).then((value) {
//       change();
//     });
//     super.initState();
//     print("0- home.dart, is_logged_in :");
//     if (is_logged_in.$ == true) {
//       print("1- home.dart, is_logged_in : ${is_logged_in}");
//       print("2- home.dart, is_logged_in : ${is_logged_in.$}");
//     }
//   }
//
//   change() {
//     homePresenterr = Provider.of<AllHomePresenter>(context, listen: false);
//     homePresenterr.onRefresh();
//     homePresenterr.mainScrollListener();
//     homePresenterr.initPiratedAnimation(this);
//   }
//
//   @override
//   void dispose() {
//     print("Dispose");
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllHomePresenter>(builder: (context, homeDataa, child) {
//       return Scaffold(
//         appBar: buildAppBar(context),
//         body: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     buildHomeAllProducts20(context, homeDataa),
//                     SizedBox(height: 10,),
//
//                     Padding(
//                       padding:  EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 0),
//                       child: Row(
//                         children: [
//                            if (allProductPage > 1)
//
//                             InkWell(
//                                 onTap:(){
//                                       setState(() {
//                                         allProductPage--;
//                                         allProductPage =
//                                             allProductPage.clamp(1, double.infinity).toInt();
//                                         homePresenterr.resetAllProductList();
//                                         homePresenterr.fetchAllProducts();
//                                         print("Aproduct-${allProductPage}");
//                                       });
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.arrow_back_ios_new_sharp),
//                                     //Text(" Prev",style: TextStyle(fontSize: 19),),
//
//                                   ],
//                                 )),
//
//                           Spacer(),
//
//
//
//                           //if (allProductPage < 3)
//                           if (allProductPage < lastPageee)
//                             InkWell(
//                                 onTap: (){
//                                       setState(() {
//                                         allProductPage++;
//                                         homePresenterr.resetAllProductList();
//                                         homePresenterr.fetchAllProducts();
//                                         print("Aproduct ${allProductPage}");
//                                       });
//                                 },
//                                 child: Row(
//                                   children: [
//                                    // Text("Next",style: TextStyle(fontSize: 19),),
//
//                                     Icon(Icons.arrow_forward_ios_rounded),
//                                   ],
//                                 )),
//
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       iconTheme: IconThemeData(
//         color: Colors.black,
//       ),
//       backgroundColor: Colors.white,
//       title: Row(
//         children: [
//           Spacer(),
//           Image.asset(
//             'assets/appbarlogo.png',
//             width: 100,
//             height: 80,
//           ),
//           Spacer(),
//           Icon(Icons.notifications, color: Colors.white,),
//           Icon(Icons.notifications, color: Colors.white,),
//         ],
//       ),
//       elevation: 0.0,
//       titleSpacing: 0,
//     );
//   }
//
//   Widget buildHomeAllProducts20(context, AllHomePresenter homeDataa) {
//     if (homeDataa.isAllProductInitial && homeDataa.allProductList.length == 0) {
//       return SingleChildScrollView(
//           child: ShimmerHelper().buildProductGridShimmer(
//               scontroller: homeDataa.allProductScrollController));
//     } else if (homeDataa.allProductList.length > 0) {
//       return MasonryGridView.count(
//           crossAxisCount: 2,
//           mainAxisSpacing: 14,
//           crossAxisSpacing: 14,
//           itemCount: homeDataa.allProductList.length,
//           shrinkWrap: true,
//           padding: EdgeInsets.only(top: 20.0, bottom: 1, left: 18, right: 18),
//           physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))]
//               ),
//               child: ProductCard(
//                 id: homeDataa.allProductList[index].id,
//                 image: homeDataa.allProductList[index].thumbnail_image,
//                 name: homeDataa.allProductList[index].name,
//                 main_price: homeDataa.allProductList[index].main_price,
//                 stroked_price: homeDataa.allProductList[index].stroked_price,
//                 has_discount: homeDataa.allProductList[index].has_discount,
//                 discount: homeDataa.allProductList[index].discount,
//                 is_wholesale: homeDataa.allProductList[index].isWholesale,
//               ),
//             );
//           });
//     } else if (homeDataa.totalAllProductData == 0) {
//       return Center(
//           child: Text(AppLocalizations.of(context).no_product_is_available));
//     } else {
//       return Container();
//     }
//   }
//
//   Future<void> pagecountapi() async {
//     Dio dio = Dio();
//     var apiUrl = 'https://umonda.com/api/v2/products?page=1';
//
//     try {
//       // Make the API request using Dio
//       var response = await dio.get(apiUrl);
//
//       // Check if the request was successful (status code 200)
//       if (response.statusCode == 200) {
//
//         // Parse the JSON response
//         Map<String, dynamic> jsonMap = response.data;
//
//
//         // Extract and print the "last_page" value
//         int lastPage = jsonMap['meta']['last_page'];
//         lastPageee=lastPage;
//         print('Last Page: $lastPageee');
//
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Reason: ${response.statusMessage}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }




import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../data_model/classified_ads_response.dart';
import '../../helpers/shared_value_helper.dart';
import '../../helpers/shimmer_helper.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/product_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'new_home_presenter.dart';

int allProductPage = 1;
int lastPageee = 0;

class Allnewads_Screen extends StatefulWidget {
  @override
  State<Allnewads_Screen> createState() => _Allnewads_ScreenState();
}

class _Allnewads_ScreenState extends State<Allnewads_Screen> {
  AllHomePresenter homePresenterr;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    pagecountapi();

    Future.delayed(Duration.zero).then((value) {
      change();
    });
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  change() {
    homePresenterr = Provider.of<AllHomePresenter>(context, listen: false);
    homePresenterr.onRefresh();
    homePresenterr.mainScrollListener();
    homePresenterr.initPiratedAnimation(this);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more data
      if (allProductPage < lastPageee) {
        setState(() {
          allProductPage++;
          homePresenterr.resetAllProductList();
          homePresenterr.fetchAllProducts();
          print("Aproduct ${allProductPage}");
        });
      }
    } else if (_scrollController.position.pixels == 0) {
      // Scrolled to the top, trigger refresh
      _handleRefresh();
    }
  }

  Future<void> _handleRefresh() async {
    // Fetch previous data
    if (allProductPage > 1) {
      setState(() {
        allProductPage--;
        homePresenterr.resetAllProductList();
        homePresenterr.fetchAllProducts();
        print("Aproduct-${allProductPage}");
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllHomePresenter>(builder: (context, homeDataa, child) {
      return Scaffold(
        appBar: buildAppBar(context),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      buildHomeAllProducts20(context, homeDataa),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 0),
              //   child: Row(
              //     children: [
              //       if (allProductPage > 1)
              //         InkWell(
              //             onTap: () {
              //               setState(() {
              //                 allProductPage--;
              //                 allProductPage =
              //                     allProductPage.clamp(1, double.infinity).toInt();
              //                 homePresenterr.resetAllProductList();
              //                 homePresenterr.fetchAllProducts();
              //                 print("Aproduct-${allProductPage}");
              //               });
              //             },
              //             child: Row(
              //               children: [
              //                 Icon(Icons.arrow_back_ios_new_sharp),
              //               ],
              //             )),
              //       Spacer(),
              //       if (allProductPage < lastPageee)
              //         InkWell(
              //             onTap: () {
              //               setState(() {
              //                 allProductPage++;
              //                 homePresenterr.resetAllProductList();
              //                 homePresenterr.fetchAllProducts();
              //                 print("Aproduct ${allProductPage}");
              //               });
              //             },
              //             child: Row(
              //               children: [
              //                 Icon(Icons.arrow_forward_ios_rounded),
              //               ],
              //             )),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }

  // ... other methods


    AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Spacer(),
          Image.asset(
            'assets/appbarlogo.png',
            width: 100,
            height: 80,
          ),
          Spacer(),
          Icon(Icons.notifications, color: Colors.white,),
          Icon(Icons.notifications, color: Colors.white,),
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Widget buildHomeAllProducts20(context, AllHomePresenter homeDataa) {
    if (homeDataa.isAllProductInitial && homeDataa.allProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: homeDataa.allProductScrollController));
    } else if (homeDataa.allProductList.length > 0) {
      return MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          itemCount: homeDataa.allProductList.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 20.0, bottom: 1, left: 18, right: 18),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))]
              ),
              child: ProductCard(
                id: homeDataa.allProductList[index].id,
                image: homeDataa.allProductList[index].thumbnail_image,
                name: homeDataa.allProductList[index].name,
                main_price: homeDataa.allProductList[index].main_price,
                stroked_price: homeDataa.allProductList[index].stroked_price,
                has_discount: homeDataa.allProductList[index].has_discount,
                discount: homeDataa.allProductList[index].discount,
                is_wholesale: homeDataa.allProductList[index].isWholesale,
              ),
            );
          });
    } else if (homeDataa.totalAllProductData == 0) {
      return Center(
          child: Text(AppLocalizations.of(context).no_product_is_available));
    } else {
      return Container();
    }
  }


  Future<void> pagecountapi() async {
    Dio dio = Dio();
    var apiUrl = 'https://umonda.com/api/v2/products?page=1';

    try {
      var response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data;
        lastPageee = jsonMap['meta']['last_page'];
        print('Last Page: $lastPageee');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Reason: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}









/*
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:provider/provider.dart";

import '../../helpers/shared_value_helper.dart';
import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';
import '../../ui_elements/product_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hardware_lo/custom/useful_elements.dart';


import 'new_home_presenter.dart';

class Allnewads_Screen extends StatefulWidget {
  //const Allnewads_Screen({super.key});

  @override
  State<Allnewads_Screen> createState() => _Allnewads_ScreenState();
}

class _Allnewads_ScreenState extends State<Allnewads_Screen> {
  AllHomePresenter homePresenterr;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      change();
    });
    // change();
    // TODO: implement initState
    super.initState();
    print("0- home.dart, is_logged_in :");
    if (is_logged_in.$ == true) {
      //fetchAll();
      print("1- home.dart, is_logged_in : ${is_logged_in}");
      print("2- home.dart, is_logged_in : ${is_logged_in.$}");
    }
  }
  change() {
    homePresenterr = Provider.of<AllHomePresenter>(context, listen: false);
    homePresenterr.onRefresh();
    homePresenterr.mainScrollListener();
    homePresenterr.initPiratedAnimation(this);
  }

  @override
  void dispose() {
    print("Dispose");
    // homePresenter.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Consumer<AllHomePresenter>(builder: (context, homeDataa, child) {
      return Scaffold
        (
        appBar: buildAppBar(context),
        body: Column(children: [
       // buildHomeAllProducts20(context, homeDataa),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // buildHomeAllProducts20(context, homeDataa),



                buildHomeFeatureProductHorizontalList(
                    homeDataa as HomePresenter),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),

      ],),);
    });



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

  Widget buildHomeAllProducts20(context, AllHomePresenter homeDataa) {
    if (homeDataa.isAllProductInitial && homeDataa.allProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: homeDataa.allProductScrollController));
    } else if (homeDataa.allProductList.length > 0) {
      return MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          itemCount: homeDataa.allProductList.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 20.0, bottom: 1, left: 18, right: 18),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  //border: Border.all(color: MyTheme.accent_color),
                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
              ),
              //height: 270,
              child: ProductCard(
                id: homeDataa.allProductList[index].id,
                image: homeDataa.allProductList[index].thumbnail_image,
                name: homeDataa.allProductList[index].name,
                main_price: homeDataa.allProductList[index].main_price,
                stroked_price: homeDataa.allProductList[index].stroked_price,
                has_discount: homeDataa.allProductList[index].has_discount,
                discount: homeDataa.allProductList[index].discount,
                is_wholesale:
                homeDataa.allProductList[index].isWholesale,
              ),
            );
          });
    } else if (homeDataa.totalAllProductData == 0) {
      return Center(
          child: Text(AppLocalizations.of(context).no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
  }




  Widget buildHomeFeatureProductHorizontalList(HomePresenter homeData) {
    if (homeData.isFeaturedProductInitial == true &&
        homeData.featuredProductList.length == 0) {
      return Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 64) / 3)),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 64) / 3)),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 160) / 3)),
        ],
      );
    } else if (homeData.featuredProductList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 248,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchFeaturedProducts();
              }
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.totalFeaturedProductData >
                  homeData.featuredProductList.length
                  ? homeData.featuredProductList.length + 1
                  : homeData.featuredProductList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,

              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return (index == homeData.featuredProductList.length)
                    ? SpinKitFadingFour(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    );
                  },
                )
                    : MiniProductCard(
                  id: homeData.featuredProductList[index].id,
                  image:
                  homeData.featuredProductList[index].thumbnail_image,
                  name: homeData.featuredProductList[index].name,
                  main_price:
                  homeData.featuredProductList[index].main_price,
                  stroked_price:
                  homeData.featuredProductList[index].stroked_price,
                  has_discount:
                  homeData.featuredProductList[index].has_discount,
                  is_wholesale:
                  homeData.featuredProductList[index].isWholesale,
                  discount: homeData.featuredProductList[index].discount,
                );
              },
            ),
          ),
        ),
      );
    } else {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context).no_related_product,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    }
  }

}
*/
