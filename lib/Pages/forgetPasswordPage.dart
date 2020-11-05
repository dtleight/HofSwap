import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';


int resetNum = 0;
class forgetPasswordPage extends StatefulWidget {
  @override
  _forgetPasswordPage createState() => _forgetPasswordPage();
}

class _forgetPasswordPage extends State<forgetPasswordPage> {
  List<TextEditingController> textControllers =
  new List<TextEditingController>();

  @override
  void dispose() {
    for (TextEditingController t in textControllers) {
      t.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textControllers
        .addAll([new TextEditingController(), new TextEditingController()]);
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
                      Text("Fill in the Following Information:"),
                      Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: 50.0,
                              width: 159.0,
                              child: TextField(
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
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: 50.0,
                              width: 159.0,
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
                                  controller: textControllers[1]),
                            ),
                          ),
                            Builder(
                              builder: (context) {
                                return FlatButton(
                                    onPressed: () async {
                                      final snapShot = await FirebaseFirestore.instance.collection('users').doc(textControllers[0].text).get();
                                      if(resetNum <2) {
                                        if (textControllers[0].text.length ==
                                            9 &&
                                            textControllers[0].text.substring(
                                                0, 2) == "70" && num.tryParse(
                                            textControllers[0].text) != null &&
                                            snapShot.exists) {
                                          if (textControllers[1].text.length >=
                                              6) {
                                            FirebaseFirestore.instance.collection("users").doc(textControllers[0].text).update({'password': textControllers[1].text});
                                            resetNum++;
                                            // ignore: missing_return
                                            //textControllers[0].text, context);
                                          }
                                          else {
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Your Password must contain at least 6 characters"),));
                                          }
                                        }
                                        else {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Not a valid Hofstra ID"),));
                                        }
                                      }else{
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "You cannot reset your password again"),));
                                      }

                                    },
                                    child: Text("submit")

                                  );
                              }
                            )
                                 ])))));
  }
}
