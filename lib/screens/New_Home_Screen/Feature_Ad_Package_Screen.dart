import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hardware_lo/my_theme.dart';

import '../../helpers/shared_value_helper.dart';
import '../login.dart';

class Feature_ad_package_Screen extends StatefulWidget {


  @override
  State<Feature_ad_package_Screen> createState() => _Feature_ad_package_ScreenState();
}

String dropdownvalue = 'Item 1';

// List of items in our dropdown menu
var items = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
];


class _Feature_ad_package_ScreenState extends State<Feature_ad_package_Screen> {
  @override


  String dropdownValue = 'Item 1'; // Track the selected value



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body:
    Column(
     // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      bodyy(),
    ],),);
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, // Change the color of the back icon here
      ),
      backgroundColor: Colors.white,

      title: Row(
        children: [
          // Text(
          //   AppLocalizations.of(context).shopping_cart_ucf,
          //   style: TextStyles.buildAppBarTexStyle(),
          // ),
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
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Widget bodyy(){
    return Center(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("Featured Ad Packages",style: TextStyle(color: MyTheme.accent_color,fontSize: 22,fontWeight: FontWeight.w600),),
        SizedBox(height: 10,),
          Text("Accelearte the sale of your product, get it featured on Home page",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
          SizedBox(height: 10,),
        Text("Buy a Package Today !",style: TextStyle(color: MyTheme.accent_color,fontSize: 18,fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Container(
           // color: Colors.red,
            //height: 200,
            width: 180,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                //border: Border.all(color: MyTheme.accent_color),
                boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
            ),
            child: Column(children: [
              Image.asset('assets/appbarlogo.png'),
              Text("Silver"),
              Text("AED 29.00 | 15 Day"),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                height: 30,
                width:double.infinity,
                child: ElevatedButton(

                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(MyTheme.accent_color),

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color:MyTheme.accent_color)
                          )
                      )
                  ),

                  onPressed: (){

                    if(is_logged_in.$ == false){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }
                    else{
                      alertDialog(context);
                    }
                    //alertDialog(context);
                   // Navigator.push(context,MaterialPageRoute(builder: (context)=>Allnewads_Screen()));
                  },
                  child:Text(
                    "Purchase package",
                    // AppLocalizations.of(context).update_profile_ucf,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        ),
                  ),),
              ),
              SizedBox(height: 10,)

            ],),
          ),

          Container(
            // color: Colors.red,
            height: 200,width: 180,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                //border: Border.all(color: MyTheme.accent_color),
                boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
            ),
          ),
        ],),
          SizedBox(height: 20,),
          Container(
            // color: Colors.red,
            height: 200,width: 180,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                //border: Border.all(color: MyTheme.accent_color),
                boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
            ),
          ),

        ],),
    );
  }


  Widget alertDialog(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return Stack(
            children: [
              // Background content
              Container(
                color: Colors.black.withOpacity(0.5), // Color overlay
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
                  child: Container(
                    color: Colors.transparent, // Transparent to apply blur
                  ),
                ),
              ),
              // AlertDialog with a blur effect
              AlertDialog(
                scrollable: true,
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Purchase Your Package"),
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.cancel)),
                      ],
                    ),
                    Divider(color: Colors.grey,)
                  ],
                ),
                content: Container(
                  // width: 400,
                 //padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment method :",style: TextStyle(fontWeight: FontWeight.w600,color: MyTheme.accent_color),),
                        SizedBox(height: 5,),
                        SizedBox(
                          //height: 50,
                          //width: 250,
                          child: TextField(
                            //controller: pricecontroller,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Stripe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              //labelText: 'Password',
                            ),
                          ),
                        ),
                        // DropdownButton(
                        //
                        //   // Initial Value
                        //   value: dropdownvalue,
                        //
                        //   // Down Arrow Icon
                        //   icon: const Icon(Icons.keyboard_arrow_down),
                        //
                        //   // Array list of items
                        //   items: items.map((String items) {
                        //     return DropdownMenuItem(
                        //       value: items,
                        //       child: Text(items),
                        //     );
                        //   }).toList(),
                        //   // After selecting the desired option,it will
                        //   // change button value to selected value
                        //   onChanged: (String newValue) {
                        //     setState(() {
                        //       dropdownvalue = newValue;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
                actions: [

                  Container(
                    padding: EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          child: Text("Cancel",style: TextStyle(color:Colors.black),),
                          onPressed: () {
                           // makeanofferapi(pricecontroller.text);
                           // print("Your Price ${pricecontroller.text}");
                            Navigator.pop(context);
                            //pricecontroller.clear();
                            // Your code for submitting the form.
                          },
                        ),
                        SizedBox(width: 5,),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(MyTheme.accent_color),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          child: Text("Confirm",),
                          onPressed: () {
                           // makeanofferapi(pricecontroller.text);
                           // print("Your Price ${pricecontroller.text}");
                            Navigator.pop(context);
                            //pricecontroller.clear();
                            // Your code for submitting the form.
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );



  }

  Widget listview(){
    return  Container(
      //padding: EdgeInsets.only(top: 23),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context , int index){
          return Column(children: [
            Container(
              // color: Colors.red,
              //height: 200,
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  //border: Border.all(color: MyTheme.accent_color),
                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
              ),
              child: Column(children: [
                Image.asset('assets/appbarlogo.png'),
                Text("Silver"),
                Text("AED 29.00 | 15 Day"),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  height: 30,
                  width:double.infinity,
                  child: ElevatedButton(

                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(MyTheme.accent_color),

                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(color:MyTheme.accent_color)
                            )
                        )
                    ),

                    onPressed: (){

                      if(is_logged_in.$ == false){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }
                      else{
                        alertDialog(context);
                      }
                      //alertDialog(context);
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>Allnewads_Screen()));
                    },
                    child:Text(
                      "Purchase package",
                      // AppLocalizations.of(context).update_profile_ucf,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),),
                ),
                SizedBox(height: 10,)

              ],),
            ),
          ],);

        },
        itemCount: 5,
      ),
    );
  }




}
