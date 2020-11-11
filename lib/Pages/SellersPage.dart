import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Popouts/SellersPopout.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../theme_state.dart';

class SellersPage extends StatefulWidget {
  SellersPage() {}

  @override
  State<StatefulWidget> createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage>
{

  _SellersPageState() {
    textControllers.addAll([new TextEditingController(), new TextEditingController(), new TextEditingController()]);
    widgy = constructForm(context);
  }
  List<TextEditingController> textControllers = new List<TextEditingController>();
  Widget widgy;
  String placeholderValue = "Good";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (TextEditingController t in textControllers) {
      t.dispose();
    }
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller's Interface"),
      ),
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: AnimatedSwitcher(
              child: widgy,
              duration: Duration(seconds: 1),
            ),
          ),
        ],
      ),
    );
  }
  ///
  /// This page provides the textboxes that the user uses to search for textbooks to add to the database
  ///
  Widget constructForm(var context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please Enter the Following Information:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),

                ...addField(0, "Textbook Title", (value) {
                  if (value == "" &&
                      textControllers[1].text == "" &&
                      textControllers[2].text == "") {
                    return "One field needs a value";
                  }
                  return null;
                }, ),
                ...addField(1, "ISBN Number", (value) {
                  if (value == "" &&
                      textControllers[0].text == "" &&
                      textControllers[2].text == "") {
                    return "One field needs a value";
                  }
                  return null;
                }),
                ...addField(2, "Author", (value) {
                  if (value == "" &&
                      textControllers[0].text == "" &&
                      textControllers[1].text == "") {
                    return "One field needs a value";
                  }
                  return null;
                }),
                Align(
                  //alignment: Alignment.bottomCenter,

                  child: FlatButton(
                    color: Colors.indigoAccent,
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          widgy = constructSuggestions(textControllers[1].text, textControllers[0].text, textControllers[2].text);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Allows the user to confirm that the correct book was selected from the Seller's Interace suggestions.
  ///
  Widget confirmBook(Textbook tb) {
    return Center(
      child: Column(
        children: [
          Text(
            tb.title,
            textScaleFactor: 2,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          Expanded(
              child: FutureBuilder(
                // Paste your image URL inside the htt.get method as a parameter
                future: http.get("http://covers.openlibrary.org/b/isbn/" +
                    tb.ISBN +
                    "-M.jpg"),
                builder: (BuildContext context,
                    AsyncSnapshot<http.Response> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("No connection");
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      if (snapshot.data.bodyBytes.toString().length <= 10000)
                        return Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png",
                          fit: BoxFit.contain,
                        );
                      // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
                      return Image.memory(snapshot.data.bodyBytes,
                          fit: BoxFit.contain);
                  }
                  return null; // unreachable
                },
              ),
              flex: 3),
          Text(tb.authors
              .toString()
              .substring(1, tb.authors.toString().length - 1),
            style: TextStyle(color: Colors.black),
          ),
          Text(tb.ISBN, style: TextStyle(color: Colors.black),),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              color: Colors.indigoAccent,
              child:
                  Text("Confirm", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  //Confirm page
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SellersPopout(tb);
                      });
                });
              },
            ),
          )
        ],
      ),
    );
  }

  ///
  /// Creates a page portion that displays the textbooks that were found in the API call
  ///
  Widget constructSuggestions(String isbn, String title, String author) {
    return FutureBuilder(
      future: TextbookBuilder().queryTextbook(isbn, title, author),
      builder: (BuildContext context, AsyncSnapshot<List<Textbook>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return TextbookBuilder().buildTextbookCell(snapshot.data[index],
                  () {
                setState(() {
                  widgy = confirmBook(snapshot.data[index]);
                });
              });
            },
          );
        }
        return Scaffold();
      },
    );
  }

  List<Widget> addField(int index, String text, [Function validation]) {
    return [
      Text(text, style: TextStyle(color: Colors.black, fontSize: 15)),
      Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 80.0,
          width: 250,
          child: TextFormField(style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(
                  labelText: "",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0))),
              controller: textControllers[index],
              validator: validation),
        ),
      )
    ];
  }
}
