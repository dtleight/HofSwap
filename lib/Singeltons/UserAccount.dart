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

  UserAccount.instantiate(String name, String email, double rating, String hofstraID, List<Textbook> wishlist) : super.instantiate(name,email,rating)
  {
    _account.name = name;
    _account.email = email;
    _account.rating = rating;
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
