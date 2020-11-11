import 'package:flutter/cupertino.dart';

import 'Textbook.dart';
class Account
{
  String name;
  int rating;
  String email;

  Account()
  {
  }
  Account.instantiate(String name, String email, int rating)
  {
    this.name = name;
    this.email = email;
    this.rating = rating;
  }


}
