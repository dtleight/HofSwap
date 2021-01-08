import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';
import 'package:hofswap/Widgets/TextbookCard.dart';

import 'FocusedStoreView.dart';

class WishListPage extends StatefulWidget {
  WishListPage() {}

  @override
  State<StatefulWidget> createState() => _WishlistPageState();
}

class _WishlistPageState extends State {
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
        title: Text("Wishlist"),
      ),
      body: FutureBuilder(
          future:  TextbookBuilder().runQueries(new UserAccount().wishlist),
          builder: (BuildContext context,
              AsyncSnapshot<List<Textbook>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return TextbookCard(
                        snapshot.data[index], () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (ctxt) =>
                          new FocusedStoreView(
                              snapshot.data[index])));
                    },[
                      Text(snapshot.data[index].title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(snapshot.data[index].getDisplayAuthors(3),maxLines: 1,overflow: TextOverflow.ellipsis),
                      Align(alignment:Alignment.centerRight,child: IconButton(icon:Icon(Icons.delete), onPressed: (){
                        //Remove book from the database
                        new UserAccount().wishlist.removeAt(index);
                        new DatabaseRouting().updateWishlist();
                        Fluttertoast.showToast(
                            msg: "Item removed from wishlist",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black38,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        }),
                    )]
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
