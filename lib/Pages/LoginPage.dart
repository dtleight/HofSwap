import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{

  List<TextEditingController> textControllers = new List<TextEditingController>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for(TextEditingController t in textControllers)
    {
      t.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textControllers.addAll([new TextEditingController(),new TextEditingController()]);
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("HofSwap"),
              Text("Don't Stop, HofSwap"),
              Align(alignment:Alignment.center, child:Image(image:AssetImage("assets/logo.png"))),
              Padding(padding: EdgeInsets.all(10),child: Container(height: 50.0, width: 159.0,child: TextField(decoration: new InputDecoration(labelText: "Username",filled:true,labelStyle: TextStyle(color: Colors.black,),fillColor: Colors.white,focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0)),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0))), controller: textControllers[0]),),),
              Padding(padding: EdgeInsets.all(10),child: Container(height: 50.0, width: 159.0,child: TextField(decoration: new InputDecoration(labelText: "Password",filled:true,labelStyle: TextStyle(color: Colors.black,),fillColor: Colors.white,focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0)),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0))), controller: textControllers[1]),),),
              FlatButton(onPressed: (){new DatabaseRouting().verifyUser(textControllers[0].text, textControllers[1].text);}, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}