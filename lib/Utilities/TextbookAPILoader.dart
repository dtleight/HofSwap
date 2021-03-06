import 'dart:math';

import '../Objects/Textbook.dart';

///
/// This class handles the operations from the API and produces JSON textbooks.
///
class TextbookAPILoader
{
  List<Textbook> books;
  Textbook book;
  TextbookAPILoader(List<Textbook> books)
  {
    this.books = books.sublist(0,min(10,books.length));
    this.book = books[0];
  }

  factory TextbookAPILoader.fromJson(Map<String,dynamic> json)
  {
    var list = json['items'] as List;
    List<Textbook> bookList = list.map((i) => Textbook.fromJson(i)).toList();
    return TextbookAPILoader(bookList);
  }
}