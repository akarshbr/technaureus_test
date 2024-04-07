import 'dart:developer';

import 'package:clean_code_demo/core/utils/app_utils.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_search_result.dart';
import 'package:clean_code_demo/repository/api/customer_screen/model/customer_model.dart';
import 'package:clean_code_demo/repository/api/customer_screen/service/customer_service.dart';
import 'package:flutter/material.dart';

class CustomerScreenController extends ChangeNotifier {
  String? countrySelected;
  String? stateSelected;
  CustomerModel customerModel = CustomerModel();
  CustomerModel searchModel = CustomerModel();
  bool isLoading = false;
  bool isLoadingSearch = false;

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

  searchCustomers(context, searchText,size) async {
    isLoadingSearch = true;
    notifyListeners();
    log("CustomerScreenController -> searchCustomers()");
    CustomerService.searchCustomers(searchText).then((value) {
      log("CustomerService -> searchCustomers() -> error code -> ${value["error_code"]}");
      if (value["error_code"]==0) {
        searchModel = CustomerModel.fromJson(value);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerSearchResultScreen(
                    size: size, searchText: searchText, customerModel: searchModel)));
        isLoadingSearch = false;
      } else {
        AppUtils.oneTimeSnackBar("No result found", context: context);
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
