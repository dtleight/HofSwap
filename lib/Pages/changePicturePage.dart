import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Pages/SettingsPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ChangePicturePage extends StatefulWidget
{

  ChangePicturePage();

  @override
  _ChangePicturePageState createState() => _ChangePicturePageState();
}

class _ChangePicturePageState extends State<ChangePicturePage> {

  File _savedImage;

  File _localFile;

  @override
  void initState(){



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names

   if(_localFile==null) {
     getApplicationDocumentsDirectory().then((value) {
       String path = value.path;
      setState(() {
        _localFile = File(path + "/image1.png");
      });
     });
   }


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
                 _showPicker(context);
               },
               child: CircleAvatar(
                 child: _localFile == null ? Container() :ClipRRect(
                   borderRadius: BorderRadius.circular(50),
                   child: Image.file(
                     _localFile,
                     width: 300,
                     height: 300,
                     fit: BoxFit.fitHeight,
                   ),
                 ),
                 radius: 100,
                 backgroundColor: Colors.yellow,
               ),
             ),

           ),
           SizedBox(
             height: 40,
           ),
           FlatButton(onPressed: () {
             Navigator.push(context, new MaterialPageRoute(
                 builder: (ctext) => new LandingPage()));
             ;
           },
               child: Text('Finished'),
               color: Color.fromARGB(255, 0, 0, 254),
               textColor: Colors.yellow),
         ],
       ),
     );
   }


  imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
    final Directory d = await getApplicationDocumentsDirectory();
    final String path = d.path;


  }

  imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    getApplicationDocumentsDirectory().then((value) {
      String path = value.path;

         image.copy('$path/image1.png').then((v) {

        });


    });

    setState(() {
      _localFile = image;
    });

  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}