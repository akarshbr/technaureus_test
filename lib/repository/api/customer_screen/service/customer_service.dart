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
  static Future<dynamic> searchCustomers(String searchText) async {
    log("CustomerService -> searchCustomers()");
    try {
      var decodedData = await ApiHelper.getData(endPoint: "customers/?search_query=$searchText");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> fetchCustomer(int id) async {
    log("CustomerService -> searchCustomers()");
    try {
      var decodedData = await ApiHelper.getData(endPoint: "customers/?id=$id");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

}
