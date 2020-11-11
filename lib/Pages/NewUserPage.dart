import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Pages/LoginPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
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
    textControllers.addAll([
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController()
    ]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.subdirectory_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.yellow,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image(image: AssetImage("assets/logo.png"))),
                Text("Please Enter the Following Information:", textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height: 70.0,
                    width: 250.0,
                    child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                            labelText: "Name",
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
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 70.0,
                    width: 250.0,
                    child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                            labelText: "Hofstra Email",
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
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 70.0,
                    width: 250.0,
                    child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                            labelText: "Hofstra ID (Without the H)",
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
                        controller: textControllers[2]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 70.0,
                    width: 250.0,
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
                        controller: textControllers[3]),
                  ),
                ),
                Builder(
                  builder: (context) {
                    return FlatButton(
                        onPressed: () async {

                          //call firebase to create new user
                          //show error if exists

                          if (textControllers[0].text != "" && textControllers[1].text != "" && textControllers[3].text!= "" && textControllers[2].text!= "") { //makes sure that Name is not left blank
                             //make sure the Hofstra ID is not currently used
                              if (textControllers[1].text.length >
                                  17) { //makes sure email is at least long enough
                                if (textControllers[1].text.substring(
                                    textControllers[1].text.length - 18,
                                    textControllers[1].text.length) ==
                                    "@pride.hofstra.edu") { //make sure the email is provided by Hofstra
                                  if (textControllers[2].text.length == 9 &&
                                      textControllers[2].text.substring(0, 2) ==
                                          "70" &&
                                      num.tryParse(textControllers[2].text) !=
                                          null) {
                                    final snapShot = await FirebaseFirestore.instance.collection('users').doc(textControllers[2].text).get();
                                    if (!snapShot
                                        .exists) { //make sure the Hofstra ID is correct length, starts with 70 and is only numbers
                                      if (textControllers[3].text.length >= 6) {
                                        String result = await new DatabaseRouting()
                                            .generateUser(
                                            textControllers[0].text,
                                            textControllers[1].text,
                                            textControllers[2].text,
                                            textControllers[3].text,
                                            context);

                                        Fluttertoast.showToast(
                                            msg: "Account Created. Go to your email and Verify your account",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black38,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );

                                        if (result == null) {
                                          //open login screen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                          );
                                        }
                                        else {
                                          //show dialog with the error
                                          _showError(result);
                                        }
                                      }
                                      else {

                                        Fluttertoast.showToast(
                                            msg: "Your Password be at least 6 Characters in Length",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black38,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                    }

                                    else {
                                      Fluttertoast.showToast(
                                          msg: "This Hofstra ID is Already in Use",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black38,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  }
                                  else {
                                    Fluttertoast.showToast(
                                        msg: "Invalid Hofstra ID",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black38,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                }
                                else {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter a Hofstra email",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black38,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              }
                              else {
                                Fluttertoast.showToast(
                                    msg: "Invalid Email",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black38,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                          }
                          else {
                            Fluttertoast.showToast(
                                msg: "Please Enter all Required Information",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black38,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }

                          },

                        color: Colors.indigoAccent,
                        child: Text("Create", style:TextStyle(color: Colors.white)));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showError(error) async{
    return showDialog<void>(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title:  Text ( 'Create New Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(error),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            //  Navigator.push(
                //context,
                //MaterialPageRoute(builder: (context) => NewUserPage()),
            //  );
            }, child: Text('Please Try Again'),)
          ],
        );

      },
    );
  }
}
