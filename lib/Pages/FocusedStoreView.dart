import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import '../Objects/Account.dart';

class FocusedStoreView extends StatelessWidget
{
  Textbook tb;
  FocusedStoreView(Textbook textbook)
  {
    this.tb = textbook;
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        appBar: AppBar(title: Text(tb.title + " by " + tb.authors.toString()),),
        body:Padding(
          padding: EdgeInsets.fromLTRB(0,10,0,0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            children: <Widget>
            [
              Image(image: NetworkImage("http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg"),),
              GridView.count
                (
                crossAxisCount: 2,
                childAspectRatio:2.7,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                children: <Widget>
                [
                  Text("Title: "),Text( tb.title),
                  Text("Authors: "), Text(tb.authors.toString()),
                  Text("Seller: "), Text("Dalton Leight"),
                  Text("Price: "), Text("99.99"),
                  Text("Condition: "), Text("Horrible"),
                ],
              ),
              FlatButton
                (

                child: Text("Add to Wishlist"),
                onPressed: () {return addToWishlist();},
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              FlatButton
                (
                child: Text("Contact Seller"),
                onPressed: () {return sendEmail();},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              )
            ],
          ),
        )


      /**
         * GridView.count
            (
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            children: <Widget>[
            SizedBox(height: 5),
            SizedBox(height: 5),
            Image(image: NetworkImage("http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg"),)
         */
      );
  }

  void sendEmail() async
  {
    Account sender = new Account.instantiate("Dalton Leight", null, null,null,0,"dleight1@pride.hofstra.edu");
  }
  void addToWishlist()
  {

  }
}