import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Pages/LoginPage.dart';
import 'package:hofswap/Pages/forgetPasswordPage.dart';
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
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    return await ref.get();
  }

  void addTextbook(Textbook t) async{
    // Call the user's CollectionReference to add a new use
   await FirebaseFirestore.instance.collection('textbooks').doc(t.ISBN).set(
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
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot doc = await users.doc(id).get();
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

  Future<String> generateUser(String name, String email, String id, String password, BuildContext context) async
  {

    try{
      UserAccount account = new UserAccount.instantiate(
          name, email, 0, id, new List<String>());
      print(account.wishlist);

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser.sendEmailVerification();
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(id).set(
          {
            'email': email,
            'name': name,
            'id':id,
            'password':password,
            'wishlist': [],
          }
      );

      //connect to firestore and save the new user information
      await Firestore.instance.collection('users').add({

          'email': email,
          'name': name,
          'id':id,
          'password':password,
          'wishlist': [],
          //'wishlist': account.wishlist.cast<dynamic>().toList(),

      });

      return null;

    } catch(signUpError) {
          print(signUpError.message.toString());
          return signUpError.message.toString();
    }
    //Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LandingPage()));
  }

    loadTextbooks() async
  {
    textbooks = new List();
    CollectionReference ref = FirebaseFirestore.instance.collection('textbooks');
    QuerySnapshot eventsQuery = await ref.get();
    eventsQuery.docs.forEach((document) {
      textbooks.add(new Textbook.temporary(
          document['title'], document['author'], document.id));
    }
    );
  }

  updateWishlist() async
  {
    UserAccount us = new UserAccount();
    await FirebaseFirestore.instance.collection('users').doc(us.email).update
      (
        {
          'wishlist': us.wishlist
        }
      );
  }

  updateUser() async
  {
    UserAccount account = new UserAccount();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot ds = await users.doc(account.email).get();
    if (ds.exists) {
      await FirebaseFirestore.instance.collection('users').doc(account.email).update(
          {
            'rating': account.rating,
            'wishlist': account.wishlist,
          }
      );
    }
  }

  forgetPassword(String email) async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email:email);
  }

}
