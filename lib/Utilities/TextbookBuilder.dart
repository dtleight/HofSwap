import 'dart:convert';

import 'package:hofswap/Objects/Textbook.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'TextbookAPILoader.dart';

class TextbookBuilder
{
  TextbookBuilder()
  {

  }
  //Widget[] childen
  Widget buildTextbookCell(Textbook tb, Function() clickable, [List<Widget> children])
  {
    return Container(height: 150.0, width: 500.0, child:
    GestureDetector(
        child: Card
          (
            child:Row
              (
                children:
                [
                  Expanded(child: Image.network("http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg",fit: BoxFit.contain,),flex: 2,),
                  Flexible(child: FractionallySizedBox(widthFactor: 0.1,heightFactor: 1.0,),),
                  Flexible(
                    flex: 8,
                    child:  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Align(alignment: Alignment.topLeft, child: Card(
                          borderOnForeground: false,
                          elevation:  0,
                          child: Padding
                            (
                            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: Column
                              (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: children ??[Text(tb.title,style: TextStyle(fontWeight: FontWeight.bold),),Text(tb.authors[0]),]
                            ),
                          )
                      )),
                    ),
                  ),
                ]
            )
        ),
        onTap: clickable
    ),
    );
  }
  Future<Textbook> fetchBook(String ISBN) async
  {
    final response = await http.get('https://www.googleapis.com/books/v1/volumes?q=+isbn='+ ISBN + '&key=AIzaSyB_mPqjpcjaEV1Wu593EY8czEAsuF-K_Nw');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, parse the json
      return TextbookAPILoader.fromJson(json.decode(response.body)).book;
    }
    else
    {
      //Lets us know that the api call failed
      throw Exception('Failed to load book');
    }
  }
  Future<Textbook> searchQuery(String string) async
  {
    String queryParams = string.replaceAll(new RegExp(" *"), "").replaceAll(new RegExp(":"), "=").replaceAll(new RegExp(","), "+");
    String str = "https://www.googleapis.com/books/v1/volumes?q=+" + queryParams + "&key=AIzaSyB_mPqjpcjaEV1Wu593EY8czEAsuF-K_Nw";
    final response = await http.get(str);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, parse the json
      return TextbookAPILoader.fromJson(json.decode(response.body)).book;
    }
    else
    {
      //Lets us know that the api call failed
      throw Exception('Failed to load book');
    }
  }


  Future<List<Textbook>> queryTextbook(String isbn,String title,String authors) async
  {
    //String queryParams = string.replaceAll(new RegExp(" *"), "").replaceAll(new RegExp(":"), "=").replaceAll(new RegExp(","), "+");
    String str = "https://www.googleapis.com/books/v1/volumes?q=+isbn="+ isbn??"" +"+title="+title??""+"+inauthor="+authors??""+"&key=AIzaSyB_mPqjpcjaEV1Wu593EY8czEAsuF-K_Nw";
    final response = await http.get(str);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, parse the json
      return TextbookAPILoader.fromJson(json.decode(response.body)).books;
    }
    else
    {
      //Lets us know that the api call failed
      throw Exception('Failed to load book');
    }
  }


}
