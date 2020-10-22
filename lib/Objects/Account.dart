import 'Textbook.dart';
class Account
{
  String name;
  double rating;
  String email;

  Account()
  {
  }
  Account.instantiate(String name, String email, double rating)
  {
    this.name = name;
    this.email = email;
    this.rating = rating;
  }


}