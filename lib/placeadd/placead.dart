
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hardware_lo/custom/device_info.dart';
import 'package:hardware_lo/my_theme.dart';
import 'package:hardware_lo/custom/useful_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardware_lo/repositories/brand_repository.dart';
import '../data_model/brand_response.dart';
import '../app_config.dart';
import '../helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;
import 'package:hardware_lo/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:hardware_lo/repositories/place_ad_repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../screens/registration.dart';


const List<String> category = <String>['Select Category', 'Home & Garden', 'Electronics', 'Motors', 'Fashion', 'Collectibles & Arts', 'Sports', 'Health & Beauty', 'Industrial Equipment'];

class placead extends StatefulWidget {
  // const placead({super.key});

  @override
  State<placead> createState() => _placeadState();
}

class _placeadState extends State<placead> {
  bool light = false, isChecked = true;
  bool _filteredBrandsCalled = false;
  List<File> selectedImages = [];
  List<dynamic> brandsList = [];
  final picker = ImagePicker();
  String dropdownBrands = "Select brand";
  String dropdownCategory = "Select category";

  TextEditingController _ProductName = TextEditingController();
  TextEditingController _Category = TextEditingController();
  TextEditingController _Brand = TextEditingController();
  TextEditingController _PriceAED = TextEditingController();
  TextEditingController _MinOfferPrice = TextEditingController();
  TextEditingController _Description = TextEditingController();
  TextEditingController _EmailID = TextEditingController();
  TextEditingController _PassWord = TextEditingController();

  @override
  void initState() {
    fetch_Brands();             //fetchFilteredBrands();
    super.initState();
  }

  fetch_Brands() async {
    var filteredBrandResponse = await BrandRepository().getFilterPageBrands();
    brandsList.addAll(filteredBrandResponse.brands);
    print("placead.dart, fetch_Brands(), brandsList : ${filteredBrandResponse.brands}");
    _filteredBrandsCalled = true;
    setState(() {});
  }

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
    bool light = false;
    return ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Ad Information",
                            style: TextStyle(fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: TextField(
                      controller: _ProductName,
                      autofocus: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Product Name',
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 16, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Category",
                            style: TextStyle(fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    child: CategoryDropdown(),

                  ),

                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 16, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Brand",
                            style: TextStyle(fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0))
                        ),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    child: BrandDropdown(),
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
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Ad Image",
                            style: TextStyle(fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      )
                  ),
                  Container(
                    // alignment: Alignment.center,
                    child: Center(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white)),
                            child: const Text('Select Image from Gallery',
                                style: TextStyle(fontSize: 14,
                                    color: Color.fromARGB(255, 104, 104, 104))),
                            onPressed: () {
                              getImages();
                            },
                          ),

                          SizedBox(
                            height: 300,
                            width: 300,
                            child: selectedImages.isEmpty
                                ?  Center(child: Text('Sorry nothing selected!!'))
                                : GridView.builder(
                              itemCount: selectedImages.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                print("Placead.dart, index : ${index}");
                                print("PlaceadGGG ${selectedImages}");
                                return Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 200,
                                        alignment: Alignment.center,
                                        child: Image.file(selectedImages[index],fit: BoxFit.cover,),
                                      ),
                                      Positioned(
                                        top: 5, right: 20,
                                        child: GestureDetector(
                                          child: Icon(Icons.close, size: 30, color: Colors.red,),
                                          onTap: (){
                                            delete(index);
                                          },
                                        ),
                                      ),
                                    ],
                                    //child: Image.file(selectedImages[index])
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //---------------------
          Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Ad Price",
                            style: TextStyle(fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: TextField(
                      controller: _PriceAED,
                      autofocus: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Price in AED',
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          child: Text("Make an offer",
                              style: TextStyle(fontSize: 14,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        Container(
                          child: _SwitchExampleState(),
                        ),
                        Container(
                          child: light? Container(
                            child: Text("${light}"),
                          ): Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text("${light}"),
                            // child: TextField(
                            //   controller: _MinOfferPrice,
                            //   autofocus: false,
                            //   enableSuggestions: false,
                            //   autocorrect: false,
                            //   decoration: const InputDecoration(
                            //     border: UnderlineInputBorder(),
                            //     labelText: 'Minimum Offer Price',
                            //   ),
                            // ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                  ),
                ],
              ),
            ),
          ),
          //---------------------
          Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 16, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Ad Description",
                            style: TextStyle(fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
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
                ],
              ),
            ),
          ),
          //---------------------
          Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 16, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("User Details",
                            style: TextStyle(fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 12, 0, 0),
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
                    margin: const EdgeInsets.fromLTRB(5, 12, 0, 0),
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
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          child: _CheckState(),
                        ),
                        Container(
                          child: Column(
                              children: [
                                Container(
                                  child: Text("I hereby agree to the Terms and Conditions",
                                      style: TextStyle(fontSize: 14,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                ),
                                Container(
                                  child: Text("and Privacy Policy of UMONDA LLC.",
                                      style: TextStyle(fontSize: 14,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //Spacer(),
              Text("Don't have an account? ",
                  style: TextStyle(fontSize: 14,
                      color: Color.fromARGB(255, 0, 0, 0))),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                },
                child: Text("Register Now",
                    style: TextStyle(fontSize: 14,
                      color: Colors.blue,
                    )),
              ),
            ],
          ),




/*
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
                print("Product name: ${_ProductName.text}");
                //print("Category name: ${_Category.text}");
               // print("Brand name: ${_Brand.text}");
                print("Min Offer price name: ${_MinOfferPrice.text}");
                print("Description name: ${_Description.text}");
                print("Email Id name: ${_EmailID.text}");
                print("Password name: ${_PassWord.text}");
                print("Price AED name: ${_PriceAED.text}");
                print("Product image: ${selectedImages}");
                print("dropdown Brands: ${dropdownBrands}");
                print("dropdown Category: ${dropdownCategory}");
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
          ),*/



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
                      // Fluttertoast.showToast(
                      //   msg: "This is a short toast message",
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.BOTTOM, // You can change the position
                      //   timeInSecForIosWeb: 1, // Duration in seconds the toast should be visible on iOS and web
                      //   backgroundColor: Colors.black, // Background color of the toast
                      //   textColor: Colors.red, // Text color of the toast message
                      //   fontSize: 16.0, // Font size of the toast message
                      // );


                      print("Product name: ${_ProductName.text}");
                      //print("Category name: ${_Category.text}");
                      // print("Brand name: ${_Brand.text}");
                      print("Min Offer price name: ${_MinOfferPrice.text}");
                      print("Description name: ${_Description.text}");
                      print("Email Id name: ${_EmailID.text}");
                      print("Password name: ${_PassWord.text}");
                      print("Price AED name: ${_PriceAED.text}");
                      print("Product image: ${selectedImages}");
                      print("dropdown Brands: ${dropdownBrands}");
                      print("dropdown Category: ${dropdownCategory}");
                      onPressedUploadAd();

                    },
                    child:Text("Upload Ad")
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),


        ]
    );
  }
//------------------------
  _CheckState () {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return MyTheme.accent_color;
    }
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
  //------------------------
  CategoryDropdown () {
    return DropdownButton2<String>(
      hint: Text(dropdownCategory,style: TextStyle(color: Colors.black),),

      isExpanded: true,
      //value: dropdownCategory,
      icon: const Icon(Icons.keyboard_arrow_down, size: 35,),
      //elevation: 5,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (String value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownCategory = value;
        });
      },
      items: category.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 18),),
        );
      }).toList(),
    );
  }
  //------------------------



  BrandDropdown() {
    print("placead.dart, BrandDropdown(), dropdownBrands : ${dropdownBrands}");
    return DropdownButton2<dynamic>(
      hint: Text(dropdownBrands,style: TextStyle(color: Colors.black),),

      isExpanded: true,
     // value: dropdownBrands,
      icon: const Icon(Icons.keyboard_arrow_down, size: 35,),
      //elevation: 5,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),

      onChanged: (value) {
        // This is called when the user selects an item.
        dropdownBrands = value;
        setState(() {
          print("Selected city is $value");
          dropdownBrands = value;
        });
      },
      items: brandsList.map((brands) {
        print("Brands List${dropdownBrands}");
        //print("placead.dart, BrandDropdown(), brandsList.map : ${brands.name}");
        return DropdownMenuItem(
          value: brands.name,
          child: Text(brands.name, style: TextStyle(fontSize: 14),),
        );
      }).toList(),
    );
  }
//------------------------
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

//-------------------------------
  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
          () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
//----------------
//   _getFromGallery() async {
//     PickedFile pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//       });
//     }
//   }
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
//-----------------------------
  void delete(int index){
    setState(() {
      selectedImages.removeAt(index);
      print("tile number#$index is deleted");
    });
  }




//-------------------------
} //State