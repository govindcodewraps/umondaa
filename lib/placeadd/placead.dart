
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
 // List<File> selectedImages = [];
  List<File> basee = [];
  List<dynamic> brandsList = [];
  List<dynamic> categoryList = [];
  final picker = ImagePicker();
  String imageurl;
  String dropdownBrands = "Select Select_Brand";
  String dropdownCategory = "Select Select_Category";
  bool isEnabled = false;
  String offerstatus="0";
  String allurlss;
  String image;
  List<File> selectedImages = []; // List to hold selected image files
  List<String> imageUrls = [];
  List<String> base64Urls = [];


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
                      keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                      _PriceAED.text.isEmpty
                  //allurlss.isEmpty

                  ) {
                   print("images url${imageurl}");
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
                   // var imagebase = imageurl;
                    var imagebase = allurlss;
                    var userid = user_id.$;
                    //var imagebase = allurlss;

                    print("Product name.: ${ProdName}");
                    print("category.....: ${category}");
                    print("Brand........: ${brand}");
                    print("Description..: ${description}");
                    print("Amount.......: ${amount}");
                    print("Email........: ${email}");
                    print("password.....: ${password}");
                    print("****************************************************************");

                    print("Base 64 url....: ${imagebase}");
                    print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");

                    print("Base 64 url....: ${allurlss}");
                    print("****************************************************************");
                    print("User id  .....: ${user_id.$}");
                    print("Offer price  .....: ${offer}");
                    print("Offer Status  .....: ${offerstatus}");
                    print("URLLLLLLLL  .....: ${base64Urls}");
                    print("IMAGE_URLLLLL  .....: ${imageUrls}");
                    print("Select Images  .....: ${selectedImages}");


                    place_ad_upload(ProdName,category,brand,description,offer,amount,offerstatus,email,password);
///////////

                    _ProductName.clear();
                    _Description.clear();
                    _PriceAED.clear();
                    _EmailID.clear();
                    _PassWord.clear();
                    _offerControler.clear();

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



  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    setState(() {
      if (pickedFiles.isNotEmpty) {
        for (var i = 0; i < pickedFiles.length; i++) {
          selectedImages.add(File(pickedFiles[i].path));
          print("Select images${selectedImages}");
        }

        // Create a list to store image paths in the desired format
        List<String> imagePaths = [];

        // Append selected image paths to the list
        for (var image in selectedImages) {
          String imagePath = image.path.replaceAll('\\', '/');
          imagePaths.add(imagePath);
          imageUrls=imagePaths;
         // print('Selected Image Path: $imagePath');

        }
             // Convert the list to a comma-separated string
        // String formattedPaths = imagePaths.join(',');
        // allurlss = formattedPaths;


      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  void delete(int index){
    setState(() {
      selectedImages.removeAt(index);
      print("tile number#$index is deleted");

    });
  }



 // import 'package:http/http.dart' as http;
//place_ad_upload(ProdName,userid,category,brand,description,offer,amount,offerstatus,email,password);
  place_ad_upload(name,Category,Brand,description,offer,amount,offerstatus,email,password) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_access_token_here', // Replace with your actual token
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://webcluestechnology.com/demo/erp/umonda/api/v2/product/add'),
    );

    request.fields.addAll({

      'name': name,
      'user_id': user_id.$.toString(),
      'category_id':Category,
      'brand_id':Brand,
      'filename': 'welcome',
      'description': description,
      'min_offer_price':offer,
      'unit_price': amount,
      'moffer': offerstatus,
      'email':email,
      'password':password

      // 'name': name,
      // 'user_id':userid,
      // 'category_id':Category,
      // 'brand_id':Brand,
      // 'filename': 'products images',
      // 'description': description,
      // 'min_offer_price':offer,
      // 'unit_price':amount,
      // 'moffer': offerstatus,
      // 'email':email,
      // 'password':password,
    });

    for(var i=0;i<imageUrls.length;i++)
    {
      request.files.add(await http.MultipartFile.fromPath('thumbnail_img[]', imageUrls[i],));


    }
    // Add files to the request
    //uest.files.add(await http.MultipartFile.fromPath('thumbnail_img[]', '/C:/Users/hp/Pictures/Screenshots/Screenshot 2023-06-13 005720.png'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());

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
      else if(response.statusCode == 401)
        {
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
        print('HTTP Error: ${response.statusCode}');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}

