import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Pages/LoginPage.dart';
import '../Objects/Account.dart';
import '../Objects/Textbook.dart';
import 'UserAccount.dart';

class DatabaseRouting {

  static final DatabaseRouting _db = DatabaseRouting._internal();
  List<Textbook> textbooks;

  factory DatabaseRouting()
  {
    return _db;
  }

  DatabaseRouting._internal();

  void init() async
  {
    await loadTextbooks();
  }

  Future<QuerySnapshot> loadDatabase(String collection) async
  {
    CollectionReference ref = Firestore.instance.collection(collection);
    return await ref.getDocuments();
  }

  void addTextbook(Textbook t) async{
    // Call the user's CollectionReference to add a new use
   await Firestore.instance.collection('textbooks').document(t.ISBN).setData(
       {
         'title': t.title,
         'author': t.authors.cast<dynamic>().toList(),
         'edition': t.edition
       }
   );
    //await tbr.add().then((value) => print("Textbook Added")).catchError((error) => print("Failed to add textbook: $error"));
  }

  Future<void> verifyUser(String id, String password, BuildContext context) async
  {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = Firestore.instance.collection('users');
    DocumentSnapshot doc = await users.document(id).get();
    if (doc.data != null && password == (doc.data()["password"] as String)) {
      //User is validated
      Map<String, dynamic> data = doc.data();
      new UserAccount.instantiate(
          data['name'], data['email'], data['rating'] , id, data['wishlist'].cast<String>().toList());
      Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LandingPage()));
    }
    else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Invalid account entered"),));
    }
  }

  void generateUser(String name, String email, String id, String password, BuildContext context) async
  {
    //Verify email is Hofstra email
    //After Verification
    UserAccount account = new UserAccount.instantiate(
        name, email, 0, id, new List<String>());
    print(account.wishlist);

    CollectionReference users = Firestore.instance.collection('users');
    await users.document(id).setData(
      {
        'email': email,
        'name': name,
        'id':id,
        'password':password,
        'wishlist': [],
        //'wishlist': account.wishlist.cast<dynamic>().toList(),
      }
    );
    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LandingPage()));
  }

    loadTextbooks() async
  {
    textbooks = new List();
    CollectionReference ref = Firestore.instance.collection('textbooks');
    QuerySnapshot eventsQuery = await ref.getDocuments();
    eventsQuery.documents.forEach((document) {
      textbooks.add(new Textbook.temporary(
          document['title'], document['author'], document.documentID));
    }
    );
  }

  updateWishlist() async
  {
    UserAccount us = new UserAccount();
    await Firestore.instance.collection('users').document(us.email).updateData
      (
        {
          'wishlist': us.wishlist
        }
      );
  }

  updateUser() async
  {
    UserAccount account = new UserAccount();
    CollectionReference users = Firestore.instance.collection('users');
    DocumentSnapshot ds = await users.document(account.email).get();
    if (ds.exists) {
      await Firestore.instance.collection('users').document(account.email).updateData(
          {
            'rating': account.rating,
            'wishlist': account.wishlist,
          }
      );
    }
  }
  logOffUser() async
  {

  }
}