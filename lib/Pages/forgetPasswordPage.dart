import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

class forgetPasswordPage extends StatefulWidget {
  @override
  _forgetPasswordPage createState() => _forgetPasswordPage();
}

class _forgetPasswordPage extends State<forgetPasswordPage> {
  TextEditingController textController =
      new TextEditingController();

  @override
  void dispose() {
      textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                              controller: textController),
                        ),
                      ),
                      FlatButton(
                          onPressed: () async {
                            String result = await new DatabaseRouting().forgetPassword(textController.text);
                            print(result);
                            // ignore: missing_return
                            //textControllers[0].text, context);
                          },
                          child: Text("submit"))
                    ])))));
  }
}
