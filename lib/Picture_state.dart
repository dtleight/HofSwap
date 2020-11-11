import 'package:flutter/material.dart';


class PictureState with ChangeNotifier{

  static String _picture;
  String get picture => _picture;
  set picture(String value)
  {
    _picture = value;
    notifyListeners();
  }

}