import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/changePicturePage.dart';
import 'package:hofswap/Popouts/ChangePasswordPopout.dart';
import 'package:hofswap/theme_state.dart';
import 'package:provider/provider.dart';
import 'package:hofswap/Popouts/ChangeNamePopout.dart';

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
      backgroundColor: Colors.yellow,
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('Change Name'),
              trailing: Icon(Icons.more_vert),
              onTap: ()
                {
                  showDialog(context: context, builder: (context){return ChangeNamePopout();});
                },
            ),
          ),
           Card(
             child: ListTile(
               title: Text('Change Profile Picture'),
               trailing: Icon(Icons.more_vert),
               onTap: ()
              {
               Navigator.push(context, new MaterialPageRoute(builder: (ctext) => new ChangePicturePage()));
               },
             ),
           ),
          Card(
            child: ListTile(
              title: Text('Change Password'),
              trailing: Icon(Icons.more_vert),
              onTap: ()
                {
                  showDialog(context: context, builder: (context){return ChangePasswordPopout();});
                },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Dark Mode'),
              trailing: Icon(Icons.more_vert),
              onTap: ()
              {
              ThemeState provider = Provider.of<ThemeState>(context,listen: false);
              provider.changeTheme();
              },
            ),
          )
        ] ,
      ),
      );
  }
}