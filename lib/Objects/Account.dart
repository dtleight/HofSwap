import 'Textbook.dart';
class Account
{
  String name;
  Map<String,Account> following;
  Map<String,Account> followers;
  List<Textbook> booksOnSale;
  int rating;

}