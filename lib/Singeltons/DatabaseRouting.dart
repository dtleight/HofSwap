import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Objects/Account.dart';
import '../Objects/Textbook.dart';

class DatabaseRouting
{
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


  void createUser(Account account)
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
      /**
          markers.add(new Marker(
          position: new LatLng(gp.latitude, gp.longitude),
          markerId: new MarkerId(document.documentID),
          onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheInfoPage(new Cache(document.documentID,document['cacheID'],gp))));}
          )
          );
       **/
    });
    print("Textbooks loaded");
    print(textbooks.toString());
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