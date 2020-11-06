import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.yellow,
          body: Center(
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 3,
                    child: Image(image: AssetImage("assets/logo.png"))),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 70.0,
                      width: 250,
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
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 70.0,
                      width: 250,
                      child: TextField(
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
                FractionallySizedBox(
                  heightFactor: .05,
                ),
                  Flexible(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                      children: [
                        Flexible(
                        child: buildButton("Create New Account", (){Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new NewUserPage()));}),
                          // child: FlatButton
                          //   (
                          //   onPressed: () {
                          //     Navigator.push(
                          //         context,
                          //         new MaterialPageRoute(
                          //             builder: (ctxt) => new NewUserPage()));
                          //   },
                          //   color: Color.fromARGB(255, 0, 0, 254),
                          //   child: Text("Create New Account",
                          //       style: TextStyle(color: Colors.yellowAccent)),
                          // ),
                        ),

                        Flexible(
                          child: FlatButton
                            (
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(builder: (ctxt) => new forgetPasswordPage()));
                            },
                            child: Text("Forgot Password", style: TextStyle(color: Colors.yellowAccent),),
                            color: Color.fromARGB(255, 0, 0, 254),
                          ),
                        ),
                      ]

                    ),
                  ),

                Builder(

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
                                else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "An account with this Hofstra ID has not been created"),));
                                }
                              }
                              else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Please fill all of the boxes"),));
                              };
                            },
                            color: Color.fromARGB(255, 0, 0, 254),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.yellowAccent),
                            ));
                  },
                ),
              ],
            ),
          ),
        );
  }

  Widget buildButton(String text, Function onPressed){
    return FractionallySizedBox(
      widthFactor: 0.4,
      heightFactor: 1,

      child: FlatButton(
        onPressed: onPressed,
        color: Color.fromARGB(255, 0, 0, 254),
        child: Text(text,
            style: TextStyle(color: Colors.yellowAccent)),
      ),
    );
  }
}
