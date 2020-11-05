import 'package:hofswap/Objects/Account.dart';
import '../Objects/Textbook.dart';

class UserAccount extends Account
{
  String hofstraID;
  List<String> wishlist;
  List<String> soldBooks;
  String email;
  static final UserAccount _account = UserAccount._internal();

  factory UserAccount()
  {
    return _account;
  }

  UserAccount.instantiate(String name, String email, int rating, String hofstraID, List<String> wlist) : super.instantiate(name,email,rating)
  {
    _account.name = name;
    _account.email = email;
    _account.rating = rating;
    _account.hofstraID = hofstraID;
    _account.wishlist = wlist;
    _account.soldBooks = soldBooks;
  }
  UserAccount._internal();

  void init() {}

  String toString()
  {
    return this.name;
  }



}
