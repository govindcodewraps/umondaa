import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

const List<String> category = <String>['Select Category', 'Home & Garden', 'Electronics', 'Motors', 'Fashion', 'Collectibles & Arts', 'Sports', 'Health & Beauty', 'Industrial Equipment'];
const List<String> brands = <String>['Select Brand', 'Adidas', 'Apple', 'Bosch', 'Hugo Bosss', 'Nike', 'Rolex', 'Sony'];

class placead extends StatefulWidget {
  // const placead({super.key});

  @override
  State<placead> createState() => _placeadState();
}

class _placeadState extends State<placead> {
  bool light = false, isChecked = true;
  List<File> selectedImages = [];
  final picker = ImagePicker();
  String dropdownBrands = brands[0];
  String dropdownCategory = category[0];

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
                            style: TextStyle(fontSize: 20,
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
                    ),
                  ),

                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 16, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Category",
                            style: TextStyle(fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    // child: TextField(
                    //   controller: _Category,
                    //   autofocus: false,
                    //   enableSuggestions: false,
                    //   autocorrect: false,
                    //   decoration: const InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     labelText: 'Nothing slected',
                    //   ),
                    // ),
                    child: CategoryDropdown(),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 16, 0, 0),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Brand",
                            style: TextStyle(fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0))
                        ),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    // child: TextField(
                    //   controller: _Brand,
                    //   autofocus: false,
                    //   enableSuggestions: false,
                    //   autocorrect: false,
                    //   decoration: const InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     labelText: 'Nothing slected',
                    //   ),
                    // ),
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
                            style: TextStyle(fontSize: 20,
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
                                backgroundColor: MaterialStateProperty.all(Colors.green)),
                              child: const Text('Select Image from Gallery',
                                  style: TextStyle(fontSize: 20,
                                  color: Color.fromARGB(255, 0, 0, 0))),
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
                            style: TextStyle(fontSize: 20,
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
                        Container(
                          child: light == false ? Container(
                              ): Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                            style: TextStyle(fontSize: 20,
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
                            style: TextStyle(fontSize: 20,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                      margin: const EdgeInsets.fromLTRB(5, 6, 0, 0),
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
      return Colors.red;
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
    return DropdownButton<String>(
      value: dropdownCategory,
      icon: const Icon(Icons.keyboard_arrow_down, size: 35,),
      elevation: 5,
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
  BrandDropdown () {
    return DropdownButton<String>(
      value: dropdownBrands,
      icon: const Icon(Icons.keyboard_arrow_down, size: 35,),
      elevation: 5,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (String value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownBrands = value;
        });
      },
      items: brands.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 18),),
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