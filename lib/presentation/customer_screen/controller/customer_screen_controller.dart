import 'dart:developer';

import 'package:clean_code_demo/core/utils/app_utils.dart';
import 'package:clean_code_demo/repository/api/customer_screen/service/customer_model.dart';
import 'package:clean_code_demo/repository/api/customer_screen/service/customer_service.dart';
import 'package:flutter/material.dart';

class CustomerScreenController extends ChangeNotifier {
  String? countrySelected;
  String? stateSelected;
  CustomerModel customerModel = CustomerModel();
  bool isLoading = false;

  fetchCustomers(context) async {
    isLoading = true;
    notifyListeners();
    log("CustomerScreenController -> fetchCustomers()");
    CustomerService.fetchCustomers().then((value) {
      log("CustomerService -> fetchCustomers() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        customerModel = CustomerModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("${value["message"]}", context: context);
      }
      notifyListeners();
    });
  }

  void setCountry(String selectedCountry) {
    countrySelected = selectedCountry;
    notifyListeners();
  }

  void setState(String selectedState) {
    stateSelected = selectedState;
    notifyListeners();
  }
}
