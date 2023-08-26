import 'package:flutter/material.dart';


class ShippingDelivery extends StatelessWidget {
  //const ShippingDelivery({super.key});

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        // child: Container(
        //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        //   height: 700,
        //
        //   child: Column(

        children: [
          Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 5),
            child: Image.asset('assets/appbarlogo.png',
              height: 70,
              width: 100,),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("What are the delivery charges?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Delivery and shipping is free, and paid by the buyer through 5% commission on purchase price.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Why does the delivery date not correspond to the delivery timeline of X-Y business days?",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("It is possible that the Seller or our courier partners have a holiday on the day you placed your order and the date of delivery. In this case, we add a day to the estimated date. Some courier partners and Sellers do not work or are not available on certain days.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("What is the estimated delivery time?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Sellers generally procure and ship the items as soon as possible. Business days exclude public holidays and Sundays.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Estimated delivery time depends on the following factors:",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("The Seller offers the product.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Product's availability with the Seller.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("The destination to which you want the order to be shipped to, and the location of the Seller.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("There are no hidden delivery charges.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Why does the estimated delivery time vary for each seller?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("You have probably noticed varying estimated delivery times for sellers of the product you are interested in. Delivery times are influenced by seller's availability, geographic location of the Seller, your shipping destination and the courier partner's time-to-deliver to your location.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("I need to return an item, how do I arrange for a pick-up?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Returns are excluded for used and pre-owned items. ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("For returns on new products, contact us to initiate a return. You will receive a call explaining the process, once you have initiated a return.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("Whenever possible our courier partner will facilitate the pick-up of the item. In case, the pick-up cannot be arranged, you can return the item through a third-party courier service. Return fees are paid by the Seller.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text("I did not receive my order but got a delivery confirmation SMS/Email.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 60),
            child: Text("In case the product was not delivered and you have received a delivery confirmation email/SMS, kindly report this issue to us within 7 days from the date of delivery confirmation.",
                style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),

        ],
      ),

    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color.fromARGB(240, 243, 237, 237),
      title: buildAppBarTitleOption(context),
      elevation: 0.0,
      titleSpacing: 0,

    );
  }

  // Widget buildAppBarTitle(BuildContext context) {
  //   return AnimatedCrossFade(
  //       firstChild: buildAppBarTitleOption(context)
  //   );
  // }

  Widget buildAppBarTitleOption(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Container(
            width: 20,
            // child: UsefulElements.backButton(context, color: "white"),
          ),
          Container(
            padding: EdgeInsets.only(left: 0),

            child: Text('Shipping & Delivery',
              style: TextStyle(color:  Colors.black,),
            ),
          )

        ],
      ),
    );
  }

}