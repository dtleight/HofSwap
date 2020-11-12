import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        .addAll([new TextEditingController(), new TextEditingController(), new TextEditingController()]);
    return Scaffold(
        appBar: AppBar(title: Text("Forgot Password"),
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
                        /* Padding(
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
                          ),*/
                            Builder(
                              builder: (context) {
                                return FlatButton(
                                  color: Colors.indigoAccent,
                                    onPressed: () async {
                                     if(textControllers[0].text != "" && textControllers[2].text != "") {
                                        if (resetNum < 2) {
                                          if (textControllers[0].text.length ==
                                              9 &&
                                              textControllers[0].text.substring(
                                                  0, 2) == "70" && num.tryParse(
                                              textControllers[0].text) !=
                                              null) {
                                            final snapShot = await FirebaseFirestore
                                                .instance.collection('users')
                                                .doc(textControllers[0].text)
                                                .get();
                                            if (snapShot.exists) {
                                              String em = snapShot['email'];
                                              if (textControllers[2].text ==
                                                  em) {
                                                if (true) {
                                                  await new DatabaseRouting()
                                                      .forgetPassword(
                                                      textControllers[2].text);
                                                  //FirebaseFirestore.instance.collection("users").doc(textControllers[0].text).update({'password': result});
                                                  resetNum++;
                                                  Scaffold.of(context)
                                                      .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Please Check Your Email to change your password"),));

                                                  // ignore: missing_return
                                                  //textControllers[0].text, context);
                                                }
                                                else {
                                                  Scaffold.of(context)
                                                      .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Your Password must contain at least 6 characters"),));
                                                }
                                              }
                                              else {
                                                Fluttertoast.showToast(
                                                    msg: "This is not the correct email",
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
                                                  msg: "Not a valid Hofstra ID",
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
                                                msg: "Not a valid Hofstra ID",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black38,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "You cannot reset your password again",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black38,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                      }
                                      else{
                                       Fluttertoast.showToast(
                                           msg: "Please fill all of the boxes",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Colors.black38,
                                           textColor: Colors.white,
                                           fontSize: 16.0
                                       );
                                      }  


                                    },
                                    child: Text("Submit", style: TextStyle(color: Colors.white))

                                  );
                              }
                            )
                                 ])))));
  }
 /* void sendEmail() async
  {
    Account sender = new Account.instantiate("Dalton Leight","dleight1@pride.hofstra.edu",0);

    String username = "";
    String password = "";

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(sender.email) //recipent email
      ..subject = 'I am Interested in Your Textbook!' //subject of the email
      ..text = 'Hello ' + sender.name + "! \n\nI am interested in purchasing your copy of " + tb.title
          + ". Please let me know if it is still available! \n\nThank you,\n"+ new UserAccount().name; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
      isSuccessful = true;
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }

  } */
}
