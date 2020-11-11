import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';
import 'package:http/http.dart' as http;

class MyBooksForSale extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyBooksForSale();
}

class _MyBooksForSale extends State <MyBooksForSale> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(title: Text("My Books For Sale"),),
      body: Column(
          children: [
            ListView.builder
              (
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: new UserAccount().soldBooks.length,
              itemBuilder: (BuildContext context, int index) {
                Textbook tb = new DatabaseRouting().textbookse[new UserAccount()
                    .soldBooks[index]];
                return Container
                  (height: 150, width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        children: [
                          FutureBuilder(
                            // Paste your image URL inside the htt.get method as a parameter
                            future: http.get(
                                "http://covers.openlibrary.org/b/isbn/" + tb.ISBN + "-M.jpg"),
                            builder: (BuildContext context,
                                AsyncSnapshot<http.Response> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Text("No connection");
                                case ConnectionState.active:
                                case ConnectionState.waiting:
                                  return CircularProgressIndicator();
                                case ConnectionState.done:
                                  if (snapshot.data.bodyBytes
                                      .toString()
                                      .length <= 10000)
                                    return Image.network(
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png",
                                      fit: BoxFit.contain,);
                                  // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
                                  return Image.memory(
                                      snapshot.data.bodyBytes, fit: BoxFit.contain);
                              }
                              return null;
                            },), // unreachable
                         Column
                            (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>
                            [ Row(children: [Text(
                                  "Title: " + tb.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              ]),
                              Row(children: [Text("Authors: " +
                                  tb.getDisplayAuthors(tb.authors.length),
                                  overflow: TextOverflow.ellipsis, maxLines: 2),
                              ]),
                            Align(alignment: Alignment.bottomRight,
                              child: IconButton(icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Are You Sure You Want to \nDelete This Textbook?",
                                                textAlign: TextAlign.center),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                FlatButton(
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      new DatabaseRouting()
                                                          .deleteTextbook(
                                                          new UserAccount().email,
                                                          tb.ISBN, index);
                                                      //Remove textbook from database
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Confirm",
                                                        style: TextStyle(
                                                            color: Colors.white))
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            )
                          ],),
                      ]),
                    ),),
                );
              },
            ),
          ]),
    );
  }
}

