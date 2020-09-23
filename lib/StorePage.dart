import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class StorePage extends StatelessWidget
{
  String txtBox = "Default";
  StorePage()
  {

  }

  Widget build(BuildContext context)
  {
    return new Scaffold
      ( body: Column(
      children: <Widget>
      [
        TextFormField
        (
          decoration: new InputDecoration
          (
            labelText: "Enter ISBN Number",
            fillColor: Colors.white,
            border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0), borderSide: new BorderSide(),),
          )
        ),
        FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () async
          {

           txtBox = await fetchBook();
           print(txtBox);
          },
          child: Text(
            txtBox,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Text(txtBox)
      ],
    )
    );
  }

  Future<String> fetchBook() async
  {
    print("Fetch Called");
    final response = await http.get('https://www.googleapis.com/books/v1/volumes?q=+isbn=9781947172623&key=AIzaSyB_mPqjpcjaEV1Wu593EY8czEAsuF-K_Nw');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Textbook.fromJson(json.decode(response.body)).book;
    }
    else
      {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load book');
      }
  }
}

class Textbook
{
  List books;
  String book;
  Textbook(List<Book> books)
  {
    this.books = books;
    this.book = books[0].title;
    print(book);
  }

  factory Textbook.fromJson(Map<String,dynamic> json)
  {
    var list = json['items'] as List;
    List<Book> bookList = list.map((i) => Book.fromJson(i)).toList();
    return Textbook(bookList);
  }
}
class Book
{
  String title;
  Book(String title)
  {
    this.title = title;
  }
  factory Book.fromJson(Map<String, dynamic> json)
  {
    return Book(json['volumeInfo']['title']);
  }
}
