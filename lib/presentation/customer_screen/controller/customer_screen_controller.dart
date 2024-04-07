import 'dart:developer';

import 'package:clean_code_demo/core/utils/app_utils.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_details_screen.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_search_result.dart';
import 'package:clean_code_demo/repository/api/customer_screen/model/customer_model.dart';
import 'package:clean_code_demo/repository/api/customer_screen/model/customers_model.dart';
import 'package:clean_code_demo/repository/api/customer_screen/service/customer_service.dart';
import 'package:flutter/material.dart';

class CustomerScreenController extends ChangeNotifier {
  String? countrySelected;
  String? stateSelected;
  CustomersModel customersModel = CustomersModel();
  CustomersModel searchModel = CustomersModel();
  CustomerModel customerModel = CustomerModel();
  bool isLoading = false;
  bool isLoadingSearch = false;
  bool isLoadingCustomer = false;

  fetchCustomers(context) async {
    isLoading = true;
    notifyListeners();
    log("CustomerScreenController -> fetchCustomers()");
    CustomerService.fetchCustomers().then((value) {
      log("CustomerService -> fetchCustomers() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        customersModel = CustomersModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("${value["message"]}", context: context);
      }
      notifyListeners();
    });
  }

  searchCustomers(context, searchText, size) async {
    isLoadingSearch = true;
    notifyListeners();
    log("CustomerScreenController -> searchCustomers()");
    CustomerService.searchCustomers(searchText).then((value) {
      log("CustomerService -> searchCustomers() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        searchModel = CustomersModel.fromJson(value);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerSearchResultScreen(
                    size: size, searchText: searchText, customersModel: searchModel)));
        isLoadingSearch = false;
      } else {
        AppUtils.oneTimeSnackBar("No result found", context: context);
      }
      notifyListeners();
    });
  }

  fetchCustomer(context, id, size) async {
    isLoadingCustomer = true;
    notifyListeners();
    log("ProductController -> fetchCustomer()");
    CustomerService.fetchCustomer(id).then((value) {
      log("fetchCustomer() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        customerModel = CustomerModel.fromJson(value);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerDetailsScreen(
                    size: size,
                    customerImage: customerModel.data?.profilePic??"",
                    customerName: customerModel.data?.name,
                    customerID: customerModel.data?.id.toString(),
                    customerMobile: customerModel.data?.mobileNumber,
                    customerEmail: customerModel.data?.email,
                    street: customerModel.data?.street,
                    street2: customerModel.data?.streetTwo,
                    city: customerModel.data?.city,
                    state: customerModel.data?.state,
                    pinCode: customerModel.data?.pincode.toString())));
        isLoadingCustomer = false;
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
