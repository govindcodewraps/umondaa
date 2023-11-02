// import 'dart:convert';
//
// import 'package:hardware_lo/custom/toast_component.dart';
// import 'package:hardware_lo/helpers/shared_value_helper.dart';
// import 'package:hardware_lo/my_theme.dart';
// import 'package:hardware_lo/repositories/payment_repository.dart';
// import 'package:hardware_lo/screens/order_list.dart';
// import 'package:hardware_lo/screens/wallet.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class FlutterwaveScreen extends StatefulWidget {
//   double amount;
//   String payment_type;
//   String payment_method_key;
//   var package_id;
//
//   FlutterwaveScreen(
//       {Key key,
//       this.amount = 0.00,
//       this.payment_type = "",
//       this.package_id = "0",
//       this.payment_method_key = ""})
//       : super(key: key);
//
//   @override
//   _FlutterwaveScreenState createState() => _FlutterwaveScreenState();
// }
//
// class _FlutterwaveScreenState extends State<FlutterwaveScreen> {
//   int _combined_order_id = 0;
//   bool _order_init = false;
//   String _initial_url = "";
//   bool _initial_url_fetched = false;
//
//   WebViewController _webViewController = WebViewController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     if (widget.payment_type == "cart_payment") {
//       createOrder();
//     }
//
//     if (widget.payment_type != "cart_payment") {
//       // on cart payment need proper order id
//       getSetInitialUrl();
//     }
//   }
//
//   createOrder() async {
//     var orderCreateResponse = await PaymentRepository()
//         .getOrderCreateResponse(widget.payment_method_key);
//
//     if (orderCreateResponse.result == false) {
//       ToastComponent.showDialog(orderCreateResponse.message,
//           gravity: Toast.center, duration: Toast.lengthLong);
//       Navigator.of(context).pop();
//       return;
//     }
//
//     _combined_order_id = orderCreateResponse.combined_order_id;
//     _order_init = true;
//     setState(() {});
//
//     getSetInitialUrl();
//   }
//
//   getSetInitialUrl() async {
//     var flutterwaveUrlResponse = await PaymentRepository()
//         .getFlutterwaveUrlResponse(widget.payment_type, _combined_order_id,
//             widget.package_id, widget.amount);
//
//     if (flutterwaveUrlResponse.result == false) {
//       ToastComponent.showDialog(flutterwaveUrlResponse.message,
//           gravity: Toast.center, duration: Toast.lengthLong);
//       Navigator.of(context).pop();
//       return;
//     }
//
//     _initial_url = flutterwaveUrlResponse.url;
//     _initial_url_fetched = true;
//
//     setState(() {});
//
//     flutter_wave();
//     //print(_initial_url);
//     //print(_initial_url_fetched);
//   }
//
//   flutter_wave() {
//     _webViewController
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           // onPageStarted: (controller) {
//           //   _webViewController.loadRequest(Uri.parse(_initial_url));
//           // },
//           onWebResourceError: (error) {},
//           onPageFinished: (page) {
//             //print(page.toString());
//
//             if (page.contains("/flutterwave/payment/callback")) {
//               getData();
//             }
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(_initial_url));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: buildAppBar(context),
//         body: buildBody(),
//       ),
//     );
//   }
//
//   void getData() {
//     _webViewController
//         .runJavaScriptReturningResult("document.body.innerText")
//         .then((data) {
//       // var decodedJSON = jsonDecode(data);
//       var responseJSON = jsonDecode(data);
//       if (responseJSON.runtimeType == String) {
//         responseJSON = jsonDecode(responseJSON);
//       }
//       //print(data.toString());
//       if (responseJSON["result"] == false) {
//         Toast.show(responseJSON["message"],
//             duration: Toast.lengthLong, gravity: Toast.center);
//         Navigator.pop(context);
//       } else if (responseJSON["result"] == true) {
//         Toast.show(responseJSON["message"],
//             duration: Toast.lengthLong, gravity: Toast.center);
//
//         if (widget.payment_type == "cart_payment") {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return OrderList(from_checkout: true);
//           }));
//         } else if (widget.payment_type == "wallet_payment") {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return Wallet(from_recharge: true);
//           }));
//         }
//       }
//     });
//   }
//
//   buildBody() {
//     if (_order_init == false &&
//         _combined_order_id == 0 &&
//         widget.payment_type == "cart_payment") {
//       return Container(
//         child: Center(
//           child: Text("Creating order ..."),
//         ),
//       );
//     } else if (_initial_url_fetched == false) {
//       return Container(
//         child: Center(
//           child: Text("Fetching Flutterwave url ..."),
//         ),
//       );
//     } else {
//       return SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: WebViewWidget(
//             controller: _webViewController,
//           ),
//         ),
//       );
//     }
//   }
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       centerTitle: true,
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: Icon(CupertinoIcons.arrow_left, color: MyTheme.dark_grey),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       title: Text(
//         "Pay with Flutterwave",
//         style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
//       ),
//       elevation: 0.0,
//       titleSpacing: 0,
//     );
//   }
// }
