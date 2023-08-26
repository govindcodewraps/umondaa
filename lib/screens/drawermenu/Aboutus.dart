import 'package:flutter/material.dart';


class Aboutus extends StatelessWidget {
  //const Aboutus({super.key});

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
              children: [
                Container(
                  child: Image.asset('assets/appbarlogo.png',
                    height: 70,
                    width: 100,),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("At UMONDA, we create pathways to connect sellers and buyers within the UAE. We are offering a platform to our users, which strives to simplify the selling and buying process of pre-owned goods and items with taking care of pickup and delivery, even dismantling and assembly, if needed.",
                      style: TextStyle(fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("Our aim is to assist our users in a better and more convenient way, through following features:",
                      style: TextStyle(fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("1. Buy and Sell with just one click: No bargaining phone calls, no personal house visits etc.",
                      style: TextStyle(fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("2. Sell at fixed price: Buyer accepts price of seller, and can buy instantly ('buy now').",
                      style: TextStyle(fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("3. Make an offer: Give the buyer the option to offer a certain purchase price, and sell within the seller's set minimum selling price.",
                      style: TextStyle(fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("4. Free Delivery: Delivery or shipping cost are included in the purchase price and commission paid by buyer and seller on each transaction.",
                      style: TextStyle(fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 60),
                  child: Text.rich(TextSpan(
                      children: [
                        TextSpan(text: '5. Dismantling and Assembly: When selling and buying furniture for instance, for an optional extra charge of AED 100,', style: TextStyle(fontSize: 20)),
                        TextSpan(text: 'UMONDA LLC will take care of dismantling and assembling the item at each respective location.', style: TextStyle(fontSize: 20)),
                      ]
                  ),
                  ),
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

            child: Text('About us',
              style: TextStyle(color:  Colors.black,),
            ),
          )

        ],
      ),
    );
  }

}