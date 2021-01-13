import 'package:flutter/cupertino.dart';

import 'Textbook.dart';
class Account
{
  String name;
  int rating;
  String email;
  List<String> conversationIDS;

  Account()
  {
  }
  Account.instantiate(String name, String email, int rating, List<String> conversationIDS)
  {
    this.name = name;
    this.email = email;
    this.rating = rating;
    this.conversationIDS = conversationIDS;
    print(conversationIDS);
  }


}
