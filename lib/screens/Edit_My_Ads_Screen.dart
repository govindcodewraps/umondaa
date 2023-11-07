import 'dart:io';
import 'package:dio/dio.dart';
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
import '../data_model/Edit_My_ads_Model.dart';
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




class Edit_placead extends StatefulWidget {
  String Product_ID;

  //final String? mobile,namee;

  Edit_placead({Key key,this.Product_ID}) : super(key: key);
  // const placead({super.key});

  // final List<allcategoryModel> itemList; // Note the "?" to indicate it can be null
  //
  // MyDropdown({required this.itemList});

  @override
  State<Edit_placead> createState() => _Edit_placeadState();
}

class _Edit_placeadState extends State<Edit_placead> {
  bool _obscureText = true;

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
  String globalcategoryId ="0";







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
    editmyadsapicall();


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

        body: listvieww()
        //buildBody()
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

            child: Text('Edit Ad',
              style: TextStyle(color: Colors.black,),
            ),
          )

        ],
      ),
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
      Uri.parse('${AppConfig.BASE_URL}/product/update'),
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
      'password':password,
      'product_id': '326'

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
          msg: "Product Update successfully",
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



  Widget listvieww(){
    return
      FutureBuilder(
          future: editmyadsapicall(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              // final thumbnailImage = snapshot.data.data[index].thumbnailImage;
              return

                ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              // Text(widget.Product_ID),
                              // Text("GOVIND KUMAR"),



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


                                  // decoration: const InputDecoration(
                                  //   border: UnderlineInputBorder(),
                                  //   //labelText: 'Product Name',
                                  // ),
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                     // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                      // Text(),
                                      //   Center(child: photoUrl?
                                      //                                     Text( snapshot.data!.posts![0].userDetails![0].name ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                                      //                                     :Text("Name"),
                                      //                                     ),
                                      // hintText:photoUrl,

                                      hintText:snapshot.data.data[0].name.toString()?? ""
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
                                        child:

                                        Column(
                                          children: [
                                            //Text("mmmmmmmmmm"),

                                            Expanded(
                                              child: itemList.isEmpty
                                                  ? Center(child: CircularProgressIndicator())
                                                  : ListView.builder(
                                                 itemCount: itemList.length,
                                                //itemCount: 1,
                                                itemBuilder: (context, index) {
                                                  final item = itemList[index];

                                                  // Initialize checked state based on id
                                                  //isCheckedList[index] = [1, 72, 188, 298, 424, 440, 457, 472].contains(item.id);

                                                  // Check items with id equal to 1, 120, and 2
                                                 //${category}

                                                  print("GGGGGGG id $globalcategoryId");
                                                  if (globalcategoryId == item.id) {
                                                    isCheckedList[index] = true;
                                                  } else {
                                                    //isCheckedList[index] = false;
                                                  }

                                                  /*  print("GGGGGGG id ${globalcategoryId}");
                                                  if ([globalcategoryId].contains(item.id)) {
                                                    isCheckedList[index] = true;
                                                  } else {
                                                    //isCheckedList[index] = false;
                                                  }*/

                                                  return Column(
                                                    children: [


                                                        //print("object"),

                                                      ListTile(
                                                        leading: Checkbox(
                                                          value: isCheckedList[index],
                                                          onChanged: (bool newValue) {
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

                                                      //if (isCheckedList[index])
                                                        SubitemList.isEmpty
                                                            ? Center(child: CircularProgressIndicator())
                                                            : Column(


                                                          children: [


                                                            ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context, index) {

                                                                //SubitemList
                                                                if ([globalcategoryId].contains(SubitemList[index].id)) {
                                                                  isCheckedSubList[index] = true;
                                                                } else {
                                                                  //isCheckedList[index] = false;
                                                                }

                                                                return Column(

                                                                  children: [
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
                                                                              subchildproductID = SubitemList[index].id.toString();
                                                                              print("print idd" + subchildproductID);
                                                                              SubchildListt();
                                                                            });
                                                                          },
                                                                        ),
                                                                        title: Text(SubitemList[index].name.toString() ?? ""),
                                                                      ),
                                                                    ),

                                                                    if (isCheckedSubList[index])
                                                                      SubchildList.isEmpty
                                                                          ? Center(child: CircularProgressIndicator())
                                                                          : Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 40),
                                                                            child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                              itemBuilder: (context, index) {
                                                                                if ([globalcategoryId].contains(SubchildList[index].id)) {
                                                                                  isCheckedSubchildList[index] = true;
                                                                                } else {
                                                                                  //isCheckedList[index] = false;
                                                                                }
                                                                                return Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 25),
                                                                                      child: ListTile(
                                                                                        leading: Checkbox(
                                                                                          value: isCheckedSubchildList[index],
                                                                                          onChanged: (bool newValue) {
                                                                                            setState(() {
                                                                                              isCheckedSubchildList[index] = newValue;
                                                                                              if (newValue) {
                                                                                                selectedProductIDs.add(SubchildList[index].id.toString());
                                                                                              } else {
                                                                                                selectedProductIDs.remove(SubchildList[index].id.toString());
                                                                                              }
                                                                                              printSelectedSubchildItems();
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        title: Text(SubchildList[index].name.toString() ?? ""),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                              itemCount: SubchildList.length,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                  ],
                                                                );
                                                              },
                                                              itemCount: SubitemList.length,
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            )






                                            // Expanded(
                                            //   child: itemList.isEmpty
                                            //       ? Center(child: CircularProgressIndicator())
                                            //       : ListView.builder(
                                            //     itemCount: itemList.length,
                                            //     itemBuilder: (context, index) {
                                            //       final item = itemList[index];
                                            //       return
                                            //         Column(
                                            //           children: [
                                            //             ListTile(
                                            //               leading: Checkbox(
                                            //                 value: isCheckedList[index],
                                            //                 onChanged: (bool newValue) {
                                            //                   // setState(() {
                                            //                   //   isCheckedList[index] = newValue;
                                            //                   //   printSelectedItems();
                                            //                   //   ProductID=item.id.toString();
                                            //                   //   print("print id"+ProductID);
                                            //                   //   subcategorylist();
                                            //                   //   print(subCatMap);
                                            //                   //
                                            //                   // });
                                            //
                                            //                   setState(() {
                                            //
                                            //                     isCheckedList[index] = newValue;
                                            //                     if (newValue) {
                                            //                       selectedProductIDs.add(item.id.toString());
                                            //                     } else {
                                            //                       selectedProductIDs.remove(item.id.toString());
                                            //                     }
                                            //                     ProductID = item.id.toString();
                                            //                     subcategorylist();
                                            //                   });
                                            //
                                            //                 },
                                            //               ),
                                            //               title: Text(item.name.toString()),
                                            //             ),
                                            //
                                            //             if(isCheckedList[index])
                                            //               SubitemList.isEmpty
                                            //                   ? Center(child: CircularProgressIndicator())
                                            //                   : Column(children: [
                                            //
                                            //                 ListView.builder(
                                            //                   shrinkWrap: true,
                                            //                   physics: const NeverScrollableScrollPhysics(),
                                            //                   itemBuilder: (context , int index){
                                            //                     return Column(children: [
                                            //                       Padding(
                                            //                         padding: const EdgeInsets.only(left: 25),
                                            //                         child: ListTile(
                                            //                           leading: Checkbox(
                                            //                             value: isCheckedSubList[index],
                                            //                             onChanged: (bool newValue) {
                                            //                               setState(() {
                                            //                                 isCheckedSubList[index] = newValue;
                                            //                                 if (newValue) {
                                            //                                   selectedProductIDs.add(SubitemList[index].id.toString());
                                            //                                 } else {
                                            //                                   selectedProductIDs.remove(SubitemList[index].id.toString());
                                            //
                                            //                                 }
                                            //                                 subchildproductID=SubitemList[index].id.toString();
                                            //                                 print("print idd"+subchildproductID);
                                            //                                 SubchildListt();
                                            //                                 //printSelectedItems();
                                            //                                 printSelectedSubItems();
                                            //                               });
                                            //                             },
                                            //                           ),
                                            //                           // title:Text(SubitemList[index].id.toString() ??""),
                                            //                           title:Text(SubitemList[index].name.toString() ??""),
                                            //
                                            //                         ),
                                            //                       ),
                                            //
                                            //                       if(isCheckedSubList[index])
                                            //
                                            //                         SubchildList.isEmpty
                                            //                             ? Center(child: CircularProgressIndicator())
                                            //                             :  Column(children: [
                                            //
                                            //                           Padding(
                                            //                             padding: const EdgeInsets.only(left: 40),
                                            //                             child: ListView.builder(
                                            //                               shrinkWrap: true,
                                            //                               physics: const NeverScrollableScrollPhysics(),
                                            //                               itemBuilder: (context , int index){
                                            //                                 return Column(children: [
                                            //                                   Padding(
                                            //                                     padding: const EdgeInsets.only(left: 25),
                                            //                                     child: ListTile(
                                            //                                       leading: Checkbox(
                                            //                                         value:isCheckedSubchildList[index],
                                            //                                         onChanged: (bool newValue) {
                                            //                                           setState(() {
                                            //                                             isCheckedSubchildList[index] = newValue;
                                            //                                             if (newValue) {
                                            //                                               selectedProductIDs.add(SubchildList[index].id.toString());
                                            //                                             } else {
                                            //                                               selectedProductIDs.remove(SubchildList[index].id.toString());
                                            //                                             }
                                            //                                             //printSelectedItems();
                                            //                                             printSelectedSubchildItems();
                                            //                                           });
                                            //                                         },
                                            //                                       ),
                                            //                                       // title:Text(SubitemList[index].id.toString() ??""),
                                            //                                       title:Text(SubchildList[index].name.toString() ??""),
                                            //
                                            //                                     ),
                                            //                                   ),
                                            //                                 ],);
                                            //
                                            //                               },
                                            //                               //itemCount: item.childrenCategories[index].categories.length,
                                            //                               //itemCount: SubitemList.length,
                                            //                               itemCount: SubchildList.length,
                                            //                             ),
                                            //                           ),
                                            //
                                            //
                                            //                         ],)
                                            //
                                            //                     ],);
                                            //
                                            //                   },
                                            //                   //itemCount: item.childrenCategories[index].categories.length,
                                            //                   //itemCount: SubitemList.length,
                                            //                   itemCount: SubitemList.length,
                                            //                 ),
                                            //
                                            //
                                            //               ],),
                                            //
                                            //
                                            //
                                            //
                                            //
                                            //
                                            //           ],
                                            //         );
                                            //     },
                                            //   ),
                                            // ),
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
                                  decoration:  InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText:snapshot.data.data[0].mainPrice.toString()?? "",
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
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText:snapshot.data.data[0].description.toString()?? "",

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


                         ElevatedButton(onPressed: (){
                           String selectedProduct = selectedProductIDs.map((item) => item.toString()).join(',').replaceAll(', ', ',');


                           //product name
                           var ProdName = _ProductName.text.toString().isEmpty ? snapshot.data.data[0].name.toString():_ProductName.text.toString();
                           //categories
                           var category = selectedProduct.isEmpty ? snapshot.data.data[0].categoryId.toString():selectedProduct;
                           globalcategoryId= category;

                           //brandId
                           var brand = dropdownBrands.split(" ")[0].toString() == "Select" ?snapshot.data.data[0].brandId.toString():dropdownBrands.split(" ")[0].toString();
                           //description
                           var description = _Description.text.toString().isEmpty?snapshot.data.data[0].description.toString():_Description.text.toString();
                          //mainPrice
                           var amount = _PriceAED.text.toString() ==null ?snapshot.data.data[0].mainPrice.toString():_PriceAED.text.toString();
                           //
                           var email = _EmailID.text.toString();
                           var password = _PassWord.text.toString();
//minoffer
                           var offer = _offerControler.text.toString().isEmpty?snapshot.data.data[0].minOfferPrice.toString():_offerControler.text.toString();
                           // product images thumbnailImage
                           var imagebase = allurlss ==null ? snapshot.data.data[0].thumbnailImage.toString():allurlss;
                           var offerstatu= offerstatus.isEmpty? snapshot.data.data[0].minoffer.toString():offerstatus;


                           var userid = user_id.$;
                           //var imagebase = allurlss;


                           print("Product name.: ${ProdName}");
                           print("category.....: ${category}");
                           print("globalcategoryId category.....: ${globalcategoryId}");
                           print("Brandd........: ${brand}");
                           print("Description..: ${description}");
                           print("Amount.......: ${amount}");
                           print("Email........: ${email}");
                           print("password.....: ${password}");
                           print("****************************************************************");

                           print("Base 64 urlll....: ${imagebase}");
                           print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");

                           //print("Base 64 url....: ${allurlss}");
                           print("****************************************************************");
                           print("User id  .....: ${user_id.$}");
                           print("Offer price  .....: ${offer}");
                           print("Offer Status  .....: ${offerstatu}");
                           print("URLLLLLLLL  .....: ${base64Urls}");
                           print("IMAGE_URLLLLL  .....: ${imageUrls}");
                           print("Select Images  .....: ${selectedImages}");

                           // place_ad_upload(ProdName,category,brand,description,offer,amount,offerstatus,email,password);


          }, child: Text("DATAAA")),



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
                              "Update Ad",
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

                                //var ProdName = _ProductName.text.toString() == null ? snapshot.data.data[0].name.toString():Column();
                               // var ProdName =  snapshot.data.data[0].name.toString();
                                var ProdName = _ProductName.text.toString().isEmpty ? snapshot.data.data[0].name.toString():_ProductName.text.toString();
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


                               //place_ad_upload(ProdName,category,brand,description,offer,amount,offerstatus,email,password);
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



















                // Container(
                //   //padding: EdgeInsets.only(top: 23),
                //   child:
                //
                //   ListView.separated(
                //     separatorBuilder: (context, index) {
                //       // Your separator builder logic here
                //       return Divider(); // Example: Using a Divider as the separator
                //     },
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemBuilder: (context , int index){
                //       final thumbnailImage = snapshot.data.data[index].thumbnailImage;
                //       return
                //
                //         Column(children: [
                //         // Text("Govind"),
                //         InkWell(
                //           onTap: (){
                //             Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_placead()));
                //             //print("print product id")
                //             //product_Id=snapshot.data.data[index].id.toString();
                //             // print("print product id ${snapshot.data.data[index].id.toString()}");
                //             //print("print produc ${product_Id}");
                //           },
                //           child: Container(
                //             width: MediaQuery.of(context).size.width *1,
                //             padding: EdgeInsets.only(left: 10,right: 10),
                //             child: Row(
                //               children: [
                //                 Container(
                //                   decoration: BoxDecoration(
                //                       color: Colors.black,
                //                       borderRadius: BorderRadius.circular(12),
                //                       //border: Border.all(color: MyTheme.accent_color),
                //                       boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                //
                //                   ),
                //
                //                   height: 100,
                //                   width: MediaQuery.of(context).size.width *0.3,
                //                   //child: Image.asset("assets/silver.png",fit: BoxFit.fill,),
                //
                //
                //                   child:   thumbnailImage == null
                //                       ? Image.asset("assets/silver.png",fit: BoxFit.fill,)
                //                       : Image.network(thumbnailImage, fit: BoxFit.fill),
                //
                //                 ),
                //                 SizedBox(width: 10,),
                //                 Container(
                //                   padding: EdgeInsets.only(left: 16,top: 16),
                //                   decoration: BoxDecoration(
                //                       color: Colors.white,
                //                       borderRadius: BorderRadius.circular(12),
                //                       //border: Border.all(color: MyTheme.accent_color),
                //                       boxShadow: [BoxShadow(blurRadius: 10,color: Colors.grey,offset: Offset(1,3))]
                //                   ),
                //
                //                   height: 100,
                //                   width: MediaQuery.of(context).size.width *0.6,
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Text(snapshot.data.data[index].name.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                //                       SizedBox(height: 5,),
                //                       Text(snapshot.data.data[index].mainPrice.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                //                       //Text(snapshot.data.data[index].links[0].details.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
                //                     ],),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],);
                //
                //     },
                //     //itemCount: 51,
                //     itemCount: snapshot.data.data.length,
                //   ),
                //
                //
                // );
            }
            else{
              return
                Container(
                    child: Center(child: CircularProgressIndicator()));
            }
          }
      );


  }

  Future<EditMyAdsListModel> editmyadsapicall() async {
    // Create Dio instance
    Dio dio = Dio();

    // Define the headers
    Map<String, String> headers = {
      // 'Authorization': 'Bearer 131|V1SPLBTs7BaNNUwZth5gTGjZfC1nc2qQ1EB6fpTs',
      // 'Authorization': access_token.$,
      'Cookie':
      'XSRF-TOKEN=eyJpdiI6IkpzZEJucwT1iZDRmYzQzATEwNDYwNmE4Njg5MGNiNzcxM2RiIiwidGFnIjoiIn0%3D; umonda_online_marketplace_session=eyJpdiI6IkFFM0M0RHVaZ3RDN25sbGFqd0VES3c9PSIsInZhbHVlIjoiNjZzQ1g0djlhcVhnM0ZWb1QzaCtpQ3U1Yk1oKzB4Z3ZZaTc5SzJRNk1MWmpWb2N6ek1oTDNMcUN6V2FlSVQ3Z0ZQNE03UzNBdEVWUnVxc3T1iLCJtYWMiOiI2NjlkNTBiOWRiOTNiYTQ2Yjk1ZjQ1MmFlZGEyMTRlMDE3MWY2YjczYjQ1YjgwNjEwODQ3ABcQzOGJlZTgyNjE1IiwidGFnIjoiIn0%3D',

      //'Authorization': 'Bearer 272|zOSOR7ks4vioa05Rp8YwM61GTFAIpybBUSiX3WYv',
    };

    // Define the API endpoint
   // String url = 'https://webcluestechnology.com/demo/erp/umonda/api/v2/products/${widget.Product_ID}';
     String url = '${AppConfig.BASE_URL}/products/${widget.Product_ID}';
    //String url = '${AppConfig.BASE_URL}/products/120';
    //String url = "https://umonda.com/api/v2/payment-history/138";

    try {
      // Make the API call
      Response response = await dio.get(url, options: Options(headers: headers));

      // Handle the response
      if (response.statusCode == 200) {
        print("user iddddd${user_id.$}");
        //print("Govind My Ads list ${jsonEncode(response.data)}");
        print("Govind Edit My Ads list ${response.data}");
        return EditMyAdsListModel.fromJson(response.data);

        // API call successful
        //print(response.data);
      }

      else if(response.statusCode == 401){

        print("500 Internal Server Error........... ");
        print("user iddddd${user_id.$}");
        print(response.data);
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
