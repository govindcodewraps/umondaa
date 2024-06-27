import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umonda/custom/device_info.dart';
import 'package:umonda/my_theme.dart';
import 'package:umonda/custom/useful_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:umonda/repositories/brand_repository.dart';
import '../custom/btn.dart';
import '../data_model/AllCategoryResponse.dart';
import '../data_model/Edit_My_ads_Model.dart';
import '../app_config.dart';
import '../helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import '../screens/common_webview_screen.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data_model/Sub_Category_List_Model.dart';
import 'InProfileScreen/My_Ads.dart';

  String imagePath;
//                             var _remarkinput=remarkInputController.text .isEmpty ? widget.remark:remarkInputController.text;
class Edit_placead extends StatefulWidget {
  String Product_ID,Product_Name,Product_Price,Product_Des;


  Edit_placead({Key key,this.Product_ID,this.Product_Name,this.Product_Price, this.Product_Des}) : super(key: key);

  @override
  State<Edit_placead> createState() => _Edit_placeadState();
}

class _Edit_placeadState extends State<Edit_placead> {
  bool _obscureText = true;

  bool _isAgree = false;
  bool light = false, isChecked = true;
  bool _filteredBrandsCalled = false;
  List<File> basee = [];
  List<dynamic> brandsList = [];
  final picker = ImagePicker();
  String dropdownBrands = "Select Select_Brand";
  bool isEnabled = false;
  String offerstatus="0";
  String allurlss;
  String image;
  String discription=" ";
  List<File> selectedImages = []; // List to hold selected image files
  List<String> imageUrls = [];
  List<String> imagePaths = [];
  String preimagepath;
  List<String> base64Urls = [];
  bool _customeIcon = false;
  String globalResponseBody;
  bool isLoading = false;
  String oldimages;


  List<String> selectedItems = [];
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
  List<String> fetchselectedcategories=[];
  String convertstring;
  //List<String> imagePaths = [];
  //Set<String> imagePaths = {};
  List<String> remainingImagePaths = [];
  String htmlText = parse("String with HTML tags").body.text;

  //List<String> remainingImagePaths = [];
  int gov=0;

  @override
  void initState() {




    print("product iddd ${widget.Product_ID}");
    _ProductName.text = widget.Product_Name ?? 'No remark';

    _PriceAED.text =  getNumericPart(widget.Product_Price) ?? 'No remark';

    fetch_Brands();
    fetchallcategoriesdata();
    editmyadsapicall();

    super.initState();
  }




  String getNumericPart(String input) {
    // Remove non-numeric characters from the string
    String numericPart = input.replaceAll(RegExp(r'[^0-9.]'), '');

    // Ensure that there is exactly one dot (.) in the numeric part
    if (numericPart.contains('.')) {
      int dotCount = numericPart.split('.').length - 1;
      if (dotCount > 1) {
        // If there is more than one dot, keep only the first one
        numericPart = numericPart.replaceFirst('.', '');
      }
    }

    return numericPart;
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
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
       // appBar: buildAppBarTitleOption(context),
        body: bodywidget()
    ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // This will remove the back button
      backgroundColor: Color.fromARGB(240, 243, 237, 237),
      title: buildAppBarTitleOption(context),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Widget buildAppBarTitleOption(BuildContext context) {

    print("Govind>>>>> ${ProductID}");
    print("Price>>>>> ${discription}");

    print("Selected ProductIDs>>>>>>>>>>>>: $selectedProductIDs");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon(Icons.arrow_back,color: Colors.black,)),
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
      'product_id': widget.Product_ID,
      'old_image_url':imagePath
      //'old_image_url':oldimages

    });

    for(var i=0;i<imageUrls.length;i++)
    {
      request.files.add(await http.MultipartFile.fromPath('thumbnail_img[]', imageUrls[i],));
      //request.files.add(await http.MultipartFile.fromPath('thumbnail_img[]', imagePath[i],));


    }

    request.headers.addAll(headers);
    print("headerrrrr");
    print(name);
    print(user_id.$.toString());
    print(Category);
    print(Brand);
    print(description);
    print(offer);
    print(amount);
    print(offerstatus);
    print(widget.Product_ID);
    print("hqwertyu");
    print(oldimages);
    print("Old Image url ${imagePath}");
    print("headerrrrr");

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
        print(response);

        print("Product Update successfully");
        Navigator.pop(context, true);
        //Navigator.pop(context);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>My_adsScreen()));

      }
      else if(response.statusCode == 401)
      {
        print(response);
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
      print('Errorrr:::: $e');
    }
  }

/*  Widget bodywidget() {
    // List<String> remainingImagePaths = [];
    // List<String> imagePaths = [];

    return FutureBuilder(
      future: editmyadsapicall(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Use a List to store image paths
          imagePaths = List.from(snapshot.data.data[0].photos.map((photo) => photo.path));

          return Container(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imagePaths.length,
              separatorBuilder: (context, index) => SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final String imagePath = imagePaths[index];

                return Stack(
                  children: [
                    Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 150, // Adjust the width as needed
                      height: 150, // Adjust the height as needed
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Delete the image at the current index
                          _deleteImage(index);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
  void _deleteImage(int index) {
    setState(() {
      imagePaths.removeAt(index);
      print("Remaining Image URLs: $imagePaths");
    });
  }*/








  Widget bodywidget(){
    return
      FutureBuilder(
          future: editmyadsapicall(),
          builder: (context, snapshot) {
            //itemCount: imagePaths.length,


            if (snapshot.hasData) {

              List<String> categoryIdList = [];
              RegExp regExp = RegExp(r'\d+');
              Iterable<Match> matches = regExp.allMatches(snapshot.data.data[0].categoryId.toString());
              for (var match in matches) {
                categoryIdList.add(match.group(0));

              }
              print("Convert String to list  .: ${categoryIdList}");
              //discription=snapshot.data.data[0].description.toString();
              String discription = parse(snapshot.data.data[0].description.toString()).body.text;
              print("Descriptionnnnnn ${discription}");
              _Description.text = discription.toString() ?? 'No remark';



              imagePaths = List.from(snapshot.data.data[0].photos.map((photo) => photo.path));
             // Set<String> imagePathSet = Set.from(imagePaths);

              print("selected thum");
              print(imagePaths);
              print("selected thum");



            List asd = categoryIdList.toList();

              if(gov==0) {
                for (int i = 0; i < asd.length; i++) {
                  selectedItems.add("${asd[i]}");
                }
                gov=1;
              }
              print("fetch  category.....: ${fetchselectedcategories}");
              print("fetch  category selected items.....: ${selectedItems}");

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

                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(),

                                      hintText:snapshot.data.data[0].name.toString()?? ""
                                  ),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),

                              ExpansionTile(title: Text("Category"),
                                children: [
                                  ListTile(
                                    title: InkWell(onTap: (){
                                      // print("Hellooooo${globalResponseBody}");
                                    },
                                      child: Categorylistview(),
                                    ),
                                  )
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
                      //Text(imagePaths.length.toString()),

                      Container(
                        padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                        height: 170,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: imagePaths.length,
                          separatorBuilder: (context, index) => SizedBox(width: 8.0),
                          itemBuilder: (context, index) {
                          //  final String imagePath = imagePaths[index];
                            imagePath = imagePaths[index];
                            print("old Image path${imagePath}");

                            return Stack(
                              children: [
                                Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: 150, // Adjust the width as needed
                                  height: 150, // Adjust the height as needed
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                   child:


                                 /*  IconButton(
                                     icon: Icon(Icons.delete),
                                     onPressed: () {
                                       setState(() {
                                         // Check if the index is valid
                                         if (index >= 0 && index < imagePaths.length) {
                                           // Print the URL of the image to be deleted
                                           print("Deleting image at index $index, URL: ${imagePaths[index]}");

                                           // Remove the specified part from the URL in imagePaths list
                                           imagePaths[index] = imagePaths[index].replaceAll("https://webcluestechnology.com/demo/erp/umonda/public//uploads/all/", "");

                                           // Delete the image at the current index
                                           imagePaths.removeAt(index);
                                           print("Deleted image at index $index");

                                           // Print information related to image paths after deletion
                                           print("Image paths after deletion: $imagePaths");
                                         } else {
                                           print("Invalid index: $index");
                                         }
                                       });
                                     },
                                   ),*/


                                   IconButton(
                                     icon: Icon(Icons.delete),
                                     onPressed: () {
                                      // fetchData();

                                       // setState(() {
                                       //   // Check if the index is valid
                                       //   if (index >= 0 && index < imagePaths.length) {
                                       //     // Print the original URL of the image to be deleted
                                       //     String originalUrl = imagePaths[index];
                                       //     print("Deleting image at index $index, Original URL: $originalUrl");
                                       //     //simagePaths[index] = originalUrl.replaceAll("https://webcluestechnology.com/demo/erp/umonda/public//uploads/all/", "");
                                       //     imagePaths[index] = originalUrl.replaceAll("https://umonda.com/public//uploads/all/", "");
                                       //     preimagepath = imagePaths[index];
                                       //     fetchData();
                                       //
                                       //   } else {
                                       //     print("Invalid index: $index");
                                       //   }
                                       // });



                                      /* setState(() {
                                         // Check if the index is valid
                                         if (index >= 0 && index < imagePaths.length) {
                                           // Print the original URL of the image to be deleted
                                           String originalUrl = imagePaths[index];
                                           print("Deleting image at index $index, Original URL: $originalUrl");

                                           // Update the image path
                                           imagePaths[index] = originalUrl.replaceAll("https://umonda.com/public//uploads/all/", "");
                                           preimagepath = imagePaths[index];

                                           // Call the fetchData() function if needed
                                           fetchData();

                                           // Print the remaining URLs in the console
                                           print("Remaining URLs:");
                                           imagePaths.forEach((url) {
                                             print(url);
                                           });
                                         } else {
                                           print("Invalid index: $index");
                                         }
                                       });*/


                                     /*  setState(() {
                                         // Check if the index is valid
                                         if (index >= 0 && index < imagePaths.length) {
                                           // Print the original URL of the image to be deleted
                                           String originalUrl = imagePaths[index];
                                           print("Deleting image at index $index, Original URL: $originalUrl");

                                           // Update the image path
                                           imagePaths[index] = originalUrl.replaceAll("https://umonda.com/public//uploads/all/", "");
                                           preimagepath = imagePaths[index];

                                           // Call the fetchData() function if needed
                                           fetchData();

                                           // Print the remaining URLs in the console without the specified prefix
                                           print("Remaining URLs:");
                                           imagePaths.forEach((url) {
                                             // Remove the specified prefix before printing
                                             String urlWithoutPrefix = url.replaceAll("https://umonda.com/public//uploads/all/", "");

                                            print("AAAAAAAAAAA");
                                             print(urlWithoutPrefix);
                                             print("AAAAAAAAAAA");

                                           });
                                         } else {
                                           print("Invalid index: $index");
                                         }
                                       });*/




                                       /*setState(() {
                                         // Check if the index is valid
                                         if (index >= 0 && index < imagePaths.length) {
                                           // Print the original URL of the image to be deleted
                                           String originalUrl = imagePaths[index];
                                           print("Deleting image at index $index, Original URL: $originalUrl");

                                           // Update the image path
                                           imagePaths[index] = originalUrl.replaceAll("https://umonda.com/public//uploads/all/", "");
                                           preimagepath = imagePaths[index];

                                           // Call the fetchData() function if needed
                                           fetchData();

                                           // Store the remaining URLs without the specified prefix in the allurlsvar variable
                                           List<String> modifiedUrls = [];
                                           imagePaths.forEach((url) {
                                             // Remove the specified prefix
                                             String urlWithoutPrefix = url.replaceAll("https://umonda.com/public//uploads/all/", "");
                                             modifiedUrls.add(urlWithoutPrefix);
                                           });

                                           // Store the modified URLs in the variable named allurlsvar
                                           String allurlsvar = modifiedUrls.join("\n");
                                           print("allurlsvar: $allurlsvar");
                                         } else {
                                           print("Invalid index: $index");
                                         }
                                       });*/


                                       setState(() {
                                         // Check if the index is valid
                                         if (index >= 0 && index < imagePaths.length) {
                                           // Print the original URL of the image to be deleted
                                           String originalUrl = imagePaths[index];
                                           print("Deleting image at index $index, Original URL: $originalUrl");

                                           // Update the image path
                                           imagePaths[index] = originalUrl.replaceAll("https://umonda.com/public/uploads/all/", "");
                                           preimagepath = imagePaths[index];


                                           // Call the fetchData() function if needed
                                           fetchData();

                                           // Store the remaining URLs without the specified prefix (excluding the selected index) in the allurlsvar variable
                                           List<String> modifiedUrls = [];
                                           for (int i = 0; i < imagePaths.length; i++) {
                                             if (i != index) {
                                               // Exclude the selected index
                                               String urlWithoutPrefix = imagePaths[i].replaceAll("https://umonda.com/public/uploads/all/", "");
                                               modifiedUrls.add(urlWithoutPrefix);
                                             }
                                           }

                                           // Store the modified URLs in the variable named allurlsvar
                                          // String allurlsvar = modifiedUrls.join("\n");
                                           String allurlsvar = modifiedUrls.join(",");
                                           oldimages=allurlsvar;
                                          // print("allurlsvar: $allurlsvar");

                                           print("\\\\\\\\\\\\\\\\");
                                           print("allurlsvar: $allurlsvar");

                                           print("\\\\\\\\\\\\\\\\");
                                           print("?????????????????");
                                           print(oldimages);
                                           print("?????????????????");
                                         } else {
                                           print("Invalid index: $index");
                                         }
                                       });













                                     },
                                   ),







                                  //
                                  //
                                  // IconButton(
                                  //   icon: Icon(Icons.delete),
                                  //   onPressed: () {
                                  //
                                  //     // print("delete");
                                  //     //
                                  //     // imagePaths.removeAt(index);
                                  //     // print("delete");
                                  //     // Delete the image at the current index
                                  //     setState(() {
                                  //
                                  //       print("Image length before");
                                  //       print(imagePaths.length);
                                  //       imagePaths.removeAt(index);
                                  //      // print(index);
                                  //       print("deleteeeet");
                                  //       print("Image length after");
                                  //       print(imagePaths.length);
                                  //      // remainingImagePaths.add(imagePath);
                                  //
                                  //     });
                                  //   },
                                  // ),
                                ),


                              ],
                            );
                          },
                        ),
                      ),






                      // Container(
                      //   height: 150,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: imagePaths.length,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Image.network(
                      //           imagePaths[index],
                      //           fit: BoxFit.cover,
                      //           width: 150, // Adjust the width as needed
                      //           height: 150, // Adjust the height as needed
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),






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
                                                   //child: Image.file(thumbnailImage,fit: BoxFit.cover,),
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
                                    //hintText:snapshot.data.data[0].mainPrice.toString()?? "",
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
                                    //hintText:snapshot.data.data[0].description.toString()?? "",

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
                              String selectedProduct = selectedProductIDs.map((item) => item.toString()).join(',').replaceAll(', ', ',');
                              print("category  remove square remove space....:${selectedProduct}");
                              String selectedPro = selectedItems.map((item) => item.toString()).join(',').replaceAll(', ', ',');
                              var ProdName = _ProductName.text.toString().isEmpty ? widget.Product_Name:_ProductName.text.toString();
                              var category = selectedProduct;
                              var brand = dropdownBrands.split(" ")[0].toString();
                              var description = _Description.text.isEmpty ? discription :_Description.text;
                              var amount = _PriceAED.text.isEmpty ? getNumericPart(widget.Product_Price):_PriceAED.text;


                              //var _remarkinput=remarkInputController.text .isEmpty ? widget.remark:remarkInputController.text;

                              var email = _EmailID.text.toString();
                              var password = _PassWord.text.toString();
                              var offer = _offerControler.text.toString();
                              // var imagebase = imageurl;
                              var imagebase = allurlss;
                              var userid = user_id.$;
                              var categoryy = selectedItems.toString();
                              //var imagebase = allurlss;

                              print("Product name.: ${ProdName}");
                              // print("category.....: ${category}");
                              print("category.....: ${selectedPro}");
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
                              print("selected itemsss  .....: ${selectedItems}");

                              place_ad_upload(ProdName,selectedPro,brand,description,offer,amount,offerstatus,email,password);

                              // _ProductName.clear();
                              // _Description.clear();
                              // _PriceAED.clear();
                              // _EmailID.clear();
                              // _PassWord.clear();
                              // _offerControler.clear();

                            }

                                : null,
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                    ]
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

  Widget Categorylistview() {
    return FutureBuilder(
      future: fetchallcategoriesdata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, int index) {
                    bool isItemSelected = selectedItems.contains(snapshot.data[index].id.toString());

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          title: Text(snapshot.data[index].name.toString()),
                          value: isItemSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value) {
                                selectedItems.add(snapshot.data[index].id.toString());
                              } else {
                                selectedItems.remove(snapshot.data[index].id.toString());
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ListView.builder(
                            itemCount: itemList[index].childrenCategories.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int subindex) {
                              bool isSubItemSelected = selectedItems.contains(itemList[index].childrenCategories[subindex].id.toString());

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckboxListTile(
                                    title: Text(itemList[index].childrenCategories[subindex].name.toString()),
                                    value: isSubItemSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value) {
                                          selectedItems.add(itemList[index].childrenCategories[subindex].id.toString());
                                        } else {
                                          selectedItems.remove(itemList[index].childrenCategories[subindex].id.toString());
                                        }
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: ListView.builder(
                                      itemCount: itemList[index].childrenCategories[subindex].categories.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, int catindex) {
                                        bool isCatItemSelected = selectedItems.contains(itemList[index].childrenCategories[subindex].categories[catindex].id.toString());

                                        return CheckboxListTile(
                                          title: Text(itemList[index].childrenCategories[subindex].categories[catindex].name.toString()),
                                          value: isCatItemSelected,
                                          onChanged: (value) {
                                            setState(() {
                                              if (value) {
                                                selectedItems.add(itemList[index].childrenCategories[subindex].categories[catindex].id.toString());
                                              } else {
                                                selectedItems.remove(itemList[index].childrenCategories[subindex].categories[catindex].id.toString());
                                              }
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: itemList.length,
                ),
              ],
            ),
          );
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Future<List<allcategoryModel>> fetchallcategoriesdata() async {
    var url = Uri.parse('${AppConfig.BASE_URL}/all-categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      globalResponseBody = response.body; // Assign the response body to the global variable
      List<dynamic> jsonList = json.decode(globalResponseBody);
      itemList = jsonList.map((json) => allcategoryModel.fromJson(json)).toList();
      print("allcategoryModel Response > ${itemList.length}");
      return itemList;
    } else {
      throw Exception('Failed to load data');
    }
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

    // String url = 'https://webcluestechnology.com/demo/erp/umonda/api/v2/products/${widget.Product_ID}';
    String url = '${AppConfig.BASE_URL}/products/${widget.Product_ID}';

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



  void fetchData() async {
    Dio dio = Dio();

    try {
      Response response = await dio.get('https://umonda.com/api/v2/products/image', queryParameters: {
        //'product_id': 239,
        'product_id': widget.Product_ID,
        'image': preimagepath,
        //'image': '1706168407_image_picker_E1D6B539-0BEC-4D2F-8642-19DFvvvvvFAADED49-446-000000AC36D52AB6.jpg',
      });

      if (response.statusCode == 200) {
        print("Product delete");
        print(response.data);
        setState(() {

          print("::::::::::::::::::::");
          print(imagePaths);
          print(imagePaths.length);
          print("::::::::::::::::::::");

          print("product iddd ${widget.Product_ID}");
          _ProductName.text = widget.Product_Name ?? 'No remark';

          _PriceAED.text =  getNumericPart(widget.Product_Price) ?? 'No remark';

          fetch_Brands();
          fetchallcategoriesdata();
          editmyadsapicall();
        });
        // Use response.data for the response body
      } else {
        print('Error: ${response.statusCode}, ${response.statusMessage}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  void _deleteImage(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Your existing delete logic goes here
      // ...

      // After successful deletion, hide the progress indicator
      Navigator.of(context).pop();

      // Optionally, you can show a snackbar or perform other UI updates
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Image deleted successfully"),
        ),
      );
    } catch (error) {
      // Handle errors, hide the progress indicator, and show an error message
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting image: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


}