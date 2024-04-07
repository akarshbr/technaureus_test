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

  static const TextStyle productScreenCardBSTS = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: ColorTheme.onBGColor,
  );

  static const TextStyle customerScreenCardBSTS = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: ColorTheme.onBGColor,
  );

  static const TextStyle customerScreenDetailsTS = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 19,
    color: ColorTheme.onBGColor,
  );

  static customerScreenTS({
    double size = 15,
    FontWeight fontWeight = FontWeight.normal,
    Color color = ColorTheme.onBGColor,
  }) {
    return TextStyle(color: color, fontWeight: fontWeight, fontSize: size);
  }
}
