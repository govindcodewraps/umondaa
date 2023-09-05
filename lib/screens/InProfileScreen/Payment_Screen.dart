
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

                    shrinkWrap: true,
                    //physics:  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Id :", textAlign: TextAlign.start,),
                              SizedBox(width: 30,),
                              Text(snapshot.data.data[index].id.toString(), textAlign: TextAlign.center,),
                            ],),
                          Row(
                            children: [
                              Text("Code :"),
                              SizedBox(width: 30,),
                              Text(snapshot.data.data[index].code.toString(),),
                            ],),
                          Row(
                            children: [
                              Text("User_ID :"),
                              SizedBox(width: 30,),
                              Text(snapshot.data.data[index].userId.toString(),),
                            ],),
                          Row(
                            children: [
                              Text("Payment_type :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].paymentType.toString().substring(12),),
                            ],),
                          Row(
                            children: [
                              Text("Payment_status :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].paymentStatus.toString().substring(14),),
                            ],),
                          Row(
                            children: [
                              Text("Payment status string :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].paymentStatusString.toString().substring(20),),
                            ],),
                          Row(
                            children: [
                              Text("Delivery Status :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].deliveryStatus.toString().substring(15)),
                            ],),
                          Row(
                            children: [
                              Text("Grand Total :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].grandTotal.toString(),),
                            ],),
                          Row(
                            children: [
                              Text("Plane Grand Total :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].planeGrandTotal.toString()),
                            ],),
                          Row(
                            children: [
                              Text("Coupon Discount :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].couponDiscount.toString().substring(15),),
                             // Text(snapshot.data.data[index].couponDiscount.toString(),),
                            ],),
                          Row(
                            children: [
                              Text("Shipping Cost :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].shippingCost.toString().substring(15),),
                            ],),
                          Row(
                            children: [
                              Text("Sub Total :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].subtotal.toString(),),
                            ],),
                          Row(
                            children: [
                              Text("Tax :"),
                              SizedBox(width: 30,),

                              Text(snapshot.data.data[index].tax.toString(),),
                            ],),
                          Row(
                            children: [
                              Text("Date :"),
                              SizedBox(width: 30,),
                              Text(snapshot.data.data[index].date.toString(),),
                            ],),
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



