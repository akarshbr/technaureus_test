import 'package:flutter/material.dart';

class HomeScreenController extends ChangeNotifier {
  int? selectedIndex;

  void selectedCard(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
