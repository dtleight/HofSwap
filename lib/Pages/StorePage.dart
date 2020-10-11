import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/FocusedStoreView.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Utilities/TextbookAPILoader.dart';
import '../Objects/Textbook.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StorePage extends StatefulWidget {
  String txtBox = "Default";

  StorePage() {}

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  ///
  /// Textbox controller
  ///
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  ///
  /// This method handles the UI creation for the store page, The UI contains a textbox, and a button.
  ///
  ///

  Card c = new Card();
  Widget build(BuildContext context) {
    DatabaseRouting db = new DatabaseRouting();
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Row(children: <Widget>[Text("Search   "),Align(alignment: Alignment.centerRight ,child: Container(height: 80.0, width: 159.0, child:TextField(
          decoration: new InputDecoration(

            labelText: "Enter ISBN Number",
            fillColor: Colors.white,
            border: InputBorder.none
          ),
          controller: myController,
        ))), FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text("Enter"),
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          ///
          /// onPressed: handles the action when the button is pressed: this function calls a search of the Google Books APi and displays
          /// it in a DialogBox.
          ///
          onPressed: () async {
            Textbook t = await fetchBook(myController.text);
            return showDialog(context: context, builder: (context)
            {
              return AlertDialog(content:
              Column(
                children: <Widget>[
                  Text(t.title),
                  Flexible(child:Image.network("http://covers.openlibrary.org/b/isbn/"+myController.text +"-M.jpg",)),
                  Text(t.authors.toString()),
                ],
              ),
              );
            }
            );
          },
        )] , ),

      ),
      ///
      /// Dynamically creates new Textbook Display Objects based off of the list of textbooks.
      ///
      body: ListView.builder(itemBuilder: (BuildContext context, int i)
      {
        return buildTextbookCell(db.textbooks[i]);
      },
        itemCount: db.textbooks.length ,
      ),
    );
  }
Container buildTextbookCell(Textbook tb){
    return Container(height: 150.0, width: 500.0, child:
    GestureDetector(
      child: Card
      (
        child:Row
          (
            children: <Widget>
            [
              Image.network("http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg",),
              SizedBox(width: 50,),
              Align(alignment: Alignment.topLeft, child: Card(
                  borderOnForeground: false,
                  elevation:  0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>
                      [

                        Text(tb.title,style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(tb.authors[0]),
                        Text("Seller: Dalton Leight",),
                        Text("Price: \$99.99")

                      ]
                  )
              ))
            ]
        )
        ),
        onTap: () { Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new FocusedStoreView(tb)));}
      )
    );

}
  ///
  /// FetchBook handles retrieving the JSON information from the API call and instantiating a textbook object(for later use)
  /// it then returns the name of the book
  ///

  Future<Textbook> fetchBook(String ISBN) async {
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
}
