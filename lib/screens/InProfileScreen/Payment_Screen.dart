
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hardware_lo/my_theme.dart';
import '../../Models/payment_model.dart';

class PaymentScreen extends StatefulWidget {

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentdata();
  }

  @override
  Widget build(BuildContext context) {
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

      body:listview(),
    ));
  }




  Widget listview() {
    return
      FutureBuilder(
          future: paymentdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                Container(
                  //padding: EdgeInsets.only(top: 23),
                  child: ListView.builder(
                    itemCount: snapshot.data.data.length-1,
                    shrinkWrap: true,
                    //physics:  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  //border: Border.all(color: MyTheme.accent_color),
                                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                              ),
                              child:   Row(

                                mainAxisAlignment: MainAxisAlignment.spaceAround,



                                children: [

                                  Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [



                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)



                                          ),



                                          child: Text("Id :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            // border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Code :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("User_ID :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Payment_type :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Payment_status :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Payment status string :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            // border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Delivery Status :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Grand Total :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            // border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Plane Grand Total :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Coupon Discount :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(


                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),child: Text("Shipping Cost :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Sub Total :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            // border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text("Tax : ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),

                                      SizedBox(height: 4,),

                                      Container(
                                          padding: EdgeInsets.only(left: 7),
                                          width:MediaQuery.of(context).size.width*0.43,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //  border: Border.all(color: MyTheme.accent_color)

                                          ),

                                          child: Text(" Date :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),



                                    ],),





                                  SizedBox(width: 8,),

                                  Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [



                                      Container(

                                          width:MediaQuery.of(context).size.width*0.4,
                                       padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),



                                          child: Text(snapshot.data.data[index].id.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 6),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].code.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),
                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].userId.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].paymentType.toString().substring(12),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].paymentStatus.toString().substring(14),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].paymentStatusString.toString().substring(20),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].deliveryStatus.toString().substring(15),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].grandTotal.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].planeGrandTotal.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].couponDiscount.toString().substring(15),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].shippingCost.toString().substring(15),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].subtotal.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].tax.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),


                                      SizedBox(height: 4,),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width:MediaQuery.of(context).size.width*0.4,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                                            //color: Colors.grey[300],

                                            //border: Border.all(color: MyTheme.accent_color)

                                          ),
                                          child: Text(snapshot.data.data[index].date.toString().substring(9),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),



                                    ],),

                                ],),
                            ),
                          ),



                          //SizedBox(height: 25,),

                        ],);
                    },
                    //itemCount: 12,
                   // itemCount: snapshot.data.data.length??"",
                  ),
                );
            }
            else{
              return
                Container(
                    child: Center(child: CircularProgressIndicator()));
            }
          }
      );
  }


  Future<PaymenthistoryModel> paymentdata() async {
    // Create Dio instance
    Dio dio = Dio();

    // Define the headers
    Map<String, String> headers = {
      'Authorization': 'Bearer 131|V1SPLBTs7BaNNUwZth5gTGjZfC1nc2qQ1EB6fpTs',
      'Cookie':
      'XSRF-TOKEN=dT0lZnI5OsbNxA88TLF4S2x45edCmnKMTwmze0oJ; umonda_online_marketplace_session=k3LCVR020r4kAVJFwu2R66nEtLr7CtFTN7ekl25M'

      //'Authorization': 'Bearer 272|zOSOR7ks4vioa05Rp8YwM61GTFAIpybBUSiX3WYv',
    };

    // Define the API endpoint
    String url = "https://umonda.com/api/v2/payment-history/138";

    try {
      // Make the API call
      Response response = await dio.get(url, options: Options(headers: headers));

      // Handle the response
      if (response.statusCode == 200) {
        return PaymenthistoryModel.fromJson(response.data);

        // API call successful
        //print(response.data);
      }

     else if(response.statusCode == 500){

        print("500 Internal Server Error........... ");
      }

      else {
        // API call failed
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors
      print('An error occurred: $error');
    }
  }

}



