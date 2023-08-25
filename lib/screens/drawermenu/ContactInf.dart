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
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Color.fromARGB(255, 2, 70, 40),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Contact Information',
          style: TextStyle(color:  Color.fromARGB(255, 255, 255, 255)),),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 550,

          child: Column(

            children: [
              Container(
                child: Image.asset('assets/topbarlogo1.png',
                  height: 140,
                  width: 350,),
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
}