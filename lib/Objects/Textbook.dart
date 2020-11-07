import 'dart:math';

import 'package:hofswap/Singeltons/UserAccount.dart';

class Textbook
{
  String title;
  List<dynamic> authors;
  Map<String, dynamic> sale_log;
  int edition;
  String ISBN;
  String condition;
  String price;

  Textbook(String title, List<dynamic> authors, int edition, String ISBN, String condition)
  {
    this.title = title;
    this.authors = authors;
    this.edition = edition;
    this.ISBN = ISBN;
    this.condition = condition;
  }
  generateNewSeller(Textbook tb, String condition, String price)
  {
    if (sale_log == null)
      {
        sale_log = new Map<String, Map<String, String>>();
      }
    sale_log[new UserAccount().email] = {'condition':condition,'price':price};
  }

  Textbook.temporary(String title, List<dynamic> authors, String ISBN, Map<String, dynamic> sale_log)
  {
    this.title = title;
    this.authors = authors;
    this.ISBN = ISBN;
    this.sale_log = sale_log;
  }
  ///
  /// Method that allows for textbooks to be directly instantiated from JSON objects.
  ///
  ///
  ///
  /// NOTE: THIS WOULD BE A HELPFUL PLACE TO PULL THE SALE LOG
  ///
  factory Textbook.fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['volumeInfo']['industryIdentifiers'][0]['type'] == "ISBN_13")
        {
          return Textbook.temporary(json['volumeInfo']['title'],json['volumeInfo']['authors']??['No Author'],json['volumeInfo']['industryIdentifiers'][0]['identifier'],null);
        }
      else {
        return Textbook.temporary(json['volumeInfo']['title'], json['volumeInfo']['authors'] ?? ['No Author'], json['volumeInfo']['industryIdentifiers'][1]['identifier'],null);
      }
    }
    catch(Exception)
  {

  }
  return Textbook.temporary(json['volumeInfo']['title'],json['volumeInfo']['authors']??['No Author'],"",null);
  }

  String getDisplayAuthors(int n)
  {
    return authors.sublist(0, min(n,authors.length)).toString();
  }

  String getMinMaxPrice()
  {
    double m2 = 0;
    double m1 = 99999999999;
    print(sale_log.values);
    for(Map<String,dynamic > m in sale_log.values)
      {
        m2 = max(m2, double.parse(m['price'].toString()));
        m1 = min(m1, double.parse(m['price'].toString()));
      }
    return "" + m1.toString() + " - " + m2.toString() ;
  }
}