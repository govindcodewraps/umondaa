/*
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hardware_lo/custom/device_info.dart';
import 'package:hardware_lo/my_theme.dart';
import 'package:hardware_lo/custom/useful_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardware_lo/repositories/brand_repository.dart';
import '../custom/btn.dart';
import '../data_model/AllCategoryResponse.dart';
import '../data_model/brand_response.dart';
import '../app_config.dart';
import '../helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;
import 'package:hardware_lo/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:hardware_lo/repositories/place_ad_repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../repositories/category_repository.dart';
import '../screens/PlaceAddScreen/checkboxplaceadd.dart';
import '../screens/common_webview_screen.dart';
import '../screens/registration.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';




class placead extends StatefulWidget {
  // const placead({super.key});

  // final List<allcategoryModel> itemList; // Note the "?" to indicate it can be null
  //
  // MyDropdown({required this.itemList});

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
  List<dynamic> ALLcategoryList = [];
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
  String selectedValue = '';
  //String globalResponseBody;
  //List<String> globalResponseBody = [];
  bool _customeIcon = false;
  String globalResponseBody;
  String globalResponseBo;



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
    fetchData();
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

  // fetch_Category() async {
  //   var categoryResponse = await CategoryRepository().getAllCategories();
  //   categoryList.addAll(categoryResponse);
  //   print("Category list : ${categoryResponse}");
  //   _filteredcategoryCalled = true;
  //   setState(() {});
  // }

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
                  // Text(globalResponseBody.toString()),
                  // listview(),
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




                  ExpansionTile(title: Text("Category"),

                    children: [

                      ListTile(
                        title: InkWell(onTap: (){
                        },
                          child:
                          Container(
                              height: 500,
                              padding: EdgeInsets.only(left: 16,right: 16),
                              child: CheckboxListScreen()),

                        ),
                      )
                    ],

                    onExpansionChanged: (bool expanded){
                      // setState(() => _customeIcon = expanded);
                    },

                  ),









                  // ExpansionTile(title: Text("Category"),
                  //   // trailing: Icon(
                  //   //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                  //   // ),
                  //   children: [
                  //     // ListTile(
                  //     //   title: Text("This is tile number 2"),
                  //     // ),
                  //     ListTile(
                  //       title: InkWell(onTap: (){
                  //         // print("Hellooooo${globalResponseBody}");
                  //       },
                  //           child:
                  //
                  //           listview(),
                  //
                  //       ),
                  //     )
                  //   ],
                  //
                  //   onExpansionChanged: (bool expanded){
                  //     // setState(() => _customeIcon = expanded);
                  //   },
                  //
                  // ),





                  */
/* ExpansionTile(title: Text("Sub Category"),
                    // trailing: Icon(
                    //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                    // ),
                    children: [
                      // ListTile(
                      //   title: Text("This is tile number 2"),
                      // ),
                      ListTile(
                        title: InkWell(onTap: (){
                          // print("Hellooooo${globalResponseBody}");
                        },
                          child:

                          childrenCategories(),

                        ),
                      )
                    ],

                    onExpansionChanged: (bool expanded){
                      // setState(() => _customeIcon = expanded);
                    },

                  ),*//*




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
                            height: 150,
                            //width: 20,
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
                                        // width: 200,
                                        height: 150,
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


          if (is_logged_in.$ == false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
              ],
            ),

          */
/*    Padding(
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
          ),*//*


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
        print("brands IDDD ${categories}");
        // print("brands IDDD ${[0].children_categoriecategoriess}");
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
      Uri.parse('${AppConfig.BASE_URL}/product/add'),
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

    });

    for(var i=0;i<imageUrls.length;i++)
    {
      request.files.add(await http.MultipartFile.fromPath('thumbnail_img[]', imageUrls[i],));


    }

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
  Widget listview() {
    return
      Column(
        children: [
          ExpansionTile(title: Text("Sub Category"),
            // trailing: Icon(
            //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
            // ),
            children: [
              // ListTile(
              //   title: Text("This is tile number 2"),
              // ),
              ExpansionTile(title: Text("Sub child Category"),
                // trailing: Icon(
                //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                // ),
                children: [
                  // ListTile(
                  //   title: Text("This is tile number 2"),
                  // ),
                  ListTile(
                    title: InkWell(onTap: (){
                      // print("Hellooooo${globalResponseBody}");
                    },
                      child:

                      childCategories(),

                    ),
                  )
                ],

                onExpansionChanged: (bool expanded){
                  // setState(() => _customeIcon = expanded);
                },

              ),

              ListTile(
                title: InkWell(onTap: (){
                  // print("Hellooooo${globalResponseBody}");
                },
                  child:

                  childrenCategories(),

                ),
              )
            ],

            onExpansionChanged: (bool expanded){
              // setState(() => _customeIcon = expanded);
            },

          ),

          FutureBuilder(
              future: fetchData(),

              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return
                    Container(
                      //padding: EdgeInsets.only(top: 23),
                      child:

                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [
                                      // Text(snapshot.data[index].childrenCategories[0].name.toString()),


                                      MultiSelectContainer(items: [
                                        MultiSelectCard(value: snapshot.data[index].id.toString(), label:snapshot.data[index].name.toString(),),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print("ALL Categories>>>>>>>>>>>${allSelectedItems}");
                                        print(selectedItem);
                                      }),


                                      // MultiSelectContainer(items: [
                                      //   //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                      //   MultiSelectCard(value: snapshot.data[index].childrenCategories[index].name.toString(), label:snapshot.data[index].childrenCategories[index].name.toString()),
                                      // ], onChange: (allSelectedItems, selectedItem) {
                                      //   print(allSelectedItems);
                                      //   print(selectedItem);
                                      // }),


                                      // MultiSelectContainer(items: [
                                      //   //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                      //   MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories[index].name.toString(), label:snapshot.data[index].childrenCategories[0].categories[index].name.toString()),
                                      //   //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories[index].name.toString(), label:snapshot.data[index].childrenCategories[0].categories[index].name.toString()),
                                      // ], onChange: (allSelectedItems, selectedItem) {
                                      //   print(allSelectedItems);
                                      //   print(selectedItem);
                                      // }),

                                    ],

                                  );

                                },
                                //itemCount: 2,
                                itemCount: snapshot.data.length,
                                // itemCount: snapshot.data.childrenCategories[0].categories.length,
                              ),


                              */
/* ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [
                                      MultiSelectContainer(items: [
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[0].name.toString(), label:snapshot.data[index].childrenCategories[0].name.toString(),),
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[0].name.toString(), label:snapshot.data[index].childrenCategories[0].name.toString(),),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print(allSelectedItems);
                                        print(selectedItem);
                                      }),


                                    ],

                                  );
                                  //Text(snapshot.data[index].childrenCategories[1].name.toString()),
                                },
                                itemCount: 5,
                                //itemCount: snapshot.data.length,
                              ),*//*



                              // GridView.count(
                              //   crossAxisCount: 3,
                              //   crossAxisSpacing: 4.0,
                              //   mainAxisSpacing: 8.0,
                              //   children: List.generate(snapshot.data.length, (index) {
                              //     return Center(
                              //       child: Text(snapshot.data[index].id.toString()) ,
                              //     );
                              //   }
                              //   )
                              // )


                              // GridView.builder(
                              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2, // Number of columns
                              //     // crossAxisSpacing: 10.0, // Spacing between columns
                              //     // mainAxisSpacing: 10.0, // Spacing between rows
                              //   ),
                              //   itemCount: snapshot.data.length, // Number of items in the grid
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return MultiSelectContainer(items: [
                              //       MultiSelectCard(value: snapshot.data[index].id.toString(), label:snapshot.data[index].name.toString(),),
                              //     ], onChange: (allSelectedItems, selectedItem) {
                              //       print(allSelectedItems);
                              //       print(selectedItem);
                              //     });
                              //   },
                              // ),






                            ],
                          ),


                        ],
                      ),


                      // ListView.builder(
                      //
                      //   shrinkWrap: true,
                      //   //physics:  NeverScrollableScrollPhysics(),
                      //   itemBuilder: (context, int index) {
                      //     return  Column(
                      //       children: [
                      //         Text(snapshot.data[index].name.toString()),
                      //         //Text(snapshot.data[index].children_categories[0].name.toString()),
                      //         //Text(snapshot.data[index].children_categories[index].name.toString()),
                      //       ],
                      //     );
                      //   },
                      //   //itemCount: 17,
                      //   itemCount: snapshot.data.length,
                      // ),
                    );
                }
                else{
                  return
                    Container(
                        child: Center(child: CircularProgressIndicator()));
                }
              }
          ),


        ],
      );
  }

  Widget childrenCategories() {
    return
      Column(
        children: [

          FutureBuilder(
              future: fetchData(),

              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return
                    Container(
                      //padding: EdgeInsets.only(top: 23),
                      child:

                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [
                                      // Text(snapshot.data[index].childrenCategories[0].name.toString()),


                                      // MultiSelectContainer(items: [
                                      //   MultiSelectCard(value: snapshot.data[index].id.toString(), label:snapshot.data[index].name.toString(),),
                                      // ], onChange: (allSelectedItems, selectedItem) {
                                      //   print(allSelectedItems);
                                      //   print(selectedItem);
                                      // }),

                                      MultiSelectContainer(items: [
                                        //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[index].id.toString(), label:snapshot.data[index].childrenCategories[index].name.toString()),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print("childrenCategories>>>>>>>>>>>${allSelectedItems}");
                                        print(selectedItem);
                                      }),


                                      // MultiSelectContainer(items: [
                                      //   //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                      //   MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories[index].name.toString(), label:snapshot.data[index].childrenCategories[0].categories[index].name.toString()),
                                      //   //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories[index].name.toString(), label:snapshot.data[index].childrenCategories[0].categories[index].name.toString()),
                                      // ], onChange: (allSelectedItems, selectedItem) {
                                      //   print(allSelectedItems);
                                      //   print(selectedItem);
                                      // }),

                                    ],

                                  );

                                },
                                itemCount: 2,
                                //itemCount: snapshot.data.length,
                                // itemCount: snapshot.data.childrenCategories[0].categories.length,
                              ),


                              */
/* ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [
                                      MultiSelectContainer(items: [
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[0].name.toString(), label:snapshot.data[index].childrenCategories[0].name.toString(),),
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[0].name.toString(), label:snapshot.data[index].childrenCategories[0].name.toString(),),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print(allSelectedItems);
                                        print(selectedItem);
                                      }),


                                    ],

                                  );
                                  //Text(snapshot.data[index].childrenCategories[1].name.toString()),
                                },
                                itemCount: 5,
                                //itemCount: snapshot.data.length,
                              ),*//*



                              // GridView.count(
                              //   crossAxisCount: 3,
                              //   crossAxisSpacing: 4.0,
                              //   mainAxisSpacing: 8.0,
                              //   children: List.generate(snapshot.data.length, (index) {
                              //     return Center(
                              //       child: Text(snapshot.data[index].id.toString()) ,
                              //     );
                              //   }
                              //   )
                              // )


                              // GridView.builder(
                              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2, // Number of columns
                              //     // crossAxisSpacing: 10.0, // Spacing between columns
                              //     // mainAxisSpacing: 10.0, // Spacing between rows
                              //   ),
                              //   itemCount: snapshot.data.length, // Number of items in the grid
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return MultiSelectContainer(items: [
                              //       MultiSelectCard(value: snapshot.data[index].id.toString(), label:snapshot.data[index].name.toString(),),
                              //     ], onChange: (allSelectedItems, selectedItem) {
                              //       print(allSelectedItems);
                              //       print(selectedItem);
                              //     });
                              //   },
                              // ),






                            ],
                          ),


                        ],
                      ),


                      // ListView.builder(
                      //
                      //   shrinkWrap: true,
                      //   //physics:  NeverScrollableScrollPhysics(),
                      //   itemBuilder: (context, int index) {
                      //     return  Column(
                      //       children: [
                      //         Text(snapshot.data[index].name.toString()),
                      //         //Text(snapshot.data[index].children_categories[0].name.toString()),
                      //         //Text(snapshot.data[index].children_categories[index].name.toString()),
                      //       ],
                      //     );
                      //   },
                      //   //itemCount: 17,
                      //   itemCount: snapshot.data.length,
                      // ),
                    );
                }
                else{
                  return
                    Container(
                        child: Center(child: CircularProgressIndicator()));
                }
              }
          ),

        ],
      );
  }
  Widget childCategories() {
    return
      Column(
        children: [

          FutureBuilder(
              future: fetchData(),

              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return
                    Container(
                      //padding: EdgeInsets.only(top: 23),
                      child:

                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [

                                      MultiSelectContainer(items: [
                                        //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[index].categories[index].id.toString(), label:snapshot.data[index].childrenCategories[index].categories[index].name.toString()),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print("categoriesCategories>>>>>>>>>>>${allSelectedItems}");
                                        print(selectedItem);
                                      }),


                                    ],

                                  );
                                },
                                itemCount: 2,
                                // itemCount: snapshot.data.childrenCategories.categories.length,
                                // itemCount: snapshot.data.childrenCategories[0].categories.length,
                              ),

                            ],
                          ),
                        ],
                      ),

                    );
                }
                else{
                  return
                    Container(
                        child: Center(child: CircularProgressIndicator()));
                }
              }
          ),
        ],
      );
  }

  Future<List<allcategoryModel>> fetchData() async {
    var url = Uri.parse('${AppConfig.BASE_URL}/all-categories');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      globalResponseBody = response.body; // Assign the response body to the global variable
      List<dynamic> jsonList = json.decode(globalResponseBody);
      List<allcategoryModel> itemList = jsonList.map((json) => allcategoryModel.fromJson(json)).toList();
      print("allcategoryModel Response > $globalResponseBody");

      return itemList;
    } else {
      throw Exception('Failed to load data');
    }
  }




}
*/



import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hardware_lo/custom/device_info.dart';
import 'package:hardware_lo/my_theme.dart';
import 'package:hardware_lo/custom/useful_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:hardware_lo/repositories/brand_repository.dart';
import '../custom/btn.dart';
import '../data_model/AllCategoryResponse.dart';
import '../data_model/brand_response.dart';
import '../app_config.dart';
import '../helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;
import 'package:hardware_lo/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:hardware_lo/repositories/place_ad_repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../repositories/category_repository.dart';
import '../screens/PlaceAddScreen/checkboxplaceadd.dart';
import '../screens/common_webview_screen.dart';
import '../screens/login.dart';
import '../screens/registration.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../data_model/Sub_Category_List_Model.dart';




class placead extends StatefulWidget {
  String catevale;

  //final String? mobile,namee;

  placead({Key key,this.catevale}) : super(key: key);
  // const placead({super.key});

  // final List<allcategoryModel> itemList; // Note the "?" to indicate it can be null
  //
  // MyDropdown({required this.itemList});

  @override
  State<placead> createState() => _placeadState();
}

class _placeadState extends State<placead> {
  bool _obscureText = true;
  bool _isUploading = false;
  bool _isAgree = false;
  bool light = false, isChecked = true;
  bool _filteredBrandsCalled = false;
  bool _filteredcategoryCalled = false;
  // List<File> selectedImages = [];
  List<File> basee = [];
  List<dynamic> brandsList = [];
  List<dynamic> categoryList = [];
  List<dynamic> ALLcategoryList = [];
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
  String selectedValue = '';
  //String globalResponseBody;
  //List<String> globalResponseBody = [];
  bool _customeIcon = false;
  String globalResponseBody;
  String globalResponseBo;







  TextEditingController _ProductName = TextEditingController();
  TextEditingController _Category = TextEditingController();
  TextEditingController _Brand = TextEditingController();
  TextEditingController _PriceAED = TextEditingController();
  TextEditingController _MinOfferPrice = TextEditingController();
  TextEditingController _Description = TextEditingController();
  TextEditingController _EmailID = TextEditingController();
  TextEditingController _PassWord = TextEditingController();
  TextEditingController _offerControler = TextEditingController();


  List<bool> isCheckedList = [];
  List<bool> isCheckedSubList = [];
  List<bool> isCheckedSubchildList = [];
  List<bool> isCheckedList2 = [];
  List<allcategoryModel> itemList = [];
  List<SubCategoryListModel> SubitemList = [];
  List<SubCategoryListModel> SubchildList = [];
  List<ChildrenCategories> itemList2 = [];
  //bool isChecked = false;
  String ProductID;
  String subchildproductID;
  Map<String,List<SubCategoryListModel>> subCatMap={};
  List<String> selectedProductIDs = [];




  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  //   //SubchildListt();
  //   //subcategorylist();
  //   printSelectedItems();
  // }



  @override
  void initState() {
    fetch_Brands();
    fetch_Category();
    fetchData();
    fetchDataa();


    //fetchFilteredBrands();
    //SubchildListt();
    //subcategorylist();
 /*   if (is_logged_in.$ == true) {
      fetchData();
      fetchDataa();
      fetch_Brands();
      fetch_Category();
      buildBody();
    }*/

    printSelectedItems();
    super.initState();
  }



  fetch_Brands() async {
    var filteredBrandResponse = await BrandRepository().getFilterPageBrands();
    brandsList.addAll(filteredBrandResponse.brands);
    print("placead.dart, fetch_Brands(), brandsList : ${filteredBrandResponse.brands}");
    _filteredBrandsCalled = true;
    setState(() {});
  }

  // fetch_Category() async {
  //   var categoryResponse = await CategoryRepository().getAllCategories();
  //   categoryList.addAll(categoryResponse);
  //   print("Category list : ${categoryResponse}");
  //   _filteredcategoryCalled = true;
  //   setState(() {});
  // }

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

    print("Govind>>>>> ${ProductID}");

    print("Selected ProductIDs>>>>>>>>>>>>: $selectedProductIDs");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          // Text(widget.catevale),
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
    return
      // is_logged_in.$ == false?
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())):

      ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  // Text(globalResponseBody.toString()),
                  // listview(),


                  // Text('Selected Product IDs: ${widget.selectedProductIDs.join(', ')}'),


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




                  ExpansionTile(title: Text("Category"),

                    children: [

                      /* ListTile(
                        title: InkWell(onTap: (){
                        },
                          child:
                          Container(
                              height: 500,
                              padding: EdgeInsets.only(left: 16,right: 16),
                              child: CheckboxListScreen()),

                        ),
                      ),*/
                      ListTile(
                        title: InkWell(onTap: (){
                        },
                          child:
                          Container(
                            height: 500,
                            padding: EdgeInsets.only(left: 16,right: 16),
                            child:

                            Column(
                              children: [
                                //Text("mmmmmmmmmm"),
                                Expanded(
                                  child: itemList.isEmpty
                                      ? Center(child: CircularProgressIndicator())
                                      : ListView.builder(
                                    itemCount: itemList.length,
                                    itemBuilder: (context, index) {
                                      final item = itemList[index];
                                      return
                                        Column(
                                          children: [
                                            ListTile(
                                              leading: Checkbox(
                                                value: isCheckedList[index],
                                                onChanged: (bool newValue) {
                                                  // setState(() {
                                                  //   isCheckedList[index] = newValue;
                                                  //   printSelectedItems();
                                                  //   ProductID=item.id.toString();
                                                  //   print("print id"+ProductID);
                                                  //   subcategorylist();
                                                  //   print(subCatMap);
                                                  //
                                                  // });

                                                  setState(() {

                                                    isCheckedList[index] = newValue;
                                                    if (newValue) {
                                                      selectedProductIDs.add(item.id.toString());
                                                    } else {
                                                      selectedProductIDs.remove(item.id.toString());
                                                    }
                                                    ProductID = item.id.toString();
                                                    subcategorylist();
                                                  });

                                                },
                                              ),
                                              title: Text(item.name.toString()),
                                            ),

                                            if(isCheckedList[index])
                                              SubitemList.isEmpty
                                                  ? Center(child: CircularProgressIndicator())
                                                  : Column(children: [

                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context , int index){
                                                    return Column(children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 25),
                                                        child: ListTile(
                                                          leading: Checkbox(
                                                            value: isCheckedSubList[index],
                                                            onChanged: (bool newValue) {
                                                              setState(() {
                                                                isCheckedSubList[index] = newValue;
                                                                if (newValue) {
                                                                  selectedProductIDs.add(SubitemList[index].id.toString());
                                                                } else {
                                                                  selectedProductIDs.remove(SubitemList[index].id.toString());

                                                                }
                                                                subchildproductID=SubitemList[index].id.toString();
                                                                print("print idd"+subchildproductID);
                                                                SubchildListt();
                                                                //printSelectedItems();
                                                                printSelectedSubItems();
                                                              });
                                                            },
                                                          ),
                                                          // title:Text(SubitemList[index].id.toString() ??""),
                                                          title:Text(SubitemList[index].name.toString() ??""),

                                                        ),
                                                      ),

                                                      if(isCheckedSubList[index])

                                                        SubchildList.isEmpty
                                                            ? Center(child: CircularProgressIndicator())
                                                            :  Column(children: [

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 40),
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context , int index){
                                                                return Column(children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 25),
                                                                    child: ListTile(
                                                                      leading: Checkbox(
                                                                        value:isCheckedSubchildList[index],
                                                                        onChanged: (bool newValue) {
                                                                          setState(() {
                                                                            isCheckedSubchildList[index] = newValue;
                                                                            if (newValue) {
                                                                              selectedProductIDs.add(SubchildList[index].id.toString());
                                                                            } else {
                                                                              selectedProductIDs.remove(SubchildList[index].id.toString());
                                                                            }
                                                                            //printSelectedItems();
                                                                            printSelectedSubchildItems();
                                                                          });
                                                                        },
                                                                      ),
                                                                      // title:Text(SubitemList[index].id.toString() ??""),
                                                                      title:Text(SubchildList[index].name.toString() ??""),

                                                                    ),
                                                                  ),
                                                                ],);

                                                              },
                                                              //itemCount: item.childrenCategories[index].categories.length,
                                                              //itemCount: SubitemList.length,
                                                              itemCount: SubchildList.length,
                                                            ),
                                                          ),


                                                        ],)

                                                    ],);

                                                  },
                                                  //itemCount: item.childrenCategories[index].categories.length,
                                                  //itemCount: SubitemList.length,
                                                  itemCount: SubitemList.length,
                                                ),


                                              ],),






                                          ],
                                        );
                                    },
                                  ),
                                ),
                              ],
                            ),

                          ),

                        ),
                      ),
                    ],

                    onExpansionChanged: (bool expanded){
                      // setState(() => _customeIcon = expanded);
                    },

                  ),
                  Divider(color: Colors.black,thickness: 1,),









                  // ExpansionTile(title: Text("Category"),
                  //   // trailing: Icon(
                  //   //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                  //   // ),
                  //   children: [
                  //     // ListTile(
                  //     //   title: Text("This is tile number 2"),
                  //     // ),
                  //     ListTile(
                  //       title: InkWell(onTap: (){
                  //         // print("Hellooooo${globalResponseBody}");
                  //       },
                  //           child:
                  //
                  //           listview(),
                  //
                  //       ),
                  //     )
                  //   ],
                  //
                  //   onExpansionChanged: (bool expanded){
                  //     // setState(() => _customeIcon = expanded);
                  //   },
                  //
                  // ),





                  /* ExpansionTile(title: Text("Sub Category"),
                    // trailing: Icon(
                    //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                    // ),
                    children: [
                      // ListTile(
                      //   title: Text("This is tile number 2"),
                      // ),
                      ListTile(
                        title: InkWell(onTap: (){
                          // print("Hellooooo${globalResponseBody}");
                        },
                          child:

                          childrenCategories(),

                        ),
                      )
                    ],

                    onExpansionChanged: (bool expanded){
                      // setState(() => _customeIcon = expanded);
                    },

                  ),*/



                  /*          Container(
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

                  ),*/



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
                            height: 150,
                            //width: 20,
                            child: selectedImages.isEmpty
                                ?  Center(child: Text('Sorry nothing selected!!'))
                                :
                            GridView.builder(
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
                                        // width: 200,
                                        height: 150,
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
          if (_isUploading)
            Center(
              child: CircularProgressIndicator(),
            ),

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

          //listcategori(),



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


          // if (is_logged_in.$ == false)
          //
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Container(
          //         margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
          //         child: Card(
          //           elevation: 10,
          //           child: Column(
          //             children: [
          //               Container(
          //                   margin: const EdgeInsets.fromLTRB(5, 16, 0, 0),
          //                   child: const Align(
          //                     alignment: Alignment.topLeft,
          //                     child: Text("User Details",
          //                         style: TextStyle(fontSize: 14,
          //                             color: Color.fromARGB(255, 0, 0, 0))),
          //                   )
          //               ),
          //               Container(
          //                 margin: const EdgeInsets.fromLTRB(5, 12, 0, 0),
          //                 child: TextField(
          //                   controller: _EmailID,
          //                   autofocus: false,
          //                   enableSuggestions: false,
          //                   autocorrect: false,
          //                   decoration: const InputDecoration(
          //                     border: UnderlineInputBorder(),
          //                     labelText: 'Email',
          //                   ),
          //                 ),
          //               ),
          //
          //               Container(
          //                 margin: const EdgeInsets.fromLTRB(5, 12, 0, 0),
          //                 child:
          //                 TextFormField(
          //                   controller: _PassWord,
          //                   obscureText: _obscureText,
          //                   decoration: InputDecoration(
          //                     labelText: 'Password',
          //                     suffixIcon: GestureDetector(
          //                       onTap: () {
          //                         setState(() {
          //                           _obscureText = !_obscureText;
          //                         });
          //                       },
          //                       child: _obscureText
          //                           ? Icon(Icons.visibility
          //                         // Feather.eye_off, // Use Feather for Flutter icons
          //                       )
          //                           : Icon(
          //                           Icons.visibility_off
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //
          //
          //             ],
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding:  EdgeInsets.only(top: 20.0,right:16),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             Text(
          //               "Don't have an account ?",
          //               style: TextStyle(color: MyTheme.font_grey, fontSize: 12),
          //             ),
          //             SizedBox(
          //               width: 10,
          //             ),
          //             InkWell(
          //               child: Text(
          //                 AppLocalizations.of(context).sign_up_ucf,
          //                 style: TextStyle(
          //                     color: MyTheme.accent_color,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w600),
          //               ),
          //               onTap: () {
          //                 Navigator.push(context,
          //                     MaterialPageRoute(builder: (context) {
          //                       return Registration();
          //                     }));
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),







          /*    Padding(
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
          ),*/

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



          //TESTING BUTTON
       /*   ElevatedButton(onPressed: (){
            var category = dropdownCategory.split(" ")[0].toString();
            print("category.....: ${category}");
            var category2 = selectedProductIDs;
            //selectedProductIDs=', '.join(map(str, my_list));
            print("category check box.....: ${category2}");
            String result = selectedProductIDs.map((item) => item.toString()).join(', ');

            print("category  remove square.....: ${result}");


            String selectedProduct = selectedProductIDs.map((item) => item.toString()).join(',').replaceAll(', ', ',');

            print("category  remove square renove space....:${selectedProduct}");



          }, child: Text("DATAAA")),*/



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

                  // Uncheck all checked items when the "Upload" button is pressed





                  if (_ProductName.text.isEmpty ||
                      dropdownCategory.isEmpty ||
                      dropdownBrands.isEmpty ||
                      _Description.text.isEmpty ||
                      _PriceAED.text.isEmpty
                  //allurlss.isEmpty

                  )



                  {
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
                    String selectedProduct = selectedProductIDs.map((item) => item.toString()).join(',').replaceAll(', ', ',');

                    print("category  remove square renove space....:${selectedProduct}");

                    var ProdName = _ProductName.text.toString();
                    // var category = dropdownCategory.split(" ")[0].toString();
                   // var category = selectedProductIDs;
                    var category = selectedProduct;
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
        print("brands IDDD ${categories}");
        // print("brands IDDD ${[0].children_categoriecategoriess}");
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

    setState(() {
      _isUploading = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_access_token_here', // Replace with your actual token
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConfig.BASE_URL}/product/add'),
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

    });

    for(var i=0;i<imageUrls.length;i++)
    {
      request.files.add(await http.MultipartFile.fromPath('thumbnail_img[]', imageUrls[i],));


    }

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

        _ProductName.clear();
        _Description.clear();
        _PriceAED.clear();
        _EmailID.clear();
        _PassWord.clear();
        _offerControler.clear();

        for (int i = 0; i < isCheckedList.length; i++) {
          isCheckedList[i] = false;
        }
        setState(() {
          printSelectedItems();
          _isAgree = false;
          isEnabled = false;
          selectedImages.clear();
          dropdownBrands =  dropdownBrands="Select Select_Brand";
        });


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
        Fluttertoast.showToast(
          msg: "Unauthorized fields",
          //toastLength:LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // You can change the position
          timeInSecForIosWeb: 1, // Duration in seconds the toast should be visible on iOS and web
          backgroundColor: Colors.black, // Background color of the toast
          textColor: Colors.red, // Text color of the toast message
          fontSize: 16.0, // Font size of the toast message
        );
      }
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      _isUploading = false;
    });
  }
  Widget listview() {
    return
      Column(
        children: [
          ExpansionTile(title: Text("Sub Category"),
            // trailing: Icon(
            //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
            // ),
            children: [
              // ListTile(
              //   title: Text("This is tile number 2"),
              // ),
              ExpansionTile(title: Text("Sub child Category"),
                // trailing: Icon(
                //   _customeIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                // ),
                children: [
                  // ListTile(
                  //   title: Text("This is tile number 2"),
                  // ),
                  ListTile(
                    title: InkWell(onTap: (){
                      // print("Hellooooo${globalResponseBody}");
                    },
                      child:

                      childCategories(),

                    ),
                  )
                ],

                onExpansionChanged: (bool expanded){
                  // setState(() => _customeIcon = expanded);
                },

              ),

              ListTile(
                title: InkWell(onTap: (){
                  // print("Hellooooo${globalResponseBody}");
                },
                  child:

                  childrenCategories(),

                ),
              )
            ],

            onExpansionChanged: (bool expanded){
              // setState(() => _customeIcon = expanded);
            },

          ),

          FutureBuilder(
              future: fetchData(),

              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return
                    Container(
                      //padding: EdgeInsets.only(top: 23),
                      child:

                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [
                                      // Text(snapshot.data[index].childrenCategories[0].name.toString()),

                                      MultiSelectContainer(items: [
                                        MultiSelectCard(value: snapshot.data[index].id.toString(), label:snapshot.data[index].name.toString(),),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print("ALL Categories>>>>>>>>>>>${allSelectedItems}");
                                        print(selectedItem);
                                      }),

                                    ],

                                  );

                                },
                                //itemCount: 2,
                                itemCount: snapshot.data.length,
                                // itemCount: snapshot.data.childrenCategories[0].categories.length,
                              ),


                            ],
                          ),


                        ],
                      ),

                    );
                }
                else{
                  return
                    Container(
                        child: Center(child: CircularProgressIndicator()));
                }
              }
          ),

        ],
      );
  }

  Widget childrenCategories() {
    return
      Column(
        children: [

          FutureBuilder(
              future: fetchData(),

              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return
                    Container(
                      //padding: EdgeInsets.only(top: 23),
                      child:

                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [
                                      // Text(snapshot.data[index].childrenCategories[0].name.toString()),


                                      // MultiSelectContainer(items: [
                                      //   MultiSelectCard(value: snapshot.data[index].id.toString(), label:snapshot.data[index].name.toString(),),
                                      // ], onChange: (allSelectedItems, selectedItem) {
                                      //   print(allSelectedItems);
                                      //   print(selectedItem);
                                      // }),

                                      MultiSelectContainer(items: [
                                        //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[index].id.toString(), label:snapshot.data[index].childrenCategories[index].name.toString()),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print("childrenCategories>>>>>>>>>>>${allSelectedItems}");
                                        print(selectedItem);
                                      }),


                                      // MultiSelectContainer(items: [
                                      //   //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                      //   MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories[index].name.toString(), label:snapshot.data[index].childrenCategories[0].categories[index].name.toString()),
                                      //   //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories[index].name.toString(), label:snapshot.data[index].childrenCategories[0].categories[index].name.toString()),
                                      // ], onChange: (allSelectedItems, selectedItem) {
                                      //   print(allSelectedItems);
                                      //   print(selectedItem);
                                      // }),

                                    ],

                                  );

                                },
                                itemCount: 2,
                                //itemCount: snapshot.data.length,
                                // itemCount: snapshot.data.childrenCategories[0].categories.length,
                              ),


                            ],
                          ),

                        ],
                      ),

                    );
                }
                else{
                  return
                    Container(
                        child: Center(child: CircularProgressIndicator()));
                }
              }
          ),

        ],
      );
  }
  Widget childCategories() {
    return
      Column(
        children: [

          FutureBuilder(

              future: fetchData(),

              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return
                    Container(
                      //padding: EdgeInsets.only(top: 23),
                      child:

                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context , int index){
                                  return Column(
                                    children: [

                                      MultiSelectContainer(items: [
                                        //MultiSelectCard(value: snapshot.data[index].childrenCategories[0].categories.length.toString(), label:snapshot.data[index].childrenCategories[0].categories.length.toString()),
                                        MultiSelectCard(value: snapshot.data[index].childrenCategories[index].categories[index].id.toString(), label:snapshot.data[index].childrenCategories[index].categories[index].name.toString()),
                                      ], onChange: (allSelectedItems, selectedItem) {
                                        print("categoriesCategories>>>>>>>>>>>${allSelectedItems}");
                                        print(selectedItem);
                                      }),


                                    ],

                                  );
                                },
                                itemCount: 2,
                                // itemCount: snapshot.data.childrenCategories.categories.length,
                                // itemCount: snapshot.data.childrenCategories[0].categories.length,
                              ),

                            ],
                          ),
                        ],
                      ),

                    );
                }
                else{
                  return
                    Container(
                        child: Center(child: CircularProgressIndicator()));
                }
              }
          ),
        ],
      );
  }

  Future<List<allcategoryModel>> fetchData() async {
    var url = Uri.parse('${AppConfig.BASE_URL}/all-categories');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      globalResponseBody = response.body; // Assign the response body to the global variable
      List<dynamic> jsonList = json.decode(globalResponseBody);
      List<allcategoryModel> itemList = jsonList.map((json) => allcategoryModel.fromJson(json)).toList();
      print("allcategoryModel Response > $globalResponseBody");

      return itemList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Check box


  Future<void> fetchDataa() async {
    var url = Uri.parse('${AppConfig.BASE_URL}/all-categories');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      itemList = jsonList.map((json) => allcategoryModel.fromJson(json)).toList();
      setState(() {
        isCheckedList = List<bool>.filled(itemList.length, false);
      });
    }

    else {
      throw Exception('Failed to load data');
    }
  }




  Widget listcategori() {
    return
      FutureBuilder(
          future: fetchDataa(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                Container(

                  //padding: EdgeInsets.only(top: 23),
                  child:

                  ListView.builder(

                    shrinkWrap: true,
                    //physics:  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return

                        Column(children: [
                            Text(itemList[index].name.toString()),
                        ],);

                    },
                    itemCount: itemList.length,
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


  Future<void> subcategorylist() async {
    print("Govind ${ProductID}");
    var url = Uri.parse('${AppConfig.BASE_URL}/sub-category-list/$ProductID');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      SubitemList = jsonList.map((json) => SubCategoryListModel.fromJson(json)).toList();

      subCatMap[ProductID.toString()]= SubitemList;
      print("hello ${subCatMap["$ProductID"][0].name}");
      print("Sub category list ${response.body}");
      print("Sub category list ${SubitemList}");
      setState(() {
        isCheckedSubList = List<bool>.filled(SubitemList.length, false);
      });
    }

    else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> SubchildListt() async {
    print("sub child ${subchildproductID}");
    var url = Uri.parse('${AppConfig.BASE_URL}/sub-category-list/$subchildproductID');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      SubchildList = jsonList.map((json) => SubCategoryListModel.fromJson(json)).toList();
      setState(() {
        isCheckedSubchildList = List<bool>.filled(SubchildList.length, false);
      });
    }

    else {
      throw Exception('Failed to load data');
    }
  }

  void subCatList(int id,List list){
    //subCatMap["$id"]=list;
  }

  void printSelectedItems() {
    for (int i = 0; i < itemList.length; i++) {
      if (isCheckedList[i]) {
        print("Selected Item Name: ${itemList[i].id}");
        subchildproductID="${itemList[i].id}";
        ProductID = subchildproductID;
        print("Product id First ${ProductID}");
      }
    }
  }

  void printSelectedSubItems() {
    for (int i = 0; i < SubitemList.length; i++) {
      if (isCheckedSubList[i]) {
        print("Selected Item Namegg: ${SubitemList[i].id}");
        ProductID="${SubitemList[i].id}";
        print("Product id Second ${ProductID}");
      }
    }
  }

  void printSelectedSubchildItems() {
    for (int i = 0; i < SubchildList.length; i++) {
      if (isCheckedSubchildList[i]) {
        print("Selected Item Nameee: ${SubchildList[i].id}");
        ProductID="${SubchildList[i].id}";
        print("Product id Third ${ProductID}");
      }
    }
  }



}
