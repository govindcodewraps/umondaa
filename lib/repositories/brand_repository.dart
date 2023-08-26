import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../data_model/brands_respon.dart';
import '../helpers/shared_value_helper.dart';
//import '../repositories/api_request.dart';


class BrandRepository {

  Future<BrandsResponse> getFilterPageBrands() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/filter/brands");
    final response =
    await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    return brandsResponseFromJson(response.body);
  }

  Future<BrandsResponse> getBrands({name = "", page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/brands"+
        "?page=${page}&name=${name}");
    final response =
    await http.get(url,headers: {
      "App-Language": app_language.$,
    });
    return brandsResponseFromJson(response.body);
  }

  Future<BrandsResponse> getFilterTopBrands() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/brands/top");
    final response =
    await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    print("Brand_Repository, getFilterTopBrands, response : ${response.body}");
    return brandsResponseFromJson(response.body);
  }

  Future<BrandsResponse> getTopBrands() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/brands/top");
    final response =
    await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    print("Brand_Repository, getTopBranc, response : ${response.body}");
    return brandsResponseFromJson(response.body);
  }

}