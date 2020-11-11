import 'package:flutter/material.dart';

class NameState with ChangeNotifier{

  static String _name;
  String get name => _name;
  set name(String value)
  {
    _name = value;
    notifyListeners();
  }
}