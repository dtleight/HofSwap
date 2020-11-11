import 'dart:io';

import 'package:flutter/material.dart';


class PictureState with ChangeNotifier{
  File _picture;

  set picture(value)
  {
    _picture = value;
    notifyListeners();
  }

  File get picture => _picture;
}