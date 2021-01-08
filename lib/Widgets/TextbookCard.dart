import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:http/http.dart' as http;

class TextbookCard extends StatelessWidget
{

  Textbook tb;
  List<Widget> children;
  Function() clickable;
  TextbookCard(Textbook tb, Function() clickable, [List<Widget> children])
  {
    this.tb = tb;
    this.clickable = clickable;
    this.children = children;
  }

  @override
  Widget build(BuildContext context) {
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
                          if (snapshot.data.body.isNotEmpty &&snapshot.data.bodyBytes.toString().length <= 10000)
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
                            padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                            child: Column
                              (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: children ??[Text(tb.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),Text(tb.getDisplayAuthors(3),maxLines: 2,overflow: TextOverflow.ellipsis),]
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
  }