import 'package:flutter/material.dart';
import 'package:hardware_lo/custom/device_info.dart';
import 'package:hardware_lo/my_theme.dart';
import 'package:hardware_lo/custom/useful_elements.dart';
import 'package:flutter/cupertino.dart';
import '../app_config.dart';
import '../helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;
import 'package:hardware_lo/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:hardware_lo/repositories/place_ad_repository.dart';

class placead extends StatefulWidget {
 // const placead({super.key});

  @override
  State<placead> createState() => _placeadState();
}

class _placeadState extends State<placead> {
  bool light = true;
  TextEditingController _ProductName = TextEditingController();
  TextEditingController _Category = TextEditingController();
  TextEditingController _Brand = TextEditingController();
  TextEditingController _PriceAED = TextEditingController();
  TextEditingController _MinOfferPrice = TextEditingController();
  TextEditingController _Description = TextEditingController();
  TextEditingController _EmailID = TextEditingController();
  TextEditingController _PassWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: MyCustomForm(),
    ));
  }


  // class MyCustomForm extends StatelessWidget {
  // const MyCustomForm({Key key, go_back = true}) : super(key: key);

  Widget MyCustomForm() {
  return Scaffold(
  backgroundColor: Colors.white,
  appBar: buildAppBar(context),

  body: buildBody()
  );
  }

  AppBar buildAppBar(BuildContext context) {
  return AppBar(
  //iconTheme: IconThemeData(color: Colors.black),
  leading: UsefulElements.backToMain(context, go_back: false,color:Colors.black),

  backgroundColor: Color.fromARGB(240, 243, 237, 237),
  title: buildAppBarTitleOption(context),
  elevation: 0.0,
  titleSpacing: 0,

  );
  }

  Widget buildAppBarTitleOption(BuildContext context) {
  return Container(
  padding: EdgeInsets.symmetric(horizontal: 0),
  child: Row(
  children: [
  Container(
  width: 20,
  // child: UsefulElements.backButton(context, color: "white"),
  ),
  Container(
  padding: EdgeInsets.only(left: 0),

  child: Text('Place Ad',
  style: TextStyle(color: Colors.black,),
  ),
  )

  ],
  ),
  );
  }

  Widget buildBody() {
  bool light = true;
  return ListView(
  children: [
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: Card(
  elevation: 10,
  child: Column(
  children: [
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("Ad Information",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  )
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
  child: TextField(
    controller: _ProductName,
    autofocus: false,
    enableSuggestions: false,
    autocorrect: false,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Product Name',
    ),
  ),
  ),

  Container(
  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("Category",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  )
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: TextField(
      controller: _Category,
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Nothing slected',
      ),
    ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("Brand",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  )
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: TextField(
      controller: _Brand,
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Nothing slected',
      ),
    ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  ),

  ],
  ),
  ),
  ),
  //-------------------
  Container(
  child: Card(
  elevation: 10,
  child: Column(
  children: [
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("Ad Image",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  )
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
  child: GestureDetector(
  child: const Align(
  alignment: Alignment.center,
  child: Text("Drop files here to upload",
  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 0, 0, 0))),
  ),
  onTap: () {
  //imagepick();
  }

  ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  ),
  ],
  ),
  ),
  ),
  //---------------------
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: Card(
  elevation: 10,
  child: Column(
  children: [
  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("Ad Price",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  )
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: TextField(
      controller: _PriceAED,
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Price in AED',
      ),
    ),
  ),

  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  child: Row(
  children: [
  Container(
  child: Text("Make an offer",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  ),
  Container(
  child: _SwitchExampleState(),
  ),
    // Container(
    //   child: Text(light ? "true": "false",
    //       style: TextStyle(fontSize: 20,
    //           color: Color.fromARGB(255, 0, 0, 0))),
    // ),

  ],
  ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: TextField(
      controller: _MinOfferPrice,
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Minimum Offer Price',
      ),
    ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  ),
  ],
  ),
  ),
  ),
  //---------------------
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: Card(
  elevation: 10,
  child: Column(
  children: [
  Container(
  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("Ad Description",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  )
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: TextField(
    controller: _Description,
  decoration: const InputDecoration(
  border: UnderlineInputBorder(),
  labelText: 'Description',
  ),
  keyboardType: TextInputType.multiline,
  minLines: 1,
  maxLines: 11,
  ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  ),
  ],
  ),
  ),
  ),
  //---------------------
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: Card(
  elevation: 10,
  child: Column(
  children: [
  Container(
  margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("User Details",
  style: TextStyle(fontSize: 20,
  color: Color.fromARGB(255, 0, 0, 0))),
  )
  ),
  Container(
    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
    child: TextField(
      controller: _EmailID,
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Email',
      ),
    ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
  child: TextField(
    controller: _PassWord,
    autofocus: false,
    obscureText: true,
    enableSuggestions: false,
    autocorrect: false,
  decoration: const InputDecoration(
  border: UnderlineInputBorder(),
  labelText: 'Your Password',
  ),
  ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
  child: const Align(
  alignment: Alignment.topLeft,
  child: Text("* Mandatory Fields",
  style: TextStyle(fontSize: 12,
  color: Color.fromARGB(255, 250, 55, 55))),
  )
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  ),
  ],
  ),
  ),
  ),

  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  color: Colors.lightBlue,
  height: 50,
  child: GestureDetector(
  child: const Align(
  alignment: Alignment.center,
  child: Text("Upload Ad",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 254, 254, 254))),
  ),

  onTap: (){
    onPressedUploadAd();
  },



  // onTap: () async {
  // Uri url = Uri.parse("${AppConfig.BASE_URL}/categories/top");
  // final response =
  // await http.get(url,headers: {
  // "App-Language": app_language.$,
  // });
  // }

  ),
  ),
  Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  ),

  ]
  );
  }
//------------------------
// imagepick(){
// File? image;
// Future pickImage() async {
//   try {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if(image == null) return;
//     final imageTemp = File(image.path);
//     setState(() => this.image = imageTemp);
//   } on PlatformException catch(e) {
//     print('Failed to pick image: $e');
//   }
// }
// }
//------------------------
//   class SwitchExample extends StatefulWidget {
//   //const SwitchExample({super key});
//
//   @override
//   State<SwitchExample> createState() => _SwitchExampleState();
//   }

  _SwitchExampleState () {

  return Switch(
  // This bool value toggles the switch.
  value: light,
  activeColor: Colors.green,
  onChanged: (bool value) {
  // This is called when the user toggles the switch.
  setState(() {
  light = value;
  });
  print("light : ${light}");
  },
  );
  }

//-----------------------
  onPressedUploadAd() async {
    var ProdName = _ProductName.text.toString();
    var Catg = _Category.text.toString();
    var Brd = _Brand.text.toString();
    var PriAED = _PriceAED.text.toString();
    var MinOP = _MinOfferPrice.text.toString();
    var Desc = _Description.text.toString();
    var Email = _EmailID.text.toString();
    var Pw = _PassWord.text.toString();
print("placead.dart, onPressedUploadAd(), Email : ${Email}");
    var PAResponse = await PLACEADREPOSITORY()
        .getPADResponse(ProdName, Catg, Brd, PriAED, MinOP, Desc,
                Email, Pw);
    print("placead.dart, onPressedUploadAd(), PAResponse : ${PAResponse}");
    if (PAResponse.result == false) {
      ToastComponent.showDialog(PAResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
    } else {
      print("placead.dart, onPressedUploadAd(), response : ${PAResponse.message}");
      ToastComponent.showDialog(PAResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }




//-------------------------
} //State