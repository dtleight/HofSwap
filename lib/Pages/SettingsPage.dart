import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/changePicturePage.dart';
import 'package:hofswap/Pages/changePassword.dart';
import 'package:hofswap/theme_state.dart';
import 'package:provider/provider.dart';
import 'package:hofswap/Pages/changeUsername.dart';

class SettingsPage extends StatelessWidget
{
  SettingsPage(){}
  List<TextEditingController> textControllers =
  new List<TextEditingController>();
  @override
  Widget build(BuildContext context)
  {
    textControllers.addAll([
      //textControllers[0],
      //textControllers[1],
    ]);
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children:[
          SizedBox(height: 80,),
          Text('Change New User Name'),
          //TextStyle(color: Colors.yellow),
          FlatButton(onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (ctext) => new ChangeUserName()));
              }, child: Text('Change Name'), color: Color.fromARGB(255,0,0,254), textColor: Colors.yellow,),
          SizedBox(height: 10,),
          Text('Change User picture'),
          FlatButton(onPressed: () {
             Navigator.push(context, new MaterialPageRoute(builder: (ctext) => new ChangePicturePage()));
             },color: Color.fromARGB(255,0,0,254),  textColor: Colors.yellow, child: Text('Change Picture'),),
          SizedBox(height: 10,),
          Text('Change Password'),
          FlatButton(onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (ctext) => new ChangePassword()));
              }, child: Text('Change Password'), color: Color.fromARGB(255, 0, 0, 254), textColor: Colors.yellow),
          SizedBox(height: 10,),
          Text('Switch Between Light and Dark Mood'),
          FlatButton(onPressed: () {
            ThemeState provider = Provider.of<ThemeState>(context,listen: false);
            provider.changeTheme();

          }, child: Text('Switch'),color: Color.fromARGB(255, 0, 0, 254), textColor: Colors.yellow),
        ] ,
      ),
      );
  }
}