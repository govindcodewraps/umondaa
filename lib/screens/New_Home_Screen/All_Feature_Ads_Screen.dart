import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:provider/provider.dart";

import '../../helpers/shared_value_helper.dart';
import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/all_mini_product_card.dart';
import '../../ui_elements/mini_product_card.dart';
import '../../ui_elements/product_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:umonda/custom/useful_elements.dart';


import 'new_home_presenter.dart';

class All_feature_ads_Screen extends StatefulWidget {
  //const Allnewads_Screen({super.key});

  @override
  State<All_feature_ads_Screen> createState() => _All_feature_ads_ScreenState();
}

class _All_feature_ads_ScreenState extends State<All_feature_ads_Screen> {
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
    return Consumer<HomePresenter>(builder: (context, homeData, child)
   // return Consumer<AllHomePresenter>(builder: (context, homeData, child)
    {
      return Scaffold
        (
        appBar: buildAppBar(context),
        body: Column(children: [
          // buildHomeAllProducts20(context, homeDataa),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildHomeFeatureProductHorizontalList(
                      homeData),
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

  Widget buildHomeFeatureProductHorizontalList(HomePresenter homeData) {
    if (homeData.isFeaturedProductInitial == true &&
        homeData.featuredProductList.length == 0) {
      return Column(
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
    } else
      if (homeData.featuredProductList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height*1,
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
                height: 18,
              ),
              itemCount: homeData.totalFeaturedProductData >
                  homeData.featuredProductList.length
                  ? homeData.featuredProductList.length + 1
                  : homeData.featuredProductList.length,
              scrollDirection: Axis.vertical,
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
                    : AllMiniProductCard(
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
