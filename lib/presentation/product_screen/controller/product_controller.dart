import 'dart:developer';

import 'package:clean_code_demo/core/utils/app_utils.dart';
import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_details_screen.dart';
import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_search_result.dart';
import 'package:clean_code_demo/repository/api/product_screen/model/product_model.dart';
import 'package:clean_code_demo/repository/api/product_screen/model/products_model.dart';
import 'package:clean_code_demo/repository/api/product_screen/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  ProductsModel productsModel = ProductsModel();
  ProductsModel searchModel = ProductsModel();
  ProductModel productModel = ProductModel();
  bool isLoading = false;
  bool isLoadingFetchProduct = false;
  bool isLoadingSearchProduct = false;

  fetchProducts(context) async {
    isLoading = true;
    notifyListeners();
    log("ProductController -> fetchProduct()");
    ProductService.fetchProducts().then((value) {
      log("fetchProduct() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        productsModel = ProductsModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("${value["message"]}", context: context);
      }
      notifyListeners();
    });
  }

  fetchProduct(context, id, size) async {
    isLoadingFetchProduct = true;
    notifyListeners();
    log("ProductController -> fetchProduct()");
    log("id -> $id");
    ProductService.fetchProduct(id).then((value) {
      log("fetchProduct() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        productModel = ProductModel.fromJson(value);
        isLoadingFetchProduct = false;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                productName: productModel.data?.name,
                size: size,
                price: productModel.data?.price?.toDouble(),
                productImage: productModel.data?.image,
                id: id,
              ),
            ));
      } else {
        AppUtils.oneTimeSnackBar("${value["message"]}", context: context);
      }
      notifyListeners();
    });
  }

  searchProduct(context, searchText, size) async {
    isLoadingSearchProduct = true;
    notifyListeners();
    log("ProductController -> searchProduct()");
    ProductService.searchProduct(searchText).then((value) {
      log("searchProduct() -> error code -> ${value["error_code"]}");
      if (value["error_code"] == 0) {
        searchModel = ProductsModel.fromJson(value);
        isLoadingSearchProduct = false;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProductSearchResultScreen(size: size, searchText: searchText, productsModel: searchModel)));
      } else {
        AppUtils.oneTimeSnackBar("No result found", context: context);
      }
      notifyListeners();
    });
  }
}
