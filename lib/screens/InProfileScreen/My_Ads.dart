import 'package:flutter/material.dart';

import '../../custom/useful_elements.dart';
class My_adsScreen extends StatefulWidget {
  //const My_adsScreen({super.key});

  @override
  State<My_adsScreen> createState() => _My_adsScreenState();
}

class _My_adsScreenState extends State<My_adsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
          children: [
            listview(),
          ],
      ),
        ),),
    );
  }



  Widget listview(){
    return  Container(
      //padding: EdgeInsets.only(top: 23),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          // Your separator builder logic here
          return Divider(); // Example: Using a Divider as the separator
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context , int index){
          return Column(children: [
           // Text("Govind"),
            Container(
              width: MediaQuery.of(context).size.width *1,
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        //border: Border.all(color: MyTheme.accent_color),
                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                    ),

                    height: 100,
                    width: MediaQuery.of(context).size.width *0.3,
                  ),
                SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                        //border: Border.all(color: MyTheme.accent_color),
                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                    ),

                    height: 100,
                    width: MediaQuery.of(context).size.width *0.6,
                    child: Column(children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ],),
                  ),
                ],
              ),
            )
          ],);

        },
        itemCount: 51,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // leading: Builder(
      //   builder: (context) =>
      //   widget.from_navigation ? UsefulElements.backToMain(context, go_back: false) : UsefulElements.backButton(context),
      // ),
      leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.black,)),
      title: Row(
        children: [
          //Icon(Icons.arrow_back_ios_new,color: Colors.black,),
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
          Icon(Icons.notifications),
          Icon(Icons.notifications),

        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }



}
