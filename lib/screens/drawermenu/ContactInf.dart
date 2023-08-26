import 'package:flutter/material.dart';


class ContactInf extends StatelessWidget {
  //const ContactInf({super.key});

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
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 550,

          child: Column(

            children: [
              Container(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                child: Image.asset('assets/appbarlogo.png',
                  height: 100,
                  width: 150,),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("UMONDA LLC",
                    style: TextStyle(fontSize: 25,
                        color: Color.fromARGB(255, 2, 2, 2))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Sharjah Media City Freezone",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Al Messaned",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("UAE",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Phone : +971-50-1771129",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Email : info@umonda.com",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ],
          ),

        ),
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

            child: Text('Contact Information',
              style: TextStyle(color:  Colors.black,),
            ),
          )

        ],
      ),
    );
  }

}