import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Objects/Account.dart';
import '../Objects/Textbook.dart';

class DatabaseRouting
{

  static final DatabaseRouting _db = DatabaseRouting._internal();
 List<Textbook> textbooks;
  Account account = new Account.instantiate("Scott Jefferys", null,null,null, 5, "scott.m.jefferys@hofstra.edu",);

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

  class AddUser (Account account){
    print("Database write started");

    final String email;
    final String id;
    final String name;
    final String password;

    AddUser(this.email, this.id, this.name, this.password);
    /*
    @override
    Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        Future<void> addUser() {
          // Call the user's CollectionReference to add a new user
          return users
              .add({
          'full_name': fullName, // John Doe
          'company': company, // Stokes and Sons
          'age': age // 42
          })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
        }

        return FlatButton(
          onPressed: addUser,
          child: Text(
          "Add User",
          ),
        );
    }
     */
  }
  avoid createUser(Account account)
  {
    print("Database write started");
    Firestore.instance.collection("users").document(account.name).setData(
        {
          'name': "Dalton Leight",
        }

    );
  }
/**
  Future<void> generateUser(String name, String email, String imageSRC) async
  {
    DocumentSnapshot ds = await Firestore.instance.collection("users").document(email).get();
    if(ds.data != null)
    {
      List<dynamic> cCompletions = new List<dynamic>();
      List<dynamic> bCompletions = new List<dynamic>();
      cCompletions.addAll(ds.data['cachesCompleted']);
      bCompletions.addAll(ds.data['badgesCompleted']);
      Account a = new Account.fromDatabase(name, email, imageSRC, ds.data['joinDate'], cCompletions, bCompletions);
    }
    else
    {
      createUser(Account.instantiate(name, email, imageSRC, Timestamp.now()));
    }
  }

  //Updates a users data
  void updateUser() async
  {
    Firestore.instance.collection('users').document('customer1').updateData({'completionCode':'randomizedString'});

  }
    **/

  loadTextbooks() async
  {
    textbooks = new List();
    CollectionReference ref = Firestore.instance.collection('textbooks');
    QuerySnapshot eventsQuery = await ref.getDocuments();
    eventsQuery.documents.forEach((document) {
      textbooks.add(new Textbook.temporary(document['title'], document['author'],document.documentID));
    });
  }
/**
  ///
  /// Saves data to account
  ///
  updateAccount(Account a) async
  {
    await Firestore.instance.collection('users').document(a.email).updateData(
        {
          'cachesCompleted': a.cacheCompletions,
          'badgesCompleted': a.badgeCompletions
        }
    );
  }
    **/
}