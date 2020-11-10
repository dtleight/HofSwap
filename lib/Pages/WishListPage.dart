import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';

import 'FocusedStoreView.dart';

class WishListPage extends StatefulWidget {
  WishListPage() {}

  @override
  State<StatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends State {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text("WishList"),
      ),
      body: FutureBuilder(
          future:  TextbookBuilder().runQueries(new UserAccount().wishlist),
          builder: (BuildContext context,
              AsyncSnapshot<List<Textbook>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return TextbookBuilder().buildTextbookCell(
                        snapshot.data[index], () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (ctxt) =>
                          new FocusedStoreView(
                              snapshot.data[index])));
                    }
                    );
                  }
              );
            }
            else
              {
                return CircularProgressIndicator();
              }
          }

      ),
    );
  }
}
