

import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier{
  bool isDark=false;

  changeTheme(){
    isDark = !isDark;
    notifyListeners();
  }
}