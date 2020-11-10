import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

class ChangePasswordPopout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordPopoutState();
  }
}
class _ChangePasswordPopoutState extends State<ChangePasswordPopout> {
  List<TextEditingController> textControllers =
  new List<TextEditingController>();

  @override
  Widget build(BuildContext context) {
    textControllers.addAll(
        [new TextEditingController(), new TextEditingController()]);
    // ignore: non_constant_identifier_names
    return AlertDialog(
      backgroundColor: Colors.yellow,
      title: Text('Change Your Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80.0,
            width: 200.0,
            child: TextField(
                decoration: new InputDecoration(
                    labelText: "New Password",
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
                controller: textControllers[0]
            ),
          ),
          Container(
            height: 80.0,
            width: 200.0,
            child: TextField(
                decoration: new InputDecoration(
                    labelText: "Confirm Password",
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
                controller: textControllers[1]
            ),

          ),
          FlatButton(
            onPressed: () {
              _changePassword(textControllers[0].text, textControllers[1].text);
              //new DatabaseRouting().updateUserName(value)
            },
            child: Text(
                'Submit New Password', style: TextStyle(color: Colors.white)),
            color: Colors.blue,)
        ],
      ),

    );
  }

  void _changePassword(String password, String confirmPassword) async {
    User Currentuser = FirebaseAuth.instance.currentUser;
    if(password.length < 6){
      Fluttertoast.showToast(
          msg: "Password must be 6 or more characters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else if (password == confirmPassword) {
      Currentuser.updatePassword(password).then((value) {
        print("Password Changed Successfully.");
      }
      ).catchError((error) {
        print("An Error Occurred. Please Try Again." + error.toString());
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Passwords Successfully Changed", textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton(
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LandingPage()));
                    },
                    child: Text("Continue", style: TextStyle(color: Colors.white)), color: Colors.blueAccent
                )
              ],
            ),
          );
        },
      );
    } // if statement
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Passwords Do Not Match. Please Try Again", textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Continue", style: TextStyle(color: Colors.white)), color: Colors.blueAccent
                )
              ],
            ),
          );
        },
      );
    } // else statement
  }
}