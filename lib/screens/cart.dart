import 'package:umonda/custom/box_decorations.dart';
import 'package:umonda/custom/btn.dart';
import 'package:umonda/custom/common_functions.dart';
import 'package:umonda/custom/device_info.dart';
import 'package:umonda/custom/text_styles.dart';
import 'package:umonda/custom/useful_elements.dart';
import 'package:umonda/helpers/system_config.dart';
import 'package:umonda/presenter/cart_counter.dart';
import 'package:umonda/screens/select_address.dart';
import 'package:umonda/screens/shipping_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umonda/my_theme.dart';
import 'package:umonda/ui_sections/drawer.dart';
import 'package:flutter/widgets.dart';
import 'package:umonda/repositories/cart_repository.dart';
import 'package:umonda/helpers/shared_value_helper.dart';
import 'package:umonda/helpers/shimmer_helper.dart';
import 'package:umonda/custom/toast_component.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:umonda/custom/common_functions.dart';

class Cart extends StatefulWidget {
  Cart({Key key, this.has_bottomnav,this.from_navigation = false, this.counter}) : super(key: key);
  final bool has_bottomnav;
  final bool from_navigation;
  final CartCounter counter;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _mainScrollController = ScrollController();
  var _shopList = [];
  bool _isInitial = true;
  var _cartTotal = 0.00;
  var _cartTotalString = ". . .";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*print("user data");
    print(is_logged_in.$);
    print(access_token.value);
    print(user_id.$);
    print(user_name.$);*/

    if (is_logged_in.$ == true) {
      fetchData();
    }
  }


  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }


  getCartCount() {
    Provider.of<CartCounter>(context, listen: false).getCount();
    // var res = await CartRepository().getCartCount();
   // widget.counter.controller.sink.add(res.count);
  }

  fetchData() async {
    getCartCount();
    var cartResponseList =
        await CartRepository().getCartResponseList(user_id.$);

    if (cartResponseList != null && cartResponseList.length > 0) {
      _shopList = cartResponseList;
    }
    _isInitial = false;
    getSetCartTotal();
    setState(() {});
  }

  getSetCartTotal() {
    _cartTotal = 0.00;
    if (_shopList.length > 0) {
      _shopList.forEach((shop) {
        if (shop.cart_items.length > 0) {
          shop.cart_items.forEach((cart_item) {
            _cartTotal += double.parse(
                ((cart_item.price + cart_item.tax) * cart_item.quantity)
                    .toStringAsFixed(2));
            _cartTotalString =
                "${SystemConfig.systemCurrency.symbol}${_cartTotal.toStringAsFixed(2)}";
          });
        }
      });
    }

    setState(() {});
  }

  partialTotalString(index) {
    var partialTotal = 0.00;
    var partialTotalString = "";
    if (_shopList[index].cart_items.length > 0) {
      _shopList[index].cart_items.forEach((cart_item) {
        partialTotal += (cart_item.price + cart_item.tax) * cart_item.quantity;
        partialTotalString =
            "${SystemConfig.systemCurrency.symbol}${partialTotal.toStringAsFixed(2)}";
      });
    }

    return partialTotalString;
  }

  // onQuantityIncrease(seller_index, item_index) {
  //   if (_shopList[seller_index].cart_items[item_index].quantity <
  //       _shopList[seller_index].cart_items[item_index].upper_limit) {
  //     _shopList[seller_index].cart_items[item_index].quantity++;
  //     getSetCartTotal();
  //     setState(() {});
  //   } else {
  //     ToastComponent.showDialog(
  //         "${AppLocalizations.of(context).cannot_order_more_than} ${_shopList[seller_index].cart_items[item_index].upper_limit} ${AppLocalizations.of(context).items_of_this_all_lower}",
  //         gravity: Toast.center,
  //         duration: Toast.lengthLong);
  //   }
  // }
  //
  // onQuantityDecrease(seller_index, item_index) {
  //   if (_shopList[seller_index].cart_items[item_index].quantity >
  //       _shopList[seller_index].cart_items[item_index].lower_limit) {
  //     _shopList[seller_index].cart_items[item_index].quantity--;
  //     getSetCartTotal();
  //     setState(() {});
  //   } else {
  //     ToastComponent.showDialog(
  //         "${AppLocalizations.of(context).cannot_order_more_than} ${_shopList[seller_index].cart_items[item_index].lower_limit} ${AppLocalizations.of(context).items_of_this_all_lower}",
  //         gravity: Toast.center,
  //         duration: Toast.lengthLong);
  //   }
  // }

  onPressDelete(cart_id) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.only(
                  top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  AppLocalizations.of(context).are_you_sure_to_remove_this_item,
                  maxLines: 3,
                  style: TextStyle(color: MyTheme.font_grey, fontSize: 14),
                ),
              ),
              actions: [
                Btn.basic(
                  child: Text(
                    AppLocalizations.of(context).cancel_ucf,
                    style: TextStyle(color: MyTheme.medium_grey),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
                Btn.basic(
                  color: MyTheme.soft_accent_color,
                  child: Text(
                    AppLocalizations.of(context).confirm_ucf,
                    style: TextStyle(color: MyTheme.dark_grey),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    confirmDelete(cart_id);
                  },
                ),
              ],
            ));
  }

  confirmDelete(cart_id) async {
    var cartDeleteResponse =
        await CartRepository().getCartDeleteResponse(cart_id);

    if (cartDeleteResponse.result == true) {
      ToastComponent.showDialog(cartDeleteResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);

      reset();
      fetchData();
    } else {
      ToastComponent.showDialog(cartDeleteResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }

  onPressUpdate() {
    process(mode: "update");
  }

  onPressProceedToShipping() {
    process(mode: "proceed_to_shipping");
  }

  process({mode}) async {
    var cart_ids = [];
    var cart_quantities = [];
    if (_shopList.length > 0) {
      _shopList.forEach((shop) {
        if (shop.cart_items.length > 0) {
          shop.cart_items.forEach((cart_item) {
            cart_ids.add(cart_item.id);
            cart_quantities.add(cart_item.quantity);
          });
        }
      });
    }

    if (cart_ids.length == 0) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).cart_is_empty,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }

    var cart_ids_string = cart_ids.join(',').toString();
    var cart_quantities_string = cart_quantities.join(',').toString();

    print(cart_ids_string);
    print(cart_quantities_string);

    var cartProcessResponse = await CartRepository()
        .getCartProcessResponse(cart_ids_string, cart_quantities_string);

    if (cartProcessResponse.result == false) {
      ToastComponent.showDialog(cartProcessResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
    } else {
      ToastComponent.showDialog(cartProcessResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);

      if (mode == "update") {
        reset();
        fetchData();
      } else if (mode == "proceed_to_shipping") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SelectAddress();
        })).then((value) {
          onPopped(value);
        });
      }
    }
  }

  reset() {
    _shopList = [];
    _isInitial = true;
    _cartTotal = 0.00;
    _cartTotalString = ". . .";

    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchData();
  }

  onPopped(value) async {
    reset();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          //drawer: MainDrawer(),
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                onRefresh: _onRefresh,
                displacement: 0,
                child: CustomScrollView(
                  controller: _mainScrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: buildCartSellerList(),
                        ),
                        Container(
                          height: widget.has_bottomnav ? 140 : 100,
                        )
                      ]),
                    )
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: buildBottomContainer(),
              // )
            ],
          )),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
      ),

      //height: widget.has_bottomnav ? 200 : 120,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 4),
        child: Column(
          children: [
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: MyTheme.soft_accent_color),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      AppLocalizations.of(context).total_amount_ucf,
                      style:
                          TextStyle(color: MyTheme.dark_font_grey, fontSize: 13,fontWeight: FontWeight.w700),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("$_cartTotalString",
                        style: TextStyle(
                            color: MyTheme.accent_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Container(
                //     width: (MediaQuery.of(context).size.width - 48) * (1 / 3),
                //     height: 58,
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         // border:
                //         //     Border.all(color: MyTheme.accent_color, width: 1),
                //         borderRadius: app_language_rtl.$
                //             ? const BorderRadius.only(
                //                 topLeft: const Radius.circular(0.0),
                //                 bottomLeft: const Radius.circular(0.0),
                //                 topRight: const Radius.circular(6.0),
                //                 bottomRight: const Radius.circular(6.0),
                //               )
                //             : const BorderRadius.only(
                //                 topLeft: const Radius.circular(6.0),
                //                 bottomLeft: const Radius.circular(6.0),
                //                 topRight: const Radius.circular(0.0),
                //                 bottomRight: const Radius.circular(0.0),
                //               )),
                //     child: Btn.basic(
                //       minWidth: MediaQuery.of(context).size.width,
                //       color: MyTheme.soft_accent_color,
                //       shape: app_language_rtl.$
                //           ? RoundedRectangleBorder(
                //               borderRadius: const BorderRadius.only(
                //               topLeft: const Radius.circular(0.0),
                //               bottomLeft: const Radius.circular(0.0),
                //               topRight: const Radius.circular(6.0),
                //               bottomRight: const Radius.circular(6.0),
                //             ))
                //           : RoundedRectangleBorder(
                //               borderRadius: const BorderRadius.only(
                //               topLeft: const Radius.circular(6.0),
                //               bottomLeft: const Radius.circular(6.0),
                //               topRight: const Radius.circular(0.0),
                //               bottomRight: const Radius.circular(0.0),
                //             )),
                //       child: Text(
                //         AppLocalizations.of(context).update_cart_ucf,
                //         style: TextStyle(
                //             color: MyTheme.dark_font_grey,
                //             fontSize: 13,
                //             fontWeight: FontWeight.w700),
                //       ),
                //       onPressed: () {
                //         onPressUpdate();
                //       },
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 55,
                    width: (MediaQuery.of(context).size.width - 50) * (1),

                    //width: (MediaQuery.of(context).size.width - 48) * (2 / 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: MyTheme.accent_color, width: 0),
                        borderRadius: app_language_rtl.$
                            ? const BorderRadius.only(
                                topLeft: const Radius.circular(6.0),
                                bottomLeft: const Radius.circular(6.0),
                                topRight: const Radius.circular(6.0),
                                bottomRight: const Radius.circular(6.0),
                              )
                            : const BorderRadius.only(
                                topLeft: const Radius.circular(6.0),
                                bottomLeft: const Radius.circular(6.0),
                                topRight: const Radius.circular(6.0),
                                bottomRight: const Radius.circular(6.0),
                              )),
                    child: Btn.basic(
                      minWidth: MediaQuery.of(context).size.width,

                      color: MyTheme.accent_color,
                      shape: app_language_rtl.$
                          ? RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(6.0),
                              bottomLeft: const Radius.circular(6.0),
                              topRight: const Radius.circular(6.0),
                              bottomRight: const Radius.circular(6.0),
                            ))
                          : RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(6.0),
                              bottomLeft: const Radius.circular(6.0),
                              topRight: const Radius.circular(6.0),
                              bottomRight: const Radius.circular(6.0),
                            )),
                      child: Text(
                        AppLocalizations.of(context)
                            .proceed_to_shipping_ucf,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        onPressProceedToShipping();
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) =>
            widget.from_navigation ? UsefulElements.backToMain(context, go_back: false) : UsefulElements.backButton(context),
      ),
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

  buildCartSellerList() {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).please_log_in_to_see_the_cart_items,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else if (_isInitial && _shopList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_shopList.length > 0) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 26,
              ),
              itemCount: _shopList.length,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 12.0),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         _shopList[index].name,
                    //         style: TextStyle(
                    //             color: MyTheme.dark_font_grey,
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 12),
                    //       ),
                    //       Spacer(),
                    //       Text(
                    //
                    //         partialTotalString(index),
                    //         style: TextStyle(
                    //             color: MyTheme.accent_color,
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 12),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    buildCartSellerItemList(index),

                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: buildBottomContainer(),
                    // )

                  ],
                );
              },
            ),


            Padding(
              padding:  EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: buildBottomContainer(),
              ),
            ),

          ],
        ),
      );
    } else if (!_isInitial && _shopList.length == 0) {
      return Container(
        padding: EdgeInsets.only(top: 90),
          height: 400,
          child: Column(
            children: [

              Icon(Icons.shopping_cart,size: 77,color: MyTheme.font_grey,),

              Center(
                  child: Text(
                AppLocalizations.of(context).cart_is_empty,
                style: TextStyle(color: MyTheme.font_grey),
              )),


              //Image.asset("assets/icons/wishicon.png"),
            ],
          ));
    }
  }

  SingleChildScrollView buildCartSellerItemList(seller_index) {
    return SingleChildScrollView(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 14,
        ),
        itemCount: _shopList[seller_index].cart_items.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return buildCartSellerItemCard(seller_index, index);
        },
      ),
    );
  }

  buildCartSellerItemCard(seller_index, item_index) {
    return Container(
      height: 120,
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: DeviceInfo(context).width/2.5,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                        //left: Radius.circular(6), right: Radius.zero),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/placeholder.png',
                      image: _shopList[seller_index]
                          .cart_items[item_index]
                          .product_thumbnail_image,
                      fit: BoxFit.cover,
                    ))),
            Container(
              //color: Colors.red,
              width: DeviceInfo(context).width/3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _shopList[seller_index]
                          .cart_items[item_index]
                          .product_name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23.0),
                      child: Row(
                        children: [
                          Text(
                            SystemConfig.systemCurrency.symbol+
                                (_shopList[seller_index]
                                            .cart_items[item_index]
                                            .price *
                                        _shopList[seller_index]
                                            .cart_items[item_index]
                                            .quantity)
                                    .toStringAsFixed(2),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: MyTheme.accent_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 32,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      onPressDelete(
                          _shopList[seller_index].cart_items[item_index].id);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: Image.asset(
                          'assets/trash.png',
                          height: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

         /*   Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      onQuantityIncrease(seller_index, item_index);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration:
                          BoxDecorations.buildCartCircularButtonDecoration(),
                      child: Icon(
                        Icons.add,
                        color: MyTheme.accent_color,
                        size: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      _shopList[seller_index]
                          .cart_items[item_index]
                          .quantity
                          .toString(),
                      style:
                          TextStyle(color: MyTheme.accent_color, fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onQuantityDecrease(seller_index, item_index);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration:
                          BoxDecorations.buildCartCircularButtonDecoration(),
                      child: Icon(
                        Icons.remove,
                        color: MyTheme.accent_color,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )*/

          ]),
    );
  }
}
