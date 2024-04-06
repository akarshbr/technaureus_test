import 'dart:developer';

import 'package:clean_code_demo/core/utils/app_utils.dart';
import 'package:clean_code_demo/repository/api/product_screen/model/product_model.dart';
import 'package:clean_code_demo/repository/api/product_screen/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  ProductModel productModel = ProductModel();
  bool isLoading = false;

  fetchProduct(context) async {
    isLoading = true;
    notifyListeners();
    log("ProductController -> fetchProduct()");
    ProductService.fetchProduct().then((value) {
      log("fetchProduct() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        productModel = ProductModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("${value["message"]}", context: context);
      }
      notifyListeners();
    });
  }
}
