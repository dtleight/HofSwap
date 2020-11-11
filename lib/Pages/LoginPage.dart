import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Pages/NewUserPage.dart';
import 'package:hofswap/Pages/forgetPasswordPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<TextEditingController> textControllers =
      new List<TextEditingController>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (TextEditingController t in textControllers) {
      t.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textControllers
        .addAll([new TextEditingController(), new TextEditingController()]);
    return Scaffold
      (
      backgroundColor: Colors.yellow,
      body: Column
        (
        children:
          [
            Expanded(flex: 8, child: Image(image: AssetImage("assets/logo.png"),fit: BoxFit.fill,)),
           // Spacer(flex: 1,),
            Flexible(flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 70.0,
                  width: 250,
                  child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: new InputDecoration(
                          labelText: "Hofstra ID",
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
                      controller: textControllers[0]),
                ),
              ),
            ),
            Flexible(flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 70.0,
                  width: 250,
                  child: TextField(
                      style: TextStyle(color: Colors.black),
                            obscureText: true,
                      decoration: new InputDecoration(
                          labelText: "Password",
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
                      controller: textControllers[1]),
                ),
              ),
            ),
            Flexible(flex: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                  [
                    Spacer(flex: 1),
                    Expanded(flex: 6, child: buildButton("Create New Account",
                            (){Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new NewUserPage()));})),
                    Spacer(flex: 1),
                    Expanded(flex: 6, child: buildButton("Forgot Password",
                            (){Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new forgetPasswordPage()));})),
                    Spacer(flex: 1),
                  ]
              ),
            ),

            Flexible(flex: 2,
              child: Builder(
                builder: (context) {

                    return FlatButton(
                      onPressed: () async  {

                        if(textControllers[0].text != "" && textControllers[1].text != "") {
                          final snapShot = await FirebaseFirestore.instance
                              .collection('users').doc(
                              textControllers[0].text).get();
                          if (snapShot.exists) {
                            new DatabaseRouting().verifyUser(
                                textControllers[0].text, //univ id
                                textControllers[1].text, //password
                                context);

                          }
                            Fluttertoast.showToast(
                                msg: "An account with this Hofstra ID has not been created",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black38,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        else{
                          Fluttertoast.showToast(
                              msg: "Please fill in all the boxes",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black38,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        };

                      },
                      color: Colors.indigoAccent,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ));
                },
              ),
            ),
          ]
      ),
    );
  }
  Widget buildButton(String text, Function onPressed)
  {
      return FlatButton(
        onPressed: onPressed,
        color: Colors.indigoAccent,
        child: Text(text,
            style: TextStyle(color: Colors.white)),
      );
  }
}
