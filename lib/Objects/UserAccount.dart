import 'package:hofswap/Objects/Account.dart';
import 'Textbook.dart';

class UserAcount extends Account
{
  String hofstraID;
  List<Textbook> wishlist;
  List<Textbook> soldBooks;

  UserAcount(String name, Map<String,Account> following, Map<String,Account> followers, List<Textbook> booksOnSale, int rating, String hofstraID, List<Textbook> wishlist, List<Textbook> soldBooks) : super(name,following,followers,booksOnSale,rating)
  {
    this.hofstraID = hofstraID;
    this.wishlist = wishlist;
    this.soldBooks = soldBooks;
  }
}
