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
                          String result = await new DatabaseRouting().generateUser(
                              textControllers[0].text,
                              textControllers[1].text,
                              textControllers[2].text,
                              textControllers[3].text,
                              context);

                          if(result == null) {
                            //open login screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          }
                          else {
                            //show dialog with the error
                            _showError(result);
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }, child: Text('go to LOG IN'),)
          ],
        );

      },
    );
  }
}
