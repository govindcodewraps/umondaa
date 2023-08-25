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
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Color.fromARGB(255, 2, 70, 40),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('About us',
          style: TextStyle(color:  Color.fromARGB(255, 255, 255, 255)),),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 700,

          child: Column(

            children: [
              Container(
                child: Image.asset('assets/topbarlogo1.png',
                  height: 20,
                  width: 50,),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("At UMONDA, we create pathways to connect sellers and buyers within the UAE. We are offering a platform to our users, which strives to simplify the selling and buying process of pre-owned goods and items with taking care of pickup and delivery, even dismantling and assembly, if needed.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Our aim is to assist our users in a better and more convenient way, through following features:",
                    style: TextStyle(fontSize: 20,
                        color: Color.fromARGB(255, 0, 40, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("1. Buy and Sell with just one click: No bargaining phone calls, no personal house visits etc.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("2. Sell at fixed price: Buyer accepts price of seller, and can buy instantly ('buy now').",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("3. Make an offer: Give the buyer the option to offer a certain purchase price, and sell within the seller's set minimum selling price.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("4. Free Delivery: Delivery or shipping cost are included in the purchase price and commission paid by buyer and seller on each transaction.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("5. Dismantling and Assembly: When selling and buying furniture for instance, for an optional extra charge of AED 100, UMONDA LLC will take care of dismantling and assembling the item at each respective location. ",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ],
          ),

        ),
      ),
    );
  }
}