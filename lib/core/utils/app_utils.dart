import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static oneTimeSnackBar(
    String? message, {
    int time = 2,
    Color? bgColor,
    TextStyle? textStyle,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor ?? ColorTheme.snackBarBGColor,
        duration: Duration(seconds: time),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width - 100,
          right: 20,
          left: 20,
        ),
        content: Text(message!, style: TextStyle(color: ColorTheme.bgColor))));
  }
}
