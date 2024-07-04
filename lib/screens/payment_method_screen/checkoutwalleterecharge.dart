
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:umonda/custom/box_decorations.dart';
import 'package:umonda/custom/btn.dart';
import 'package:umonda/custom/enum_classes.dart';
import 'package:umonda/helpers/system_config.dart';
import 'package:umonda/screens/payment_method_screen/khalti_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umonda/my_theme.dart';
import 'package:umonda/screens/order_list.dart';
import 'package:umonda/screens/payment_method_screen/stripe_screen.dart';
import 'package:umonda/screens/payment_method_screen/paypal_screen.dart';
import 'package:umonda/screens/payment_method_screen/razorpay_screen.dart';
import 'package:umonda/screens/payment_method_screen/paystack_screen.dart';
import 'package:umonda/screens/payment_method_screen/iyzico_screen.dart';
import 'package:umonda/screens/payment_method_screen/bkash_screen.dart';
import 'package:umonda/screens/payment_method_screen/nagad_screen.dart';
import 'package:umonda/screens/payment_method_screen/sslcommerz_screen.dart';
import 'package:umonda/screens/payment_method_screen/flutterwave_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:umonda/helpers/shared_value_helper.dart';
import 'package:umonda/repositories/payment_repository.dart';
import 'package:umonda/repositories/cart_repository.dart';
import 'package:umonda/repositories/coupon_repository.dart';
import 'package:umonda/helpers/shimmer_helper.dart';
import 'package:umonda/app_config.dart';
import 'package:umonda/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:umonda/screens/payment_method_screen/offline_screen.dart';
import 'package:umonda/screens/payment_method_screen/paytm_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:umonda/screens/payment_method_screen/stripe_screen_wallet_recharge.dart';

import '../../Models/withdwawalamountmodel.dart';
import '../../custom/device_info.dart';
import '../../data_model/check_response_model.dart';
import '../../data_model/order_create_response.dart';
import '../../helpers/response_check.dart';
import '../Done_Screen.dart';
import '../common_webview_screen.dart';


class Checkoutwalleterecharge extends StatefulWidget {
  int order_id; // only need when making manual payment from order details
  String list;
  //final OffLinePaymentFor offLinePaymentFor;
  final PaymentFor paymentFor;
  final double rechargeAmount;
  final String title;
  var packageId;




  Checkoutwalleterecharge(
      {Key key,
        this.order_id = 0,
        this.paymentFor,
        this.list = "both",
        //this.offLinePaymentFor,
        this.rechargeAmount =0.0,
        this.title,
        this.packageId=0
      })
      : super(key: key);

  @override
  _CheckoutwalleterechargeState createState() => _CheckoutwalleterechargeState();
}

class _CheckoutwalleterechargeState extends State<Checkoutwalleterecharge> {
  var _selected_payment_method_index = 0;
  var _selected_payment_method = "";
  var _selected_payment_method_key = "";

  ScrollController _mainScrollController = ScrollController();
  TextEditingController _couponController = TextEditingController();
  var _paymentTypeList = [];
  bool _isInitial = true;
  var _totalString = ". . .";
  var _grandTotalValue = 0.00;
  var _subTotalString = ". . .";
  var _taxString = ". . .";
  var _shippingCostString = ". . .";
  var _discountString = ". . .";
  var _used_coupon_code = "";
  var _coupon_applied = false;
  BuildContext loadingcontext;
  String payment_type = "cart_payment";
  String _title;
  bool _isAgree = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*print("user data");
    print(is_logged_in.$);
    print(access_token.value);
    print(user_id.$);
    print(user_name.$);*/

    fetchAll();
  }

  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }

  fetchAll() {
    fetchList();

    if (is_logged_in.$ == true) {
      if (widget.paymentFor != PaymentFor.Order) {
        _grandTotalValue = widget.rechargeAmount;
        payment_type = widget.paymentFor == PaymentFor.WalletRecharge?"wallet_payment":"customer_package_payment";
      } else {
        fetchSummary();
      }
    }
  }

  fetchList() async {
    var paymentTypeResponseList =
    await PaymentRepository().getPaymentResponseList(list: widget.list,mode: widget.paymentFor!=PaymentFor.Order && widget.paymentFor!= PaymentFor.ManualPayment ?"wallet":"order");
    _paymentTypeList.addAll(paymentTypeResponseList);
    if (_paymentTypeList.length > 0) {
      _selected_payment_method = _paymentTypeList[0].payment_type;
      _selected_payment_method_key = _paymentTypeList[0].payment_type_key;
    }
    _isInitial = false;
    setState(() {});
  }

  fetchSummary() async {
    var cartSummaryResponse = await CartRepository().getCartSummaryResponse();

    if (cartSummaryResponse != null) {
      _subTotalString = cartSummaryResponse.sub_total;
      _taxString = cartSummaryResponse.tax;
      _shippingCostString = cartSummaryResponse.shipping_cost;
      _discountString = cartSummaryResponse.discount;
      _totalString = cartSummaryResponse.grand_total;
      _grandTotalValue = cartSummaryResponse.grand_total_value;
      _used_coupon_code = cartSummaryResponse.coupon_code;
      _couponController.text = _used_coupon_code;
      _coupon_applied = cartSummaryResponse.coupon_applied;
      setState(() {});
    }
  }

  reset() {
    _paymentTypeList.clear();
    _isInitial = true;
    _selected_payment_method_index = 0;
    _selected_payment_method = "";
    _selected_payment_method_key = "";
    setState(() {});

    reset_summary();
  }

  reset_summary() {
    _totalString = ". . .";
    _grandTotalValue = 0.00;
    _subTotalString = ". . .";
    _taxString = ". . .";
    _shippingCostString = ". . .";
    _discountString = ". . .";
    _used_coupon_code = "";
    _couponController.text = _used_coupon_code;
    _coupon_applied = false;

    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  onPopped(value) {
    reset();
    fetchAll();
  }

  onCouponApply() async {
    var coupon_code = _couponController.text.toString();
    if (coupon_code == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).enter_coupon_code,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }

    var couponApplyResponse =
    await CouponRepository().getCouponApplyResponse(coupon_code);
    if (couponApplyResponse.result == false) {
      ToastComponent.showDialog(couponApplyResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    reset_summary();
    fetchSummary();
  }

  onCouponRemove() async {
    var couponRemoveResponse =
    await CouponRepository().getCouponRemoveResponse();

    if (couponRemoveResponse.result == false) {
      ToastComponent.showDialog(couponRemoveResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    reset_summary();
    fetchSummary();
  }

  onPressPlaceOrderOrProceed() {

    if (_selected_payment_method == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).please_choose_one_option_to_pay,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }
    if (_grandTotalValue == 0.00) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).nothing_to_pay, gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    if (_selected_payment_method == "stripe_payment") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StripeScreenWalletRecharge(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "paypal_payment") {

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PaypalScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
      ;
    } else if (_selected_payment_method == "razorpay") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RazorpayScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id:widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "paystack") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PaystackScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "iyzico") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return IyzicoScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "bkash") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BkashScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "nagad") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NagadScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "sslcommerz_payment") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SslCommerzScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    } else if (_selected_payment_method == "flutterwave") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FlutterwaveScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    }
    else if (_selected_payment_method == "paytm") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PaytmScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    }
    else if (_selected_payment_method == "khalti") {


      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return KhaltiScreen(
          amount: _grandTotalValue,
          payment_type: payment_type,
          payment_method_key: _selected_payment_method_key,
          package_id: widget.packageId.toString(),
        );
      })).then((value) {
        onPopped(value);
      });
    }

    else if (_selected_payment_method == "wallet_system") {
      pay_by_wallet();
    } else if (_selected_payment_method == "cash_payment") {
      //pay_by_cod();
      getOrderCreateResponseFromCod(_selected_payment_method);
    } else if (_selected_payment_method == "manual_payment" &&
        widget.paymentFor == PaymentFor.Order) {
      pay_by_manual_payment();
    } else if (_selected_payment_method == "manual_payment" &&
        (widget.paymentFor == PaymentFor.ManualPayment || widget.paymentFor == PaymentFor.WalletRecharge|| widget.paymentFor == PaymentFor.PackagePay)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OfflineScreen(
          order_id: widget.order_id,
          paymentInstruction: _paymentTypeList[_selected_payment_method_index].details,
          offline_payment_id: _paymentTypeList[_selected_payment_method_index].offline_payment_id,
          rechargeAmount: widget.rechargeAmount,
          offLinePaymentFor: widget.paymentFor,
          paymentMethod:_paymentTypeList[_selected_payment_method_index].name ,
          packageId: widget.packageId,
//          offLinePaymentFor: widget.offLinePaymentFor,
        );
      })).then((value) {
        onPopped(value);
      });
    }
  }







  pay_by_wallet() async {
    var orderCreateResponse = await PaymentRepository()
        .getOrderCreateResponseFromWallet(
        _selected_payment_method_key, _grandTotalValue);

    if (orderCreateResponse.result == false) {
      ToastComponent.showDialog(orderCreateResponse.message, gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderList(from_checkout: true);
    }));
  }

  // pay_by_cod() async {
  //   loading();
  //   var orderCreateResponse = await PaymentRepository()
  //       .getOrderCreateResponseFromCod(_selected_payment_method_key);
  //   Navigator.of(loadingcontext).pop();
  //
  //   if (orderCreateResponse.result == false) {
  //     ToastComponent.showDialog(orderCreateResponse.message, gravity: Toast.center, duration: Toast.lengthLong);
  //     Navigator.of(context).pop();
  //     return;
  //   }
  //
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return OrderList(from_checkout: true);
  //   }));
  // }

  bool isLoading = false;

  Future<dynamic> getOrderCreateResponseFromCod(
      _selected_payment_method_key) async {
    setState(() {
      isLoading = true;
    });

    var post_body = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "${_selected_payment_method_key}",
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/payments/pay/cod");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
      },
      body: post_body,
    );

    // Check the HTTP status code
    if (response.statusCode == 200) {
      print('Successfully submitted! govind');

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DoneScreen()));


      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return OrderList(from_checkout: true);
      // }));
    } else {
      print('Error submitting: ${response.statusCode}');
    }

    // Continue with the rest of your code
    bool checkResult = ResponseCheck.apply(response.body);

    if (!checkResult) return responseCheckModelFromJson(response.body);

    setState(() {
      isLoading = false;
    });

    return orderCreateResponseFromJson(response.body);
  }


  pay_by_manual_payment() async {
    loading();
    var orderCreateResponse = await PaymentRepository()
        .getOrderCreateResponseFromManualPayment(_selected_payment_method_key);
    Navigator.pop(loadingcontext);
    if (orderCreateResponse.result == false) {
      ToastComponent.showDialog(orderCreateResponse.message, gravity: Toast.center, duration: Toast.lengthLong);
      Navigator.of(context).pop();
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderList(from_checkout: true);
    }));
  }

  onPaymentMethodItemTap(index) {
    if (_selected_payment_method_key !=
        _paymentTypeList[index].payment_type_key) {
      setState(() {
        _selected_payment_method_index = index;
        _selected_payment_method = _paymentTypeList[index].payment_type;
        _selected_payment_method_key = _paymentTypeList[index].payment_type_key;
      });
    }

    //print(_selected_payment_method);
    //print(_selected_payment_method_key);
  }

  onPressDetails() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.only(
            top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
        content: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 16.0),
          child: Container(
            height: 150,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            AppLocalizations.of(context)
                                .subtotal_all_capital,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          SystemConfig.systemCurrency !=null?
                          _subTotalString.replaceAll(SystemConfig.systemCurrency.code, SystemConfig.systemCurrency.symbol)
                              :_subTotalString,

                          style: TextStyle(
                              color: MyTheme.font_grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            AppLocalizations.of(context)
                                .tax_all_capital,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          SystemConfig.systemCurrency !=null?
                          _taxString.replaceAll(SystemConfig.systemCurrency.code, SystemConfig.systemCurrency.symbol)
                              :_taxString,


                          style: TextStyle(
                              color: MyTheme.font_grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            AppLocalizations.of(context)
                                .shipping_cost_all_capital,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          SystemConfig.systemCurrency !=null?
                          _shippingCostString.replaceAll(SystemConfig.systemCurrency.code, SystemConfig.systemCurrency.symbol)
                              :_shippingCostString,

                          style: TextStyle(
                              color: MyTheme.font_grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            AppLocalizations.of(context)
                                .discount_all_capital,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          SystemConfig.systemCurrency !=null?
                          _discountString.replaceAll(SystemConfig.systemCurrency.code, SystemConfig.systemCurrency.symbol)
                              :_discountString,

                          style: TextStyle(
                              color: MyTheme.font_grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Divider(),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            AppLocalizations.of(context)
                                .grand_total_all_capital,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          SystemConfig.systemCurrency !=null?
                          _totalString.replaceAll(SystemConfig.systemCurrency.code, SystemConfig.systemCurrency.symbol)
                              :_totalString,

                          style: TextStyle(
                              color: MyTheme.accent_color,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        actions: [
          Btn.basic(
            child: Text(
              AppLocalizations.of(context).close_all_lower,
              style: TextStyle(color: MyTheme.medium_grey),
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),);
  }

  @override
  Widget build(BuildContext context) {



    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          bottomNavigationBar: buildBottomAppBar(context),
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
                          child: buildPaymentMethodList(),
                        ),
                        if (_selected_payment_method == "wallet_system")

                          withdrawalaccount_widget(),

                        //    Padding(
                        //     padding: const EdgeInsets.only(left: 35,right: 35),
                        //     child: Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12.0),
                        //           border: Border.all(color: Colors.black38),
                        //           // color:Color(0xffFEE572),
                        //           // boxShadow:const [
                        //           //   BoxShadow(
                        //           //     color: Colors.black,
                        //           //     blurRadius: 2.0,
                        //           //     spreadRadius: 0.0,
                        //           //     offset: Offset(2.0, 2.0,), // shadow direction: bottom right
                        //           //   )
                        //           // ],
                        //         ),
                        //         padding: EdgeInsets.only(left: 16,right: 16,top: 18,bottom: 18),
                        //         child:
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             Text("Your wallet balance:",style: TextStyle(color: Colors.grey),),
                        //             Text("AED 0.00"),
                        //
                        // ],)
                        //     ),
                        //   ),



                        if (_selected_payment_method == "cash_payment")
                        // Text("Account Details"),
                          Padding(
                            padding: const EdgeInsets.only(left: 36,right: 36),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Please initiate the payment within 3 days via bank transfer on the below mentioned account details.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),

                                SizedBox(height: 10,),
                                Text("Account Details",style: TextStyle(fontWeight: FontWeight.w600),),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Colors.black38),
                                    // color:Color(0xffFEE572),
                                    // boxShadow:const [
                                    //   BoxShadow(
                                    //     color: Colors.black,
                                    //     blurRadius: 2.0,
                                    //     spreadRadius: 0.0,
                                    //     offset: Offset(2.0, 2.0,), // shadow direction: bottom right
                                    //   )
                                    // ],
                                  ),
                                  padding: const EdgeInsets.only(left: 20,right: 10,bottom: 10,top: 10),
                                  child: Column(children: [
                                    Row(children: [
                                      Text("Name:"),
                                      SizedBox(width: 7,),
                                      Text("UMONDA LLC"),
                                    ],),
                                    Divider(),
                                    SizedBox(height: 2,),
                                    Row(children: [
                                      Text("IBAN:"),
                                      SizedBox(width: 7,),
                                      Text("AE3 2086 0000009914678051"),
                                    ],),
                                    Divider(),
                                    SizedBox(height: 2,),
                                    Row(children: [
                                      Text("BIC:"),
                                      SizedBox(width: 7,),
                                      Text("WIOBAEADXXX"),
                                    ],),
                                  ],),
                                ),
                                SizedBox(height: 40,),
                              ],
                            ),
                          ),
                        Container(
                          height: 140,
                        )

                      ]),
                    )
                  ],
                ),
              ),

              //Apply Coupon and order details container
              Align(
                alignment: Alignment.bottomCenter,
                child: widget.paymentFor == PaymentFor.WalletRecharge || widget.paymentFor == PaymentFor.PackagePay
                    ? Container()
                    : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,

                    /*border: Border(
                      top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                    )*/
                  ),
                  height:
                  widget.paymentFor == PaymentFor.ManualPayment ? 80 : 160,
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Column(
                      children: [

                        widget.paymentFor == PaymentFor.Order
                            ? Padding(
                          padding:
                          const EdgeInsets.only(bottom: 16.0),
                          child: buildApplyCouponRow(context),
                        )
                            : Container(),
                        grandTotalSection(),
                        //Text("data"),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    value: _isAgree,
                                    onChanged: (newValue) {
                                      _isAgree = newValue;
                                      setState(() {});
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  width: DeviceInfo(context).width - 130,
                                  child: RichText(
                                      maxLines: 2,
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: MyTheme.font_grey, fontSize: 12),
                                          children: [
                                            TextSpan(
                                              text: "I agree to the",
                                            ),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CommonWebviewScreen(
                                                                page_name:
                                                                "Terms Conditions",
                                                                url:
                                                                //"https://umonm.com/",
                                                                "${AppConfig.RAW_BASE_URL}/mobile-page/terms",
                                                              )));
                                                },
                                              style:
                                              TextStyle(color: MyTheme.accent_color),
                                              text: " Terms Conditions",
                                            ),
                                            TextSpan(
                                              text: " &",
                                            ),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CommonWebviewScreen(
                                                                page_name:
                                                                "Privacy Policy",
                                                                url:
                                                                "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
                                                              )));
                                                },
                                              text: " Privacy Policy",
                                              style:
                                              TextStyle(color: MyTheme.accent_color),
                                            )
                                          ])),
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),


              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),

            ],
          )),
    );
  }

  Row buildApplyCouponRow(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 42,
          width: (MediaQuery.of(context).size.width - 32) * (2 / 3),
          child: TextFormField(
            controller: _couponController,
            readOnly: _coupon_applied,
            autofocus: false,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)
                    .enter_coupon_code,
                hintStyle:
                TextStyle(fontSize: 14.0, color: MyTheme.textfield_grey),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: MyTheme.textfield_grey, width: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    bottomLeft: const Radius.circular(8.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: MyTheme.medium_grey, width: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(8.0),
                    bottomLeft: const Radius.circular(8.0),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 16.0)),
          ),
        ),
        !_coupon_applied
            ? Container(
          width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
          height: 42,
          child: Btn.basic(
            minWidth: MediaQuery.of(context).size.width,

            color: MyTheme.accent_color,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.only(
                  topRight: const Radius.circular(8.0),
                  bottomRight: const Radius.circular(8.0),
                )),
            child: Text(
              AppLocalizations.of(context).apply_coupon_all_capital,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              onCouponApply();
            },
          ),
        )
            : Container(
          width: (MediaQuery.of(context).size.width - 32) * (1 / 3),
          height: 42,
          child: Btn.basic(
            minWidth: MediaQuery.of(context).size.width,
            color: MyTheme.accent_color,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.only(
                  topRight: const Radius.circular(8.0),
                  bottomRight: const Radius.circular(8.0),
                )),
            child: Text(
              AppLocalizations.of(context).remove_ucf                    ,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              onCouponRemove();
            },
          ),
        )
      ],
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
        widget.title,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildPaymentMethodList() {
    if (_isInitial && _paymentTypeList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_paymentTypeList.length > 0) {
      return SingleChildScrollView(
        child: ListView.separated(
          separatorBuilder: (context,index){
            return SizedBox(height: 14,);
          },
          itemCount: _paymentTypeList.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: buildPaymentMethodItemCard(index),
            );
          },
        ),
      );
    } else if (!_isInitial && _paymentTypeList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context).no_payment_method_is_added,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    }
  }

  GestureDetector buildPaymentMethodItemCard(index) {
    return GestureDetector(
      onTap: () {
        onPaymentMethodItemTap(index);
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            decoration: BoxDecorations.buildBoxDecoration_1().copyWith(
                border: Border.all(
                    color:_selected_payment_method_key ==
                        _paymentTypeList[index].payment_type_key? MyTheme.accent_color:MyTheme.light_grey,
                    width: _selected_payment_method_key ==
                        _paymentTypeList[index].payment_type_key?2.0:0.0)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 100,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                          /*Image.asset(
                          _paymentTypeList[index].image,
                          fit: BoxFit.fitWidth,
                        ),*/
                          FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: _paymentTypeList[index].payment_type ==
                                "manual_payment"
                                ?
                            _paymentTypeList[index].image
                                : _paymentTypeList[index].image,
                            fit: BoxFit.fitWidth,
                          ))),
                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            _paymentTypeList[index].title,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: MyTheme.font_grey,
                                fontSize: 14,
                                height: 1.6,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: buildPaymentMethodCheckContainer(
                _selected_payment_method_key ==
                    _paymentTypeList[index].payment_type_key),
          )
        ],
      ),
    );
  }

  Widget buildPaymentMethodCheckContainer(bool check) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 400),
      opacity: check?1:0,
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Icon(FontAwesome.check, color: Colors.white, size: 10),
        ),
      ),
    );
    /* Visibility(
      visible: check,
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Icon(FontAwesome.check, color: Colors.white, size: 10),
        ),
      ),
    );*/



  }




  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Btn.minWidthFixHeight(
              minWidth: MediaQuery.of(context).size.width,
              height: 50,
              color: MyTheme.accent_color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Text(
                AppLocalizations.of(context).recharge_wallet_ucf,

                // widget.paymentFor == PaymentFor.WalletRecharge
                //     ? AppLocalizations.of(context)
                //     .recharge_wallet_ucf
                //     : widget.paymentFor == PaymentFor.ManualPayment
                //     ? AppLocalizations.of(context)
                //     .proceed_all_caps
                //     :widget.paymentFor == PaymentFor.PackagePay
                //     ? AppLocalizations.of(context)
                //     .buy_package_ucf
                //     : AppLocalizations.of(context)
                //     .place_my_order_all_capital,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              // onPressed: () {
              //   onPressPlaceOrderOrProceed();
              // },

              onPressed: _isAgree
                  ? () {
                onPressPlaceOrderOrProceed();
              }
                  : null,

            )
          ],
        ),
      ),
    );
  }


  Widget grandTotalSection(){
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: MyTheme.soft_accent_color),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(left: 16.0),
              child: Text(
                AppLocalizations.of(context)
                    .total_amount_ucf,
                style: TextStyle(
                    color: MyTheme.font_grey,
                    fontSize: 14),
              ),
            ),
            Visibility(
              visible: widget.paymentFor != PaymentFor.ManualPayment,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 8.0),
                child: InkWell(
                  onTap: () {
                    onPressDetails();
                  },
                  child: Text(
                    AppLocalizations.of(context)
                        .see_details_all_lower,
                    style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 12,
                      decoration:
                      TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding:
              const EdgeInsets.only(right: 16.0),
              child: Text(widget.paymentFor == PaymentFor.ManualPayment?widget.rechargeAmount.toString():SystemConfig.systemCurrency !=null?
              _totalString.replaceAll(SystemConfig.systemCurrency.code, SystemConfig.systemCurrency.symbol)
                  :_totalString,
                  style: TextStyle(
                      color: MyTheme.accent_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  loading() {
    showDialog(
        context: context,
        builder: (context) {
          loadingcontext = context;
          return AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${AppLocalizations.of(context).please_wait_ucf}"),
                ],
              ));
        });
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

}


