import 'Textbook.dart';
class Account
{
  String name;
  Map<String,Account> following;
  Map<String,Account> followers;
  List<Textbook> booksOnSale;
  int rating;

  Account(String name, Map<String,Account> following, Map<String,Account> followers, List<Textbook> booksOnSale, int rating)
  {
    this.name = name;
    this.following = following;
    this.followers = followers;
    this.booksOnSale = booksOnSale;
    this.rating = rating;
  }
}