
import 'dart:async';

import 'package:flutter/material.dart';

import '../data_model/currency_response.dart';
import '../helpers/shared_value_helper.dart';
import '../helpers/system_config.dart';
import '../repositories/currency_repository.dart';

class CurrencyPresenter extends ChangeNotifier{

   List<CurrencyInfo> currencyList=[];



  fetchListData()async{
    currencyList.clear();
    var res = await CurrencyRepository().getListResponse();
    print("res.data ${system_currency.$}");
    print(res.data.toString());
    currencyList.addAll(res.data);

    currencyList.forEach((element) {
      if(element.isDefault){

        SystemConfig.defaultCurrency=element;
      }
      if(system_currency.$ == null && element.isDefault){
        SystemConfig.systemCurrency =element;
        system_currency.$= element.id;
        system_currency.save();
      }
      if(system_currency.$ !=null && element.id == system_currency.$){
        SystemConfig.systemCurrency=element;
        system_currency.$ = element.id;
        system_currency.save();

      }
    });
    notifyListeners();
  }
}