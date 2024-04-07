import 'dart:developer';

import 'package:clean_code_demo/repository/helper/api_helper.dart';

class ProductService {
  static Future<dynamic> fetchProducts() async {
    log("ProductService -> fetchProduct()");
    try {
      var decodedData = await ApiHelper.getData(endPoint: "products/");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> searchProduct(String searchText) async {
    log("ProductService -> searchProduct()");
    try {
      var decodedData = await ApiHelper.getData(endPoint: "products/?search_query=$searchText");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
