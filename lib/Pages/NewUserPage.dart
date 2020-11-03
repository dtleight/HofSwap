import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                Text("Fill in the Following Information:"),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 50.0,
                    width: 159.0,
                    child: TextField(
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
                    height: 50.0,
                    width: 159.0,
                    child: TextField(

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
                    height: 50.0,
                    width: 159.0,
                    child: TextField(
                        decoration: new InputDecoration(
                            labelText: "Hofstra ID (without the h)",
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
                    height: 50.0,
                    width: 159.0,
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
                        controller: textControllers[3]),
                  ),
                ),
                Builder(
                  builder: (context) {
                    return FlatButton(
                        onPressed: () async {

                          //call firebase to create new user
                          //show error if exists
                          if(textControllers[0].text != "") {
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
                                        null) { //make sure the Hofstra ID is correct length, starts with 70 and is only numbers
                                  if (textControllers[3].text.length >= 6) {
                                    String result = await new DatabaseRouting()
                                        .generateUser(
                                        textControllers[0].text,
                                        textControllers[1].text,
                                        textControllers[2].text,
                                        textControllers[3].text,
                                        context);

                                    if (result == null) {
                                      //open login screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    }
                                    else {
                                      //show dialog with the error
                                      _showError(result);
                                    }
                                  }
                                  else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          "Your Password should contain at least 6 characters"),));
                                  }
                                }

                                else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Invalid Hofstra ID"),));
                                }
                              }
                              else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Please type in a hofstra email"),));
                              }
                            }
                            else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Invalid email"),));
                            }
                          }
                          else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter a name"),));
                           }
                          },



                        child: Text("Create"));
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
          title:  Text ( 'set up new account'),
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
            }, child: Text('Please try again'),)
          ],
        );

      },
    );
  }
}
