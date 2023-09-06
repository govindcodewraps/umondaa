
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Models/Commission_History_Model.dart';
import '../../Models/payment_model.dart';

class CommissionHistoryScreen extends StatefulWidget {

  @override
  State<CommissionHistoryScreen> createState() => _CommissionHistoryScreenState();
}

class _CommissionHistoryScreenState extends State<CommissionHistoryScreen> {

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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text("Id :", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))),

                               SizedBox(height:4),
                                Container(
                                  padding: EdgeInsets.only(left: 7),
                                  width:MediaQuery.of(context).size.width*0.3,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                      ),
                                    child: Text("Order ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))),
                                  SizedBox(height:4),
                                Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text("User_ID :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))),
                                  SizedBox(height:4),
                                 Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text("Seller Earning :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))),
                                  SizedBox(height:4),
                                Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text("Created At :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))),
                                  SizedBox(height:4),
                                  Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text("updated At :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))),

                              ],),
                              SizedBox(width: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text(snapshot.data.data[index].id.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                  SizedBox(height:4),
                                Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text(snapshot.data.data[index].orderId.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                  SizedBox(height:4),
                                Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text(snapshot.data.data[index].userId.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                  SizedBox(height:4),
                                  Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text(snapshot.data.data[index].sellerEarning.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                  SizedBox(height:4),
                                  Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text(snapshot.data.data[index].createdAt.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),
                                  SizedBox(height:4),
                                  Container(
                                    padding: EdgeInsets.only(left: 7),
                                    width:MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey,
                                      //border: Border.all(color: MyTheme.accent_color)
                                    ),
                                    child: Text(snapshot.data.data[index].updatedAt.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))),

                              ],),
                            ],
                          ),

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


  Future<CommisionHistoryModel> paymentdata() async {
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
    String url = "https://umonda.com/api/v2/commission-history/138";

    try {
      // Make the API call
      Response response = await dio.get(url, options: Options(headers: headers));

      // Handle the response
      if (response.statusCode == 200) {
        return CommisionHistoryModel.fromJson(response.data);

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



