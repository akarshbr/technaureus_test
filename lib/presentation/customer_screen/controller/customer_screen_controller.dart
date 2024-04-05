import 'package:flutter/material.dart';

class CustomerScreenController extends ChangeNotifier {
  String? countrySelected;
  String? stateSelected;

  void setCountry(String selectedCountry) {
    countrySelected = selectedCountry;
    notifyListeners();
  }

  void setState(String selectedState) {
    stateSelected = selectedState;
    notifyListeners();
  }
}
