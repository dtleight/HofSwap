import 'package:cloud_firestore/cloud_firestore.dart';
import '../Objects/Account.dart';
import '../Objects/Textbook.dart';
import 'UserAccount.dart';

class DatabaseRouting {

  static final DatabaseRouting _db = DatabaseRouting._internal();
  List<Textbook> textbooks;

  //Account account = new Account.instantiate("Scott Jefferys", null, null, null, 5, "scott.m.jefferys@hofstra.edu",);

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

  void addTextbook(Textbook t) {
    // Call the user's CollectionReference to add a new user
    CollectionReference tbr = Firestore.instance.collection('textbooks');
    tbr.add({
      'ISBN': t.ISBN,
      'author': t.authors,
      'title': t.title,
      'edition': t.edition
    }).then((value) => print("Textbook Added")).catchError((error) =>
        print("Failed to add textbook: $error"));
  }

  Future<void> verifyUser(String email, String password) async
  {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = Firestore.instance.collection('users');
    DocumentSnapshot doc = await users.document(email).get();
    if (doc.data != null && password == doc.data["password"] as String) {
      //User is validated
      Map<String, dynamic> data = doc.data;
      new UserAccount.instantiate(
          data['name'], email, data['rating'], data['id'], data['wishlist']);
      loadHomePage();
    }
    else {
      promptAccountInvalid();
    }


    // Call the user's CollectionReference to add a new user

  }

  void loadHomePage() {

  }

  void promptAccountInvalid() {

  }

  void generateUser(String name, String email, String id, String password) async
  {
    //Verify email is Hofstra email
    //After Verification
    UserAccount account = new UserAccount.instantiate(
        name, email, null, id, new List<Textbook>());
    CollectionReference users = Firestore.instance.collection('users');
    DocumentSnapshot ds = await users.document(email).get();
    if (ds.exists) {
      await Firestore.instance.collection('users').document(email).updateData(
          {
            'email': email,
            'name': name,
            'password': password,
            'id': id,
            'rating': 0,
            'wishlist': account.wishlist,
          }
      );
    }
  }
/**
    users.add
      (
        {
          'documentID': email,
          'data':
        }

    ).then((value) => print("User Added")).catchError((error) =>
        print("Failed to add user: $error"));
  }
**/


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
    await Firestore.instance.collection('users').document(us.email).updateData(
        {'wishlist': us.wishlist});
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
}