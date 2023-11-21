import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:umonda/app_config.dart';
import 'package:umonda/custom/toast_component.dart';
import 'package:umonda/helpers/shared_value_helper.dart';
import 'package:umonda/my_theme.dart';
import 'package:umonda/repositories/payment_repository.dart';
import 'package:umonda/screens/order_list.dart';
import 'package:umonda/screens/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../common_webview_screen.dart';

class StripeScreen extends StatefulWidget {
  double amount;
  String payment_type;
  String payment_method_key;
  String package_id;


  StripeScreen(
      {Key key,
      this.amount = 0.00,
      this.payment_type = "",
      this.payment_method_key = "",
      this.package_id = "0"})
      : super(key: key);

  @override
  _StripeScreenState createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  int _combined_order_id = 0;
  bool _order_init = false;
  //String initial_url;

  WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.payment_type == "cart_payment") {
      createOrder();
    }
      stripe();

    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::");
    print("Amountt : ${widget.amount}");
    print("payment_typee :  ${widget.payment_type}");
    print("payment_method_keyy :  ${widget.payment_method_key}");
    print("package_idd : ${widget.package_id}");
    print("_combined_order_id : ${_combined_order_id}");
    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::");
   // print(initial_url);
    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::");


  }

  stripe() {
    String  _initial_url =

       //"https://webcluestechnology.com/demo/erp/umonda/api/v2/stripe?payment_type=${widget.payment_type}&combined_order_id=${_combined_order_id}&amount=${widget.amount}&user_id=${user_id.$}";
       // "https://webcluestechnology.com/demo/erp/umonda/api/v2/stripe?payment_type=cart_payment&order_id=444&amount=1200&user_id=198";
        "${AppConfig.BASE_URL}/stripe?payment_type=cart_payment&order_id=${_combined_order_id}&amount=${widget.amount}&user_id=${user_id.$}";

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      // ..setNavigationDelegate(
      //   NavigationDelegate(
      //     onPageStarted: (controller) {
      //       _webViewController.loadRequest(Uri.parse(_initial_url));
      //     },
      //     onWebResourceError: (error) {},
      //     onPageFinished: (page) {
      //       if (page.contains("/stripe/success")) {
      //         getData();
      //       } else if (page.contains("/stripe/cancel")) {
      //         ToastComponent.showDialog(
      //             AppLocalizations.of(context).payment_cancelled_ucf,
      //             gravity: Toast.center,
      //             duration: Toast.lengthLong);
      //         Navigator.of(context).pop();
      //         return;
      //       }
      //     },
      //   ),
      // );
      ..loadRequest(Uri.parse(_initial_url)
      );
  }

  createOrder() async {
    var orderCreateResponse = await PaymentRepository()
        .getOrderCreateResponse(widget.payment_method_key);
//  "owner_id":176,
//     "user_id":198,
//     "payment_type": "stripe"
    if (orderCreateResponse.result == false) {
      ToastComponent.showDialog(orderCreateResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
      Navigator.of(context).pop();
      return;
    }

    _combined_order_id = orderCreateResponse.combined_order_id;
    _order_init = true;
    setState(() {
      print("Done Done Done ");
      stripe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: buildBody(),
      ),
    );
  }

  void getData() {
    _webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      // var decodedJSON = jsonDecode(data);
      var responseJSON = jsonDecode(data);
      if (responseJSON.runtimeType == String) {
        responseJSON = jsonDecode(responseJSON);
      }
      //print(data.toString());
      if (responseJSON["result"] == false) {
        Toast.show(responseJSON["message"],
            duration: Toast.lengthLong, gravity: Toast.center);
        Navigator.pop(context);
      } else if (responseJSON["result"] == true) {
        Toast.show(responseJSON["message"],
            duration: Toast.lengthLong, gravity: Toast.center);
        if (widget.payment_type == "cart_payment") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OrderList(from_checkout: true);
          }));
        } else if (widget.payment_type == "wallet_payment") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Wallet(from_recharge: true);
          }));
        }
      }
    });
  }

  buildBody() {
    //print("init url");
    //print(_initial_url);

    if (_order_init == false &&
        _combined_order_id == 0 &&
        widget.payment_type == "cart_payment") {
      return Container(
        child: Center(
          child: Text(AppLocalizations.of(context).creating_order),
        ),
      );
    } else {
      return SingleChildScrollView(
        child:
            // Column(
            //   children: [
            //     Text("data"),
            //     Text("data"),
            //     Text("data"),
            //     Text("data"),
            //     Text("data"),
            //   ],
            // )




        // RichText(
        //   maxLines: 2,
        //   text:
        //   TextSpan(
        //     recognizer: TapGestureRecognizer()
        //       ..onTap = () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) =>
        //                     CommonWebviewScreen(
        //                       page_name:
        //                       "Shipping & Delivery",
        //                       url:
        //                       //"https://umonm.com/",
        //
        //                       "${AppConfig.RAW_BASE_URL}/mobile-page/terms",
        //                     )));
        //       },
        //     style:
        //     TextStyle(color: MyTheme.accent_color),
        //     text: " Shipping & Delivery",
        //   ),
        // ),






        Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,

         // width: 500,
          //height: 500,
          child: WebViewWidget(
            controller: _webViewController,
          ),
        ),
      );
    }
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
        AppLocalizations.of(context).pay_with_stripe,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
