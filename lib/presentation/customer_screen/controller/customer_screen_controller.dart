import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:clean_code_demo/config/app_config.dart';
import 'package:clean_code_demo/core/utils/app_utils.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_details_screen.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_search_result.dart';
import 'package:clean_code_demo/repository/api/customer_screen/model/customer_model.dart';
import 'package:clean_code_demo/repository/api/customer_screen/model/customers_model.dart';
import 'package:clean_code_demo/repository/api/customer_screen/service/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                    customerImage: customerModel.data?.profilePic ?? "",
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

  Future<void> onCreateCustomer(
    BuildContext context,
    File? image,
    String name,
    String mobileNumber,
    String mail,
    String street,
    String street2,
    String city,
    String pinCode,
    String country,
    String state,
  ) async {
    try {
      var url = "${AppConfig.baseUrl}customers/";
      onUploadImage(
        url,
        image,
        name,
        mobileNumber,
        mail,
        street,
        street2,
        city,
        pinCode,
        country,
        state,
      ).then((value) {
        log("onCreateCustomer() -> status code -> ${value.statusCode}");
        if (value.statusCode == 200) {
          Navigator.pop(context);
          AppUtils.oneTimeSnackBar("Registered", context: context, bgColor: Colors.green, time: 3);
        } else {
          var message = jsonDecode(value.body)["message"];
          AppUtils.oneTimeSnackBar(message, context: context);
        }
      });
    } catch (e) {}
  }

  Future<void> onEditCustomer(
    BuildContext context,
    File? image,
    String name,
    String mobileNumber,
    String mail,
    String street,
    String street2,
    String city,
    String pinCode,
    String country,
    String state,
      int id
  ) async {
    try {
      var url = "${AppConfig.baseUrl}customers/?id=$id";
      onUploadEdit(url, image, name, mobileNumber, mail, street, street2, city, pinCode, country, state)
          .then((value) {
        log("onEditCustomer() -> status code -> ${value.statusCode}");
        if (value.statusCode == 200) {
          Navigator.pop(context);
          AppUtils.oneTimeSnackBar("Registered", context: context, bgColor: Colors.green, time: 3);
        } else {
          var message = jsonDecode(value.body)["message"];
          AppUtils.oneTimeSnackBar(message, context: context);
        }
      });
    } catch (e) {
      log("$e");
    }
  }

  Future<http.Response> onUploadImage(
    String url,
    File? selectedImage,
    String name,
    String mobileNumber,
    String mail,
    String street,
    String street2,
    String city,
    String pinCode,
    String country,
    String state,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    if (selectedImage != null) {
      log("image size -> ${selectedImage.lengthSync()} B");
      request.files.add(await http.MultipartFile.fromPath('profile_pic', selectedImage.path));
    }
    request.fields["name"] = name;
    request.fields["mobile_number"] = mobileNumber;
    request.fields["email"] = mail;
    request.fields["street"] = street;
    request.fields["street_two"] = street2;
    request.fields["city"] = city;
    request.fields["pincode"] = pinCode;
    request.fields["country"] = country;
    request.fields["state"] = state;
    request.headers.addAll(headers);
    log("request: $request");
    var res = await request.send();
    return await http.Response.fromStream(res);
  }

  Future<http.Response> onUploadEdit(
    String url,
    File? selectedImage,
    String name,
    String mobileNumber,
    String mail,
    String street,
    String street2,
    String city,
    String pinCode,
    String country,
    String state,
  ) async {
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    if (selectedImage != null) {
      log("image size -> ${selectedImage.lengthSync()} B");
      request.files.add(
          await http.MultipartFile.fromPath('profile_pic', selectedImage.path));
    }
    request.fields["name"] = name;
    request.fields["mobile_number"] = mobileNumber;
    request.fields["email"] = mail;
    request.fields["street"] = street;
    request.fields["street_two"] = street2;
    request.fields["city"] = city;
    request.fields["pincode"] = pinCode;
    request.fields["country"] = country;
    request.fields["state"] = state;
    request.headers.addAll(headers);
    log("request: $request");
    var res = await request.send();
    return await http.Response.fromStream(res);
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
