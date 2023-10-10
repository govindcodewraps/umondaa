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
