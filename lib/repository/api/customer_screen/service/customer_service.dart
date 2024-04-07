import 'dart:developer';

import 'package:clean_code_demo/repository/helper/api_helper.dart';

class CustomerService {
  static Future<dynamic> fetchCustomers() async {
    log("CustomerService -> fetchCustomers()");
    try {
      var decodedData = await ApiHelper.getData(endPoint: "customers/");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
