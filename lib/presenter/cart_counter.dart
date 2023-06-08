

import 'dart:async';

import 'package:flutter/material.dart';

import '../repositories/cart_repository.dart';

class CartCounter extends ChangeNotifier{

  int cartCounter=0;



  getCount()async{
    var res = await CartRepository().getCartCount();
    cartCounter = res.count;
    notifyListeners();
  }

}