
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: listview(),
      ),
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

                    shrinkWrap: true,
                    //physics:  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
Row(children: [
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text("Id :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),

      Text("Code :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("User_ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Payment_type :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Payment_status :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Payment status string :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Delivery Status :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Grand Total :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Plane Grand Total :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Coupon Discount :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Shipping Cost :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Sub Total :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Tax : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

      Text("Date :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),

    ],),


  SizedBox(width: 8,),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    Text(snapshot.data.data[index].id.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].code.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
      Text(snapshot.data.data[index].userId.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].paymentType.toString().substring(12),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].paymentStatus.toString().substring(14),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].paymentStatusString.toString().substring(20),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].deliveryStatus.toString().substring(15),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].grandTotal.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].planeGrandTotal.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].couponDiscount.toString().substring(15),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].shippingCost.toString().substring(15),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].subtotal.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].tax.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

    Text(snapshot.data.data[index].date.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),

  ],),
],),


                          //
                          // Row(
                          //   //crossAxisAlignment: CrossAxisAlignment.end,
                          //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Text("Id :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                          //     SizedBox(width: 30,),
                          //     Text(snapshot.data.data[index].id.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Code :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //     Text(snapshot.data.data[index].code.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("User_ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //     Text(snapshot.data.data[index].userId.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Payment_type :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].paymentType.toString().substring(12),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Payment_status :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].paymentStatus.toString().substring(14),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Payment status string :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].paymentStatusString.toString().substring(20),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Delivery Status :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].deliveryStatus.toString().substring(15),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Grand Total :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].grandTotal.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Plane Grand Total :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].planeGrandTotal.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Coupon Discount :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].couponDiscount.toString().substring(15),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //    // Text(snapshot.data.data[index].couponDiscount.toString(),),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Shipping Cost :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].shippingCost.toString().substring(15),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Sub Total :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].subtotal.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Tax :                           ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //
                          //     Text(snapshot.data.data[index].tax.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          // Row(
                          //   children: [
                          //     Text("Date :                        ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //     SizedBox(width: 30,),
                          //     Text(snapshot.data.data[index].date.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                          //   ],),
                          SizedBox(height: 25,),

                        ],);
                    },
                    itemCount: snapshot.data.data.length,
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
      } else {
        // API call failed
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors
      print('An error occurred: $error');
    }
  }

}



