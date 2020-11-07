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
  Map<String,Textbook> textbookse;


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

  /**
   * Code to be modified to check if textbook exists
   */
  void addTextbook(Textbook t, String condition, double price, ) async
  {
    // Call the user's CollectionReference to add a new user
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('textbooks').doc(t.ISBN).get();
    //Modify to one line  false?print("no"):print("true");
    if(documentSnapshot.data() != null)
      {
        print("Textbook found in database");
        Map<String, dynamic> appendMap = documentSnapshot.data()['sale_log'];
        appendMap[new UserAccount().email] = {'condition': condition, 'price': price};
        print(appendMap);
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
              'sale_log' : {new UserAccount().email:{'condition':condition, 'price': price}}
      }
        );
      }
    //await tbr.add().then((value) => print("Textbook Added")).catchError((error) => print("Failed to add textbook: $error"));

  }

  Future<void> verifyUser(String id, String password, BuildContext context) async
  {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot doc = await users.doc(id).get();
    String emil = doc.data()['email'];
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emil, password: password);
    //FirebaseAuth.instance.sendPasswordResetEmail(email: null)

    if (userCredential.user!=null) {
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
          name, email, 5, id, new List<String>());

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
            'verified': FirebaseAuth.instance.currentUser.emailVerified
          }
      );
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
    textbookse = new Map<String,Textbook>();
    CollectionReference ref = FirebaseFirestore.instance.collection('textbooks');
    QuerySnapshot eventsQuery = await ref.get();
    eventsQuery.docs.forEach((document) {
      textbookse[document.id] = new Textbook.temporary(document['title'], document['author'], document.id, document['sale_log']);
    }
    );
    textbooks = textbookse.values.toList();

  }

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

  //updatePassword(){
  // note to self: change password
  //}
  Future<List<String>> getHofswapInformation() async
  {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('private_data').doc("hofswap_info").get();
    return [data['username'],data['password']];
  }
}
