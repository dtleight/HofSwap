import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword();
  TextEditingController textController =
  new TextEditingController();
  @override
  Widget build(BuildContext context) {

    // ignore: non_constant_identifier_names
    return Scaffold(
      appBar: AppBar(title: Text('Change Your Password'),
        backgroundColor: Colors.blue,),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Container(
            height: 80.0,
            width: 200.0,
            child: TextField(
              decoration: new InputDecoration(
                  labelText: "New password",
                  filled: true,
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, width: 1.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, width: 1.0))),
              controller: textController
          ),
          ),
          FlatButton(onPressed:(){
            _changePassword(textController.text);
            //new DatabaseRouting().updateUserName(value)
            Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LandingPage()));
            }, child: Text('Submit New Password'),color: Colors.blue,)
        ],
      ),

    );
  }

  void _changePassword(String password) async {
    User Currentuser =  FirebaseAuth.instance.currentUser;
    Currentuser.updatePassword(password).then((value) {
      print("changed");
    }).catchError((
        error) {
      print("Password can't be changed" + error.toString());
    });
  }
}