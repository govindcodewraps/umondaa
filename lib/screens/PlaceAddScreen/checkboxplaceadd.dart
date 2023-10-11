/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../app_config.dart';
import '../../data_model/AllCategoryResponse.dart';

class CheckboxListScreen extends StatefulWidget {
  @override
  _CheckboxListScreenState createState() => _CheckboxListScreenState();
}

class _CheckboxListScreenState extends State<CheckboxListScreen> {
  List<bool> isCheckedList = [];
  List<allcategoryModel> itemList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: itemList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final item = itemList[index];
          return ListTile(
            leading: Checkbox(
              value: isCheckedList[index],
              onChanged: (bool newValue) {
                setState(() {
                  isCheckedList[index] = newValue;
                });
              },
            ),
            title: Text(item.name.toString()),
          );
        },
      ),
    );
  }

  Future<void> fetchData() async {
    var url = Uri.parse('${AppConfig.BASE_URL}/all-categories');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      itemList = jsonList.map((json) => allcategoryModel.fromJson(json)).toList();
      setState(() {
        isCheckedList = List<bool>.filled(itemList.length, false);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
*/




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../app_config.dart';
import '../../data_model/AllCategoryResponse.dart';
import '../../data_model/Sub_Category_List_Model.dart';

class CheckboxListScreen extends StatefulWidget {
  @override
  _CheckboxListScreenState createState() => _CheckboxListScreenState();
}

class _CheckboxListScreenState extends State<CheckboxListScreen> {
  List<bool> isCheckedList = [];
  List<bool> isCheckedSubList = [];
  List<bool> isCheckedList2 = [];
  List<allcategoryModel> itemList = [];
  List<SubCategoryListModel> SubitemList = [];
  List<ChildrenCategories> itemList2 = [];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    subcategorylist();
    printSelectedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Checkbox List'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.print),
      //       onPressed: () {
      //         printSelectedItems();
      //       },
      //     ),
      //   ],
      // ),
      body: itemList.isEmpty
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
                    setState(() {
                      isCheckedList[index] = newValue;
                      printSelectedItems();
                    });
                  },
                ),
                title: Text(item.name.toString()),
          ),

                if(isCheckedList[index])
                  Column(children: [

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context , int index){
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: ListTile(
                              leading: Checkbox(
                                value: isChecked,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    isChecked = newValue;
                                    printSelectedItems();
                                  });
                                },
                              ),
                              title:Text(item.childrenCategories[index].categories[index].name.toString() ??""),

                            ),
                          ),
                        ],);

                      },
                      //itemCount: item.childrenCategories[index].categories.length,
                      itemCount: 2,
                    ),


                  ],)


              ],
            );
        },
      ),
    );
  }

  Future<void> fetchData() async {
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
    var url = Uri.parse('${AppConfig.BASE_URL}/sub-category-list/120');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      SubitemList = jsonList.map((json) => SubCategoryListModel.fromJson(json)).toList();
    print("Sub category list ${response.body}");
      setState(() {
        isCheckedSubList = List<bool>.filled(SubitemList.length, false);
      });
    }

    else {
      throw Exception('Failed to load data');
    }
} 


  void printSelectedItems() {
    for (int i = 0; i < itemList.length; i++) {
      if (isCheckedList[i]) {
        print("Selected Item Name: ${itemList[i].id}");
      }
    }
  }
}
