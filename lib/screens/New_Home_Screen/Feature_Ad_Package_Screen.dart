import 'package:flutter/material.dart';
import 'package:hardware_lo/my_theme.dart';

class Feature_ad_package_Screen extends StatefulWidget {


  @override
  State<Feature_ad_package_Screen> createState() => _Feature_ad_package_ScreenState();
}

class _Feature_ad_package_ScreenState extends State<Feature_ad_package_Screen> {
  @override
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

}
