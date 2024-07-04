import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umonda/my_theme.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../app_config.dart';
import '../../helpers/shared_value_helper.dart';
import 'money_withdrawal.dart';


class Moneywithdrawalrewuest extends StatefulWidget {
 // const Moneywithdrawalrewuest({super.key});

  @override
  State<Moneywithdrawalrewuest> createState() => _MoneywithdrawalrewuestState();
}

class _MoneywithdrawalrewuestState extends State<Moneywithdrawalrewuest> {
  @override
  Widget build(BuildContext context) {
   // TextEditingController _useridController = TextEditingController();
    TextEditingController _amountController = TextEditingController();
    TextEditingController _messageController = TextEditingController();
    return SafeArea(child: Scaffold(

      appBar: AppBar(
        centerTitle:true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // Change this to your desired color
        ),
        title: Row(
          children: [
            Spacer(),
            Image.asset(
              'assets/appbarlogo.png',width:100,height: 80,
              //height: 40,
              //width: 250,
            ),
            Spacer(),
            Icon(Icons.notifications,color: Colors.white,),
            Icon(Icons.notifications,color: Colors.white,),


          ],
        ),
      ),

      body:
      Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
         //    SizedBox(height: 10,),
         // Text("User Id",style: TextStyle(fontSize: 20),),
         //    SizedBox(
         //      height: 50,
         //      //width: 250,
         //      child: TextField(
         //        controller: _useridController,
         //        obscureText:false,
         //        decoration: InputDecoration(
         //          border: OutlineInputBorder(
         //            borderRadius: BorderRadius.circular(10.0),
         //          ),
         //          //labelText: 'Password',
         //        ),
         //      ),
         //    ),
            SizedBox(height: 10,),
         Text("Amount",style: TextStyle(fontSize: 20),),
            SizedBox(
              height: 50,
              //width: 250,
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _amountController,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                  //labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text("Message",style: TextStyle(fontSize: 20),),
            SizedBox(
              height: 50,
              //width: 250,
              child: TextField(
                controller: _messageController,
                //keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  //labelText: 'Password',
                ),
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(MyTheme.accent_color),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  //side: BorderSide(color: Colors.red)
                              )
                          )
                      ),
                      onPressed: (){

                        if (_amountController.text.isEmpty || _messageController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please fill in all fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black87,
                            textColor: Colors.red,
                            fontSize: 16.0,
                          );
                        } else {
                          sendrequest(_amountController.text.toString(), _messageController.text.toString());
                          print(_amountController.text.toString());
                          print(_messageController.text.toString());
                          //textController1.clear();
                          _amountController.clear();
                          _messageController.clear();

                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return Moneywithdrawal();
                          }));

                        }


                        // Fluttertoast.showToast(
                        //   msg: "This is a short toast message",
                        //   toastLength: Toast.LENGTH_SHORT,
                        //   gravity: ToastGravity.BOTTOM, // You can change the position
                        //   timeInSecForIosWeb: 1, // Duration in seconds the toast should be visible on iOS and web
                        //   backgroundColor: Colors.black, // Background color of the toast
                        //   textColor: Colors.red, // Text color of the toast message
                        //   fontSize: 16.0, // Font size of the toast message
                        // );

                       // sendrequest(_amountController.text.toString(),_messageController.text.toString());
                       // sendrequest(_useridController.text.toString(),_amountController.text.toString(),_messageController.text.toString());

                        //print(_useridController.text.toString());
                        //print(_amountController.text.toString());
                        //print(_messageController.text.toString());

                      },
                      child:Text("Submit")
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
        ],),
      ),
    ));
  }


  // import 'dart:convert';
  // import 'package:http/http.dart' as http;

  sendrequest(amount,message) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA2YzFmNTg5ZDRhZWExM2M5NmRlOGJkYTU3N2JjZDMwZjU0MzNlYjg2ZGJjNjYxOWZlZGQ0NGQwNDE3NGM0NjU4NzFhZWUyNmJlOTcyMDg2In0.eyJhdWQiOiIxIiwianRpIjoiMDZjMWY1ODlkNGFlYTEzYzk2ZGU4YmRhNTc3YmNkMzBmNTQzM2ViODZkYmM2NjE5ZmVkZDQ0ZDA0MTc0YzQ2NTg3MWFlZTI2YmU5NzIwODYiLCJpYXQiOjE2MjIxMDIwNDksIm5iZiI6MTYyMjEwMjA0OSwiZXhwIjoxNjUzNjM4MDQ5LCJzdWIiOiI4Iiwic2NvcGVzIjpbXX0.n9BMDf-QIByUav2pASbpPMUQVqTQMZL1DsikHTjch2dz_QeEaVqfd3KORcqVVaLIbsVd4uUu8hZKgR435_8rba0QZ1ggwyulhv6hoUSGdA7yZcGKRFAqUBZJr8F4s7DVEo3QvnhsqkBz-pxLDUOT4t6t0_67NwYADZ3ASbab3E9kjmXgbEruo0XvmZ78PP8RqGjpf-4D2OBctOw4Jdk_pRjd1LwQv8b2W8I9tONLzMXvHE7EJdIeEBM5LeUd9bBz_cnn8zI02qCnUidGc6LeWyGA0eyvuRUo_nRnhStYHOOjKY0Fb_BzEivIuwNp04ev03aJrfNENh1CGUDrY9n2sALN1fRziLnImwtpVIhXvUSgbDVhJyvmMdvcKvYmNrDLxMxnhsdZ9-uGTNFLU7ViqbwB6oLhnF5rqOKcy9WgOBd3-uVjU3QOsZ_qMndmj5cMP5LYZT74bo4gIBRN_7lYGMzPmvTzjwAuC6UD-O1y_rB8gVVlJkN8cyVs8LvwE_V9vHepAaelxpkLVlwWOTd350RxHO7n0B51rrg3Y8dqS-cdgxA5h1-VRugOuXwRqV7lDKFVm9naOStfMl4o4Dgh8bjb03GzG6W1zJXqtDuUbpOKSOchjpuxfH2NLM2LxUZLH6RkrV9YFAin8N6imZ82GVn9l_GAkZOaMGFvTKSp-_Y'
    };

    var data = jsonEncode({
      'user_id': user_id.$,
      'amount': amount,
      'message': message,
    });

    //var url = Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/withdraw-requests');
    var url = Uri.parse('${AppConfig.BASE_URL}/withdraw-requests');

    var response = await http.post(
      url,
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Request sent successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // You can change the position
        timeInSecForIosWeb: 1, // Duration in seconds the toast should be visible on iOS and web
        backgroundColor: Colors.black87, // Background color of the toast
        textColor: Colors.white, // Text color of the toast message
        fontSize: 16.0, // Font size of the toast message
      );
      print("request send");
      print(json.decode(response.body));
    } else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(
        msg: "Server Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, // You can change the position
        timeInSecForIosWeb: 1, // Duration in seconds the toast should be visible on iOS and web
        backgroundColor: Colors.black87, // Background color of the toast
        textColor: Colors.white, // Text color of the toast message
        fontSize: 16.0, // Font size of the toast message
      );
    }
  }



}
