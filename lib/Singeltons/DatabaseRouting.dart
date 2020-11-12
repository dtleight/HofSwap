import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Pages/LoginPage.dart';
import 'package:hofswap/Pages/forgetPasswordPage.dart';
import '../Objects/Account.dart';
import '../Objects/Textbook.dart';
import '../name_state.dart';
import 'UserAccount.dart';

class DatabaseRouting {

  static final DatabaseRouting _db = DatabaseRouting._internal();
  List<Textbook> textbooks;
  Map<String,Textbook> textbookse;


  factory DatabaseRouting()
  {
    return _db;
  }

  DatabaseRouting._internal();
  ///
  ///Initializes the DatabaseRouting singleton
  ///
  void init() async
  {
    await loadTextbooks();
  }
  ///
  /// Adds a textbook into the database
  ///
  void addTextbook(Textbook t, String condition, double price, ) async
  {
    UserAccount us = new UserAccount();
    // Call the user's CollectionReference to add a new user
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('textbooks').doc(t.ISBN).get();
    if(documentSnapshot.data() != null)
      {
        Map<String, dynamic> appendMap = documentSnapshot.data()['sale_log'];
        appendMap[us.email] = {'condition': condition, 'price': price};
        await FirebaseFirestore.instance.collection('textbooks').doc(t.ISBN).set(
            {
              'title': t.title,
              'author': t.authors.cast<dynamic>().toList(),
              //'edition': t.edition
              'sale_log' : appendMap,
            }
        );
      }
    else
      {
        await FirebaseFirestore.instance.collection('textbooks').doc(t.ISBN).set(
            {
              'title': t.title,
              'author': t.authors.cast<dynamic>().toList(),
              //'edition': t.edition
              'sale_log' : {us.email:{'condition':condition, 'price': price}}
      }
        );
      }
    ///
    /// Add a reference to the user of their sold textbook
    ///
    us.addSaleTextbook(t.ISBN);
    await FirebaseFirestore.instance.collection('users').doc(us.hofstraID).update(
        {
          'soldBooks': us.soldBooks,
        }
    );
    loadTextbooks();
  }

  ///
  /// Confirm that the user is able to use the database
  ///
  Future<void> verifyUser(String id, String password, BuildContext context) async
  {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot doc = await users.doc(id).get();
    String emil = doc.data()['email'];
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emil, password: password);
      //User is validated
      Map<String, dynamic> data = doc.data();
      new UserAccount.instantiate(
          data['name'], data['email'], data['rating'], id,
          data['wishlist'].cast<String>().toList(),data['soldBooks'].cast<String>().toList());
      Navigator.push(
          context, new MaterialPageRoute(builder: (ctxt) => new LandingPage()));
    }catch(_) {
      Fluttertoast.showToast(
          msg: "Incorrect Password or you have not Validated your account",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  ///
  /// Create a new user in the database
  ///
  Future<String> generateUser(String name, String email, String id, String password, BuildContext context) async
  {

    try{
      UserAccount account = new UserAccount.instantiate(
          name, email, 5, id, new List<String>(), new List<String>());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser.sendEmailVerification();

      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(id).set(
          {
            'id':FirebaseAuth.instance.currentUser.uid,
            'email': email,
            'name': name,
            'rating':5,
            'wishlist': [],
            'verified': FirebaseAuth.instance.currentUser.emailVerified,
            'soldBooks': [],
          }
      );
      return null;

    } catch(signUpError) {
          print(signUpError.message.toString());
          return signUpError.message.toString();
    }
  }
  ///
  /// Pulls all textbook data from the database
  ///
  loadTextbooks() async
  {
    textbooks = new List();
    textbookse = new Map<String,Textbook>();
    CollectionReference ref = FirebaseFirestore.instance.collection('textbooks');
    QuerySnapshot eventsQuery = await ref.get();
    eventsQuery.docs.forEach((document) {
      textbookse[document.id] = new Textbook.temporary(document['title'], document['author'], document.id, document['sale_log']);
    }
    );
    textbooks = textbookse.values.toList();

  }

  ///
  /// Pulls a specific textbook from the database
  ///
  Future<Textbook> queryTextbook(String isbn) async
  {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('textbooks').doc(isbn).get();
    if(data.exists)
      {
        return Textbook.temporary(data['title'], data['author'], isbn, data['sale_log']);
      }
    else
      {
        return null;
      }
  }



  ///
  /// Adds wishlist data from the user acccount to the database
  ///
  updateWishlist() async
  {
    UserAccount us = new UserAccount();
    await FirebaseFirestore.instance.collection('users').doc(us.hofstraID).update
      (
        {
          'wishlist': us.wishlist
        }
      );
  }

  ///
  /// Updates user rating and wishlist
  ///
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

  ///
  /// Handles password reset
  ///
  forgetPassword(String email) async
  {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  ///
  /// Code to pull email credentials from the database
  ///
  Future<List<String>> getHofswapInformation() async
  {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('private_data').doc("hofswap_info").get();
    return [data['username'],data['password']];
  }

  ///
  /// Removes a textbook from the textbook collection and also removes it from the user account reference.
  ///
  void deleteTextbook(String email, String isbn, int index) async
  {
    Map<String,dynamic> temp = textbookse[isbn].sale_log.remove(email);
    new UserAccount().soldBooks.removeAt(index);
    textbookse[isbn].sale_log.keys.length == 0?await FirebaseFirestore.instance.collection('textbooks').doc(isbn).delete():await FirebaseFirestore.instance.collection('textbooks').doc(isbn).update({'sale_log': textbookse[isbn].sale_log,});
    await FirebaseFirestore.instance.collection('users').doc(new UserAccount().hofstraID).update
      (
      {
        'soldBooks': new UserAccount().soldBooks
      }
    );
    loadTextbooks();
  }

  ///
  /// Changes the name field for a user
  ///
  updateUserName(String value) async
  {
    UserAccount account = new UserAccount();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot ds = await users.doc(account.hofstraID).get();
    if (ds.exists) {
      await FirebaseFirestore.instance.collection('users').doc(account.hofstraID).update(
          {
           "name" :  value
          }
      );
     NameState().name = value;
    }
  }

}
