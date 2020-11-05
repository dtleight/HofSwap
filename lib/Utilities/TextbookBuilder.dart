import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'TextbookAPILoader.dart';

class TextbookBuilder
{
  TextbookBuilder()
  {

  }
  String nullImage = "[71, 73, 70, 56, 57, 97, 1, 0, 1, 0, 247, 0, 0, 0, 0, 0, 0, 0, 51, 0, 0, 102, 0, 0, 153, 0, 0, 204, 0, 0, 255, 51, 0, 0, 51, 0, 51, 51, 0, 102, 51, 0, 153, 51, 0, 204, 51, 0, 255, 102, 0, 0, 102, 0, 51, 102, 0, 102, 102, 0, 153, 102, 0, 204, 102, 0, 255, 153, 0, 0, 153, 0, 51, 153, 0, 102, 153, 0, 153, 153, 0, 204, 153, 0, 255, 204, 0, 0, 204, 0, 51, 204, 0, 102, 204, 0, 153, 204, 0, 204, 204, 0, 255, 255, 0, 0, 255, 0, 51, 255, 0, 102, 255, 0, 153, 255, 0, 204, 255, 0, 255, 0, 51, 0, 0, 51, 51, 0, 51, 102, 0, 51, 153, 0, 51, 204, 0, 51, 255, 51, 51, 0, 51, 51, 51, 51, 51, 102, 51, 51, 153, 51, 51, 204, 51, 51, 255, 102, 51, 0, 102, 51, 51, 102, 51, 102, 102, 51, 153, 102, 51, 204, 102, 51, 255, 153, 51, 0, 153, 51, 51, 153, 51, 102, 153, 51, 153, 153, 51, 204, 153, 51, 255, 204, 51, 0, 204, 51, 51, 204, 51, 102, 204, 51, 153, 204, 51, 204, 204, 51, 255, 255, 51, 0, 255, 51, 51, 255, 51, 102, 255, 51, 153, 255, 51, 204, 255, 51, 255, 0, 102, 0, 0, 102, 51, 0, 102, 102, 0, 102, 153, 0, 102, 204, 0, 102, 255,";
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
                  //Expanded(child: Image.network("http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg",fit: BoxFit.contain,),flex: 2,),
                Expanded(child: FutureBuilder(
                // Paste your image URL inside the htt.get method as a parameter
                future: http.get(
                "http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg"),
          builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("No connection");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.data.bodyBytes.toString().length <= 10000)
                  return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png",fit: BoxFit.contain,);
                // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
                return Image.memory(snapshot.data.bodyBytes, fit: BoxFit.contain);
            }
            return null; // unreachable
          },
        ),flex:3),
                  //Expanded(child: FadeInImage.assetNetwork(placeholder: "assets/logo.png", image: "http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg",fit: BoxFit.contain,),flex: 2,),
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
    final response = await http.get('https://www.googleapis.com/books/v1/volumes?q=+isbn='+ ISBN + '&key=AIzaSyCo9OIQaOJ97f1tuIistw-XU0NGdtsn2Rk');
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
    String str = "https://www.googleapis.com/books/v1/volumes?q=+" + queryParams + "&key=AIzaSyCo9OIQaOJ97f1tuIistw-XU0NGdtsn2Rk";
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
    print(isbn + title + authors);
    String queryParams = "";
    List<String> prefixes = ["isbn=","title=","inauthor="];
    List<String> params = [isbn,title,authors];
    for (int i = 0; i <= 2; i++)
    {
      if(params[i] != "")
        {
          queryParams = queryParams + "+" + prefixes[i] + params[i];
        }
      print(queryParams);
    }
    String querParams = ["isbn="+ isbn,"+title="+title, "+inauthor="+authors].toString();
    //String queryParams = string.replaceAll(new RegExp(" *"), "").replaceAll(new RegExp(":"), "=").replaceAll(new RegExp(","), "+");
    String str = "https://www.googleapis.com/books/v1/volumes?q="+ queryParams +"+&key=AIzaSyCo9OIQaOJ97f1tuIistw-XU0NGdtsn2Rk";
    print(str);
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

  Widget getTextbookImage(String ISBN)
  {
    Expanded(child: FutureBuilder(
      // Paste your image URL inside the htt.get method as a parameter
      future: http.get(
          "http://covers.openlibrary.org/b/isbn/" +ISBN +"-M.jpg"),
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("No connection");
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.data.bodyBytes.toString().length <= 10000)
              return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png",fit: BoxFit.contain,);
            // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
            return Image.memory(snapshot.data.bodyBytes, fit: BoxFit.contain);
        }
        return null; // unreachable
      },
    ),flex:3);
  }

}
