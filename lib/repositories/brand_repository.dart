import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/TopBrandsModel.dart';
import '../data_model/brand_response.dart';
import '../helpers/shared_value_helper.dart';


class BrandRepository {

  Future<BrandResponse> getFilterPageBrands() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/filter/brands");
    final response =
    await http.get(url,headers: {
      "App-Language": app_language.$,
    });
    return brandResponseFromJson(response.body);
  }

  Future<BrandResponse> getBrands({name = "", page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/brands"+
        "?page=${page}&name=${name}");
    final response =
    await http.get(url,headers: {
      "App-Language": app_language.$,
    });
    return brandResponseFromJson(response.body);
  }
  Future<TopBrandsModel> getFilterTopBrands() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/brands/top");
    final response =
    await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    return topBrandsModelFromJson(response.body);
  }

  Future<TopBrandsModel> getTopBrands() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/brands/top");
    final response =
    await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    return topBrandsModelFromJson(response.body);
  }


}