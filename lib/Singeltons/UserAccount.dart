import 'package:hofswap/Objects/Account.dart';
import '../Objects/Textbook.dart';

class UserAccount extends Account
{
  String hofstraID;
  List<Textbook> wishlist;
  List<Textbook> soldBooks;
  static final UserAccount _account = UserAccount._internal();

  factory UserAccount()
  {
    return _account;
  }

  UserAccount.instantiate(String name, Map<String,Account> following, Map<String,Account> followers, List<Textbook> booksOnSale, int rating, String email,  String hofstraID, List<Textbook> wishlist, List<Textbook> soldBooks) : super.instantiate(name,following,followers,booksOnSale,rating,email)
  {
    _account.name = name;
    _account.hofstraID = hofstraID;
    _account.wishlist = wishlist;
    _account.soldBooks = soldBooks;
  }
  UserAccount._internal();

  void init() {}

  String toString()
  {
    return this.name;
  }




}
