import 'package:flutter/material.dart';

import 'colors.dart';

class GlobalTextStyles {
  static homeScreenCardTS({double? size, FontWeight? fontWeight, Color? color}) {
    return TextStyle(color: ColorTheme.primaryColor);
  }

  static productScreenTS({
    double size = 15,
    FontWeight fontWeight = FontWeight.normal,
    Color color = ColorTheme.onPrimaryColor,
  }) {
    return TextStyle(color: color, fontWeight: fontWeight, fontSize: size);
  }
}
