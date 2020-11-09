import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/SettingsPage.dart';

class ChangePicturePage extends StatelessWidget
{
  ChangePicturePage();
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    return Scaffold(
      appBar: AppBar(title: Text('Change Your Profile Picture'),
        backgroundColor: Colors.blue,),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                showPicker(context);
              },
              child: CircleAvatar(
                radius: 140,
                backgroundColor: Colors.yellow,
            ),
            ),

          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(onPressed: (){
            Navigator.push(context, new MaterialPageRoute(
                builder: (ctext) => new SettingsPage()));
              }, child: Text('Finished'))
        ],
      ),
    );
  }
  imgFromCamera() async {}
  imgFromGallery() async {}
  void showPicker(context){
  }
}