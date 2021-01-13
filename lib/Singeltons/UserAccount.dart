import 'package:hofswap/Objects/Account.dart';
import '../Objects/Textbook.dart';

class UserAccount extends Account
{
  String hofstraID;
  List<String> wishlist;
  List<String> soldBooks;
  String email;
  List<String> conversationIDS;
  static final UserAccount _account = UserAccount._internal();

  factory UserAccount()
  {
    return _account;
  }

  UserAccount.instantiate(String name, String email, int rating, String hofstraID, List<String> wlist, List<String> soldBooks, List<String> conversationIDS) : super.instantiate(name,email,rating,conversationIDS)
  {
    _account.name = name;
    _account.email = email;
    _account.rating = rating;
    _account.hofstraID = hofstraID;
    _account.wishlist = wlist;
    _account.soldBooks = soldBooks;
    _account.conversationIDS = conversationIDS;
  }
  UserAccount._internal();

  void init() {}

  String toString()
  {
    return this.name;
  }

  void addSaleTextbook(String ISBN)
  {
    soldBooks.add(ISBN);
  }


}
