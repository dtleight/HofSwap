import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Pages/MyBooksForSale.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Popouts/changePicturePage.dart';
import 'package:hofswap/name_state.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../Picture_state.dart';
import 'SettingsPage.dart';

class AccountPage extends StatefulWidget
{
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserAccount account = new UserAccount();

  var diskImage;

  getImage()async{
    imageCache.clear();
    if(diskImage == null){
      Directory directory  = await getApplicationDocumentsDirectory();

      String path = directory.path;
      setState(() {
        diskImage = File('$path/image.jpg');

      });
    }
        }

  @override
  Widget build(BuildContext context)
  {
    var name ="";
    NameState nameState = Provider.of<NameState>(context,listen:false);

    getImage();


    if(nameState.name == null){
      nameState.name = UserAccount().name;
    }

      name=nameState.name;


    print(new UserAccount().soldBooks);
    return Scaffold
      (
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text("My Account"),
        actions:
        [
          IconButton
            (
              icon: Icon(Icons.settings),
              onPressed:()
              {
                Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new SettingsPage()));
              }
              )
        ],
      ),
      body:  Column(
        children:
      [ SizedBox(height: 15,),
        Center(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (ctext) => new ChangePicturePage()));
            },
             child: CircleAvatar(backgroundImage: new FileImage(diskImage)??NetworkImage("https://media-exp1.licdn.com/dms/image/C4D03AQGBJvv4Aqpe0A/profile-displayphoto-shrink_400_400/0?e=1610582400&v=beta&t=3IJojANAk3Aqh_aTYH-lxMQemvvWkFb_4AyNvH7jC-o"),radius: 120,),
          ),
        ),
        SizedBox(height: 20,),
        Text('Press on the Icon to Upload a New Image', textAlign:TextAlign.center, style:TextStyle(color: Colors.black54)),
        SizedBox(height: 20,),
        Align(
            alignment: Alignment.center,
            child: Card
              (
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column
                  (

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>
                  [
                    Text("Name: "+name +"\n", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Text("email: "+ account.email+"\n"),
                    Text("Hofstra ID: H" + account.hofstraID+"\n\n"),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        color: Colors.indigoAccent,
                          onPressed:()
                          {
                            Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new MyBooksForSale()));
                          },
                        child: Text("My Selling Page" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),

                    ),),

                  ]
            ),
              )
        )
        ),
      ],
            ),
    );
  }
}
