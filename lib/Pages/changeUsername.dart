import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

import 'LandingPage.dart';


class ChangeUserName extends StatelessWidget {
  ChangeUserName();
  TextEditingController textController =
  new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    return Scaffold(
      appBar: AppBar(title: Text('Change Your Name'),
        backgroundColor: Colors.blue,),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Container(
            height: 80.0,
            width: 200.0,
            child: TextField(
                decoration: new InputDecoration(
                    labelText: "New Name",
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
          FlatButton(onPressed: () {

            new DatabaseRouting().updateUserName(textController.text);
            Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LandingPage()));
            }, child: Text('Submit New Name'), color: Colors.blue,)

        ],
      ),

    );
  }
}