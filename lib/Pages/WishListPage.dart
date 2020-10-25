import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Objects/Textbook.dart';

import 'FocusedStoreView.dart';

class WishListPage extends StatefulWidget
{
  WishListPage(){}

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State
{

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WishList"), backgroundColor: Colors.green,),
      body:ListView.builder(itemCount: new UserAccount().wishlist.length, itemBuilder: (context,index)
      {
      return buildTextbookCell(new DatabaseRouting().textbooks[index]);
      }
      ),

    );
  }

  Widget buildTextbookCell(Textbook tb)
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
                                children:
                                [
                                  Text(tb.title,style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(tb.authors[0]),
                                ]
                            ),
                          )
                      )),
                    ),
                  ),
                ]
            )
        ),
        onTap: () { Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new FocusedStoreView(tb)));}
      ),
    );
  }
}
