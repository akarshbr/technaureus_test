import 'dart:developer';

import 'package:clean_code_demo/repository/helper/api_helper.dart';

class ProductService {
  static Future<dynamic> fetchProduct() async {
    log("ProductService -> fetchProduct()");
    try {
      var decodedData = await ApiHelper.getData(endPoint: "products/");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
