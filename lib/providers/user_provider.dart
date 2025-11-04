import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {

  String _userName = "Guest";

  String get userName => _userName;

  void setUserName(String name) {
    if (name.isEmpty) {
      _userName = "Guest";
    } else {
      _userName = name;
    }

    notifyListeners();
  }
}