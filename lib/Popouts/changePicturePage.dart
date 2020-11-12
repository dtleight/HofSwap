import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

import '../Picture_state.dart';

class ChangePicturePage extends StatefulWidget {
  ChangePicturePage(){}

  @override
  _ChangePicturePageState createState() => _ChangePicturePageState();
}

class _ChangePicturePageState extends State<ChangePicturePage> {
  File memoryImage, diskImage;


  final  fileName = "image1.png";

  @override
  void initState() {
    super.initState();
    imageCache.clear();

    if(memoryImage == null)
    getApplicationDocumentsDirectory().then((directory){
      String path = directory.path;
      diskImage = File('$path/image.jpg');
      setState(() {
        memoryImage = diskImage;
      });

    });
  }

  @override
  Widget build(BuildContext context){


    return AlertDialog(
      backgroundColor: Colors.yellow,
        title: Text('Change Your Profile Picture', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          Text('Press on the Avatar \nto Select a New Image',
              textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
          SizedBox(height: 10,),
          Center(
            child: GestureDetector(
              onTap: () {
                _showyPicker(context);

              },
              child: CircleAvatar(backgroundImage: new FileImage(diskImage)??NetworkImage("https://media-exp1.licdn.com/dms/image/C4D03AQGBJvv4Aqpe0A/profile-displayphoto-shrink_400_400/0?e=1610582400&v=beta&t=3IJojANAk3Aqh_aTYH-lxMQemvvWkFb_4AyNvH7jC-o"),radius: 120,),
            ),

          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Your picture has been Changed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black38,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.push(
                    context,

                    new MaterialPageRoute(
                        builder: (ctext) => new LandingPage()));

              },
              child: Text('Upload'),
              color: Colors.indigoAccent,
              textColor: Colors.white),
        ],
      ),
    );
  }

  imgFromCamera() async {
    var pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage == null) return;
    memoryImage = File(pickedImage.path);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    //provider here
    PictureState().picture = memoryImage;
    setState(() {
      diskImage = memoryImage.copySync('$path/image.jpg');
      memoryImage = File(pickedImage.path);

    });
  }

  final picker = ImagePicker();

  Future imgFromGallery() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage == null) return;
    memoryImage = File(pickedImage.path);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    PictureState().picture = memoryImage;
    setState(() {
      diskImage = memoryImage.copySync('$path/image.jpg');
    memoryImage = File(pickedImage.path);

    });
  }

  void _showyPicker(context) {
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
        });
  }
}
