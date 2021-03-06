import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

import '../Pages/LandingPage.dart';


class ChangeNamePopout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeNamePopoutState();
  }
}
class _ChangeNamePopoutState extends State<ChangeNamePopout>
{
  TextEditingController textController =
  new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names

          return AlertDialog(
            backgroundColor: Colors.yellow,
            title: Text('Change Your Name', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80.0,
                  width: 200.0,
                  child: TextField(
                      style: TextStyle(color: Colors.black),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Name Successfully Changed.", textAlign: TextAlign.center),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (ctxt) => new LandingPage()));
                                },
                                child: Text("Continue", style: TextStyle(color: Colors.white)), color: Colors.blueAccent
                            )
                          ],
                        ),
                      );
                    },
                  );

                }, child: Text('Submit Changes', style: TextStyle(color: Colors.white)), color: Colors.blue,)

              ],
            ),

          );
    }
  }
