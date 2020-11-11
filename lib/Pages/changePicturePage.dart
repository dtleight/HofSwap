import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class ChangePicturePage extends StatefulWidget {
  ChangePicturePage();

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


    return Scaffold(
      appBar: AppBar(
        title: Text('Change Your Profile Picture'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showyPicker(context);
              },
              child: CircleAvatar(
                child: memoryImage == null
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          memoryImage,
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
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
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
    var pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage == null) return;
    memoryImage = File(pickedImage.path);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

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
