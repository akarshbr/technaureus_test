import 'dart:convert';
import 'dart:developer';

import 'package:clean_code_demo/config/app_config.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static getData({required String endPoint}) async {
    log("ApiHelper -> getData()");
    final url = Uri.parse(AppConfig.baseUrl + endPoint);
    log("url ->  $url");
    try {
      var response = await http.get(url);
      log("API called -> status code -> ${response.statusCode}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        log("decoded data -> ${decodedData.toString()}");
        return decodedData;
      } else {
        var decodedData = jsonDecode(response.body);
        return decodedData;
      }
    } catch (e) {
      log("$e");
    }
  }

  static postData({required String endPoint, Map<String, dynamic>? body}) async {
    log("ApiHelper -> postData()");
    log("body ->  $body");
    final url = Uri.parse(AppConfig.baseUrl + endPoint);
    log("url -> $url");
    try {
      var response = await http.post(url, body: body);
      log("API called -> status code -> ${response.statusCode}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        log("response -> ${decodedData.toString()}");
        return decodedData;
      } else {
        var decodedData = jsonDecode(response.body);
        return decodedData;
      }
    } catch (e) {
      log("$e");
    }
  }
}
