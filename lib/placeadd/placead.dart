
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hardware_lo/custom/device_info.dart';
import 'package:hardware_lo/my_theme.dart';
import 'package:hardware_lo/custom/useful_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardware_lo/repositories/brand_repository.dart';
import '../custom/btn.dart';
import '../data_model/brand_response.dart';
import '../app_config.dart';
import '../helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;
import 'package:hardware_lo/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:hardware_lo/repositories/place_ad_repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../repositories/category_repository.dart';
import '../screens/common_webview_screen.dart';
import '../screens/registration.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class placead extends StatefulWidget {
  // const placead({super.key});

  @override
  State<placead> createState() => _placeadState();
}

class _placeadState extends State<placead> {
  bool _isAgree = false;
  bool light = false, isChecked = true;
  bool _filteredBrandsCalled = false;
  bool _filteredcategoryCalled = false;
  List<File> selectedImages = [];
  List<File> basee = [];
  List<dynamic> brandsList = [];
  List<dynamic> categoryList = [];
  final picker = ImagePicker();
  String imageurl;
  String dropdownBrands = "Select Select_Brand";
  String dropdownCategory = "Select Select_Category";
  bool isEnabled = false;
  String offerstatus;


  TextEditingController _ProductName = TextEditingController();
  TextEditingController _Category = TextEditingController();
  TextEditingController _Brand = TextEditingController();
  TextEditingController _PriceAED = TextEditingController();
  TextEditingController _MinOfferPrice = TextEditingController();
  TextEditingController _Description = TextEditingController();
  TextEditingController _EmailID = TextEditingController();
  TextEditingController _PassWord = TextEditingController();
  TextEditingController _offerControler = TextEditingController();

  @override
  void initState() {
    fetch_Brands();
    fetch_Category();
    //fetchFilteredBrands();
    super.initState();
  }

  fetch_Brands() async {
    var filteredBrandResponse = await BrandRepository().getFilterPageBrands();
    brandsList.addAll(filteredBrandResponse.brands);
    print("placead.dart, fetch_Brands(), brandsList : ${filteredBrandResponse.brands}");
    _filteredBrandsCalled = true;
    setState(() {});
  }

  fetch_Category() async {
    var categoryResponse = await CategoryRepository().getCategories();
    categoryList.addAll(categoryResponse.categories);
    print("Category list : ${categoryResponse.categories}");
    _filteredcategoryCalled = true;
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

                                print("base 64 ${basee}");
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text("Make an offer",
                                style: TextStyle(fontSize: 14,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Switch(
                              value: isEnabled,
                              onChanged: (value) {
                                setState(() {
                                  isEnabled = value;
                                  offerstatus=isEnabled ? '1' : '0';
                                  print("Switch value${offerstatus}");
                                  if (isEnabled) {
                                    print('Switch is enabled');
                                  } else {
                                    print('Switch is disabled');
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        //SizedBox(height: 20.0),

                        isEnabled ?

                        Container(
                          child: TextField(
                            controller: _offerControler,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Offer',
                            ),
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 11,
                          ),
                        ) :Column()
                      ],
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
                ],
              ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(top: 20.0,right:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextStyle(color: MyTheme.font_grey, fontSize: 12),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Text(
                    AppLocalizations.of(context).sign_up_ucf,
                    style: TextStyle(
                        color: MyTheme.accent_color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                           return Registration();
                        }));
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15,
                  width: 15,
                  child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      value: _isAgree,
                      onChanged: (newValue) {
                        _isAgree = newValue;
                        setState(() {});
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: DeviceInfo(context).width - 130,
                    child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                            style: TextStyle(
                                color: MyTheme.font_grey, fontSize: 12),
                            children: [
                              TextSpan(
                                text: "I agree to the",
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommonWebviewScreen(
                                                  page_name:
                                                  "Terms Conditions",
                                                  url:
                                                  "${AppConfig.RAW_BASE_URL}/mobile-page/terms",
                                                )));
                                  },
                                style:
                                TextStyle(color: MyTheme.accent_color),
                                text: " Terms Conditions",
                              ),
                              TextSpan(
                                text: " &",
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommonWebviewScreen(
                                                  page_name:
                                                  "Privacy Policy",
                                                  url:
                                                  "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
                                                )));
                                  },
                                text: " Privacy Policy",
                                style:
                                TextStyle(color: MyTheme.accent_color),
                              )
                            ])),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0,left: 16,right: 16),
            child: Container(
              height: 45,
              child: Btn.minWidthFixHeight(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                color: MyTheme.accent_color,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(6.0))),
                child: Text(
                 "Upload Ad",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: _isAgree
                    ? () {


                  if (_ProductName.text.isEmpty ||
                      dropdownCategory.isEmpty ||
                      dropdownBrands.isEmpty ||
                      _Description.text.isEmpty ||
                      _PriceAED.text.isEmpty ||
                      imageurl.isEmpty

                  ) {

                    Fluttertoast.showToast(
                      msg: "Please fill in all fields",
                     // toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black87,
                      textColor: Colors.red,
                      fontSize: 16.0,
                    );
                  } else {

                    var ProdName = _ProductName.text.toString();
                    var category = dropdownCategory.split(" ")[0].toString();
                    var brand = dropdownBrands.split(" ")[0].toString();
                    var description = _Description.text.toString();
                    var amount = _PriceAED.text.toString();
                    var email = _EmailID.text.toString();
                    var password = _PassWord.text.toString();
                    var offer = _offerControler.text.toString();
                    var imagebase = imageurl;

                    print("Product name.: ${ProdName}");
                    print("category.....: ${category}");
                    print("Brand........: ${brand}");
                    print("Description..: ${description}");
                    print("Amount.......: ${amount}");
                    print("Email........: ${email}");
                    print("password.....: ${password}");
                    print("Base 64 url....: ${imagebase}");
                    print("User id  .....: ${user_id.$}");
                    print("Offer price  .....: ${offer}");
                    print("Offer Status  .....: ${offerstatus}");

                    place_ad_upload(ProdName,category,brand,imagebase,description,offer,amount,offerstatus,email,password);
///////////

//                     _ProductName.clear();
//                     _Description.clear();
//                     _PriceAED.clear();
//                     _EmailID.clear();
//                     _PassWord.clear();
//                     _offerControler.clear();

                  }
                }
                    : null,
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

  CategoryDropdown() {
    print("placead.dart, BrandDropdown(), dropdownBrands : ${dropdownCategory}");
    return DropdownButton2<dynamic>(
      hint: Text(dropdownCategory.split(" ")[1],style: TextStyle(color: Colors.black),),

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
        dropdownCategory = value;
        setState(() {
          print("Selected city is $value");
          dropdownCategory = value;
        });
      },
      items: categoryList.map((categories) {
        print("Brands List${dropdownCategory}");
        print("brands ID ${categories.id}");
        return DropdownMenuItem(
          value: "${categories.id.toString()+" "+categories.name.toString()}",
          child: Text(categories.name.toString(), style: TextStyle(fontSize: 14),),
        );
      }).toList(),
    );
  }


  BrandDropdown() {
    print("placead.dart, BrandDropdown(), dropdownBrands : ${dropdownBrands}");
    return DropdownButton2<dynamic>(
      hint: Text(dropdownBrands.split(" ")[1],style: TextStyle(color: Colors.black),),

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
        print("brands ID ${brands.id}");
        return DropdownMenuItem(
          value: "${brands.id.toString()+" "+brands.name.toString()}",
          child: Text(brands.name.toString(), style: TextStyle(fontSize: 14),),
        );
      }).toList(),
    );
  }


/*  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    List<XFile> xfilePick = pickedFiles;

    setState(() {
      if (xfilePick.isNotEmpty) {
        // Create a list to store base64 URLs
        List<String> base64Urls = [];

        for (var i = 0; i < xfilePick.length; i++) {
          selectedImages.add(File(xfilePick[i].path));

          // Convert the selected image to base64
          final bytes = File(xfilePick[i].path).readAsBytesSync();
          final base64String = base64Encode(bytes);
          base64Urls.add(base64String);

          // Print the base64 URL to the console
          print('Base64 URL for Image $i: data:image/jpeg;base64,$base64String');
        }

        // Concatenate the base64Urls into a single string, separated by a delimiter (e.g., comma)
       // imageurl = base64Urls.join(',');
        imageurl = base64Urls as String;

        // Now, baseall contains all the base64 URLs of selected images as a single string
        print('All Base64 URLs: $imageurl');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }*/


  Future<void> getImages() async {
    final pickedFile = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    List<XFile> xfilePick = pickedFile;

    setState(
          () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));

            // Convert the selected image to base64
            final bytes = File(xfilePick[i].path).readAsBytesSync();
            final base64String = base64Encode(bytes);
            imageurl= base64String;

            // Print the base64 URL to the console
            print('Base64 URL for Image $i: data:image/jpeg;base64,$base64String');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nothing is selected')),
          );
        }
      },
    );
  }


  // Future getImages() async {
  //   final pickedFile = await picker.pickMultiImage(
  //       imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
  //   List<XFile> xfilePick = pickedFile;
  //
  //
  //   setState(
  //         () {
  //       if (xfilePick.isNotEmpty) {
  //         for (var i = 0; i < xfilePick.length; i++) {
  //           selectedImages.add(File(xfilePick[i].path));
  //         }
  //
  //
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Nothing is selected')));
  //       }
  //     },
  //   );
  //
  //
  //
  //
  // }



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
//



//   onPressedUploadAd() async {
//     var ProdName = _ProductName.text.toString();
//     var Catg = _Category.text.toString();
//     var Brd = _Brand.text.toString();
//     var PriAED = _PriceAED.text.toString();
//     var MinOP = _MinOfferPrice.text.toString();
//     var Desc = _Description.text.toString();
//     var Email = _EmailID.text.toString();
//     var Pw = _PassWord.text.toString();
//     print("placead.dart, onPressedUploadAd(), Email : ${Email}");
//     var PAResponse = await PLACEADREPOSITORY()
//         .getPADResponse(ProdName, Catg, Brd, PriAED, MinOP, Desc,
//         Email, Pw);
//     print("placead.dart, onPressedUploadAd(), PAResponse : ${PAResponse}");
//     if (PAResponse.result == false) {
//       ToastComponent.showDialog(PAResponse.message,
//           gravity: Toast.center, duration: Toast.lengthLong);
//     } else {
//       print("placead.dart, onPressedUploadAd(), response : ${PAResponse.message}");
//       ToastComponent.showDialog(PAResponse.message,
//           gravity: Toast.center, duration: Toast.lengthLong);
//     }
//   }
//-----------------------------
  void delete(int index){
    setState(() {
      selectedImages.removeAt(index);
      print("tile number#$index is deleted");

    });
  }

   place_ad_upload(name,Category,Brand,baseurl,description,offer,amount,offerstatus,email,password) async {
    var url = Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/product/add');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 119|3aq0ANr2yFIptxxF62C5ndsuJZDAENLnDWk2bdsy'
    };

    var data = json.encode({
      "name": name,
      "user_id": user_id.$,
      "category_id":Category,
      "brand_id":Brand,
     // "thumbnail_img":"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",
      "thumbnail_img":baseurl,
      "filename": "5R5nQsgc0QyOw8XRFm7ZjCazPzGLNbHazHGWxQDO.jpg",
      "description":description,
      "min_offer_price": offer,
      "unit_price":amount,
      "moffer":offerstatus,
      "email":email,
      "password": password
    });

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(json.decode(response.body)));
        Fluttertoast.showToast(
          msg: "Product Add successfully",
          //toastLength:LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // You can change the position
          timeInSecForIosWeb: 1, // Duration in seconds the toast should be visible on iOS and web
          backgroundColor: Colors.black, // Background color of the toast
          textColor: Colors.green, // Text color of the toast message
          fontSize: 16.0, // Font size of the toast message
        );
      }
      else if (response.statusCode == 401) {
        print("Unauthorized user");
        Fluttertoast.showToast(
          msg: "Unauthorized user",
          //toastLength:LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // You can change the position
          timeInSecForIosWeb: 1, // Duration in seconds the toast should be visible on iOS and web
          backgroundColor: Colors.black, // Background color of the toast
          textColor: Colors.red, // Text color of the toast message
          fontSize: 16.0, // Font size of the toast message
        );
      }

      else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
} //State