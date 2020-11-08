import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/changePicturePage.dart';
import 'package:hofswap/Pages/changePassword.dart';

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
      appBar: AppBar(title: Text("Settings"),backgroundColor: Colors.green,),
      body: Column(
        children:[
          Text('Change New User Name'),
          FlatButton(onPressed: (){

              }, child: Text('Change Name'), color: Color.fromARGB(255,0,0,254),),
          Text('Change User picture'),
          FlatButton(onPressed: () {
             Navigator.push(context, new MaterialPageRoute(builder: (ctext) => new ChangePicturePage()));
             },color: Color.fromARGB(255,0,0,254), child: Text('Change Picture'),),
          Text('Change Password'),
          FlatButton(onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (ctext) => new ChangePassword()));
              }, child: Text('Change Password'), color: Color.fromARGB(255, 0, 0, 254),),
          Text('Change To Dark Mode'),
          FlatButton(onPressed: () {

              }, child: Text('DarkMode'),color: Color.fromARGB(255, 0, 0, 254),),
        ] ,
      ),


      );
  }

  Future<void> _showChangePassword(newPassword) async{
  }


}