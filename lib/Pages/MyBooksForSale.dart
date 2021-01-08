import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';
import 'package:hofswap/Widgets/TextbookCard.dart';

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
        body: ListView.builder
                (
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: new UserAccount().soldBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  Textbook tb = new DatabaseRouting().textbookse[new UserAccount().soldBooks[index]];
                  return TextbookCard(tb,(){},
                [
                  Text(tb.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(tb.getDisplayAuthors(3),maxLines: 1,overflow: TextOverflow.ellipsis),
                  Align(alignment: Alignment.bottomRight,
                      child: IconButton(
                      icon: Icon(Icons.delete),
                          onPressed: ()
                          {
                  showDialog(context: context,builder: (BuildContext context)
                  {
                        return AlertDialog(
                          title: Text(
                          "Are You Sure You Want to \nDelete This Textbook?", textAlign: TextAlign.center),
                          content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FlatButton
                            (
                              color: Colors.blue,
                              onPressed: ()
                              {
                              new DatabaseRouting().deleteTextbook(new UserAccount().email,tb.ISBN, index);
                              //Remove textbook from database
                              Fluttertoast.showToast(
                                  msg: "Textbook Deleted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black38,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.pop(context);
                              },
                              child: Text("Confirm",style: TextStyle(color: Colors.white))
                            )
                        ],
                        )
                        );
                        }
                        );
                        }
                        )
                        ),
                        ]
                        );
                      },
              )
    );
  }
}

