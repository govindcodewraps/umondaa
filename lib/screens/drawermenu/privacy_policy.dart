import 'package:flutter/material.dart';


class PrivacyPolicy extends StatelessWidget {
  //const PrivacyPolicy({super.key});

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
        title: Text('Privacy Policy',
          style: TextStyle(color:  Color.fromARGB(255, 70, 10, 160)),),
      ),
      body: ListView(
        // child: Container(
        //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        //   height: 700,
        //
        //   child: Column(

            children: [
              Container(
                child: Image.asset('assets/topbarlogo1.png',
                  height: 20,
                  width: 50,),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("The Privacy Policy applies to personal information that may be collected when you interact with UMONDA LLC by becoming a registered member or making a purchase of a product or browsing through this website.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("UMONDA LLC gives highest priority to protecting the privacy and security of your personal information.",
                    style: TextStyle(fontSize: 20,
                        color: Color.fromARGB(255, 0, 40, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("UMONDA LLC would request you to go through this Privacy Policy to learn more about collection, storage, use and disclosure of all your personal information as described.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("UMONDA LLC reserves the right to modify or amend this Privacy Policy at any time, but you can be assured that, should it be necessary to do so, we will notify you about the new privacy policy.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Which Personal Information do we collect?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("We collect personal information which includes your name along with other information like email address, billing address, shipping address, phone number, app installs etc.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("What is the purpose of collecting personal information?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("We collect personal information to provide you with a superior customer experience. It helps us in administering our business and providing you with easy access to products which suits your interest. Your personal information also allows us to inform you about special offers, promotions, and news that may be of your interest.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("How do we collect personal information?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Information provided by you: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- Becoming a registered member: In order to become a registered member, we will ask you to provide us with personal information including name, address, contact number and email address.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- Making a purchase: In the process of making a purchase, we will ask you to provide us with personal information.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- Signing up for the newsletter: To sign up for the newsletter, we will ask you to provide us with your email address.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- Contacting our customer support team: When you contact our customer support team, we may ask you to provide or confirm personal information so that we can serve you better.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Information automatically collected from you via third party analytics integrated on our App:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- Visiting our website: When you visit our website, we automatically record information your browser sends including IP address of your computer, date & time you access our website, etc. We do not collect any personal information at this moment.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- Using cookies: A “cookie” is a small piece of information stored by a Web server on a Web browser so it can be later read back from that browser. These cookies help us to:",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("a) Keep track of items stored in your Wall. ",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("b) Remember the information provided by you.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("c) Determine the effectiveness of our marketing efforts.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("d) Monitor the total number of visitors, pages viewed, etc. to improve your shopping experience.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("UMONDA LLC places both permanent and temporary cookies in your computer’s hard drive.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("With whom we may share this information?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Payment gateways: We share your personal information with payment providers in order to verify your details and complete your transaction.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Logistic partners: We provide your personal information like name and shipping address to shipping companies, so products can be delivered in the prescribed transit time.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("a) To comply with the law, regulation, legal process, or enforceable governmental request.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("b) To enforce or apply the terms of any of our policies.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("c) To protect the rights, property or safety of UMONDA LLC, our customers, users, or others.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("We may disclose to third-party services certain personally identifiable information listed below:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- The information provided by you such as name, email address and phone number etc.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("- Information we collect whilst you access and use our service, including device information, location, and network carriers.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("This information is shared with third party service providers so that we can:",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("a) Personalize our app for you.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("b) Perform behavioral analytics.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Is Your personal information secured?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("UMONDA LLC has taken all necessary steps, both physical and technological measures to ensure that your personal information is secured and utilized in your best interest. In addition, we use SSL encryption technology to protect your personal information.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("Whom should I contact in case of any concern?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text("In case you have any concerns about this Privacy Policy, please send an email to info@umonda.com.",
                    style: TextStyle(fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ],
          ),

        );
  }
}