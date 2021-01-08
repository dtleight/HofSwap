import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Widgets/HorizontalTextbookDisplay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../name_state.dart';
import 'AccountPage.dart';
import 'LoginPage.dart';
import 'SellersPage.dart';
import 'SettingsPage.dart';
import 'StorePage.dart';
import 'WishListPage.dart';

class NewHomePage extends StatefulWidget
{
  NewHomePage() {}

  @override
  State<StatefulWidget> createState()
  {
    return NewHomePageState();
  }
}

class NewHomePageState extends State<NewHomePage>
{
  NewHomePageState(){}

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
  Widget build(BuildContext context) {
    getImage();
    var name ="";
    NameState nameState = Provider.of<NameState>(context,listen:false);
    if(nameState.name == null){
      nameState.name = UserAccount().name;
    }name=nameState.name;
    return Scaffold
      (
        appBar: AppBar(title: Text("Home"),),
        drawer: Drawer
          (
          child: ListView
            (
            children:
            [
              DrawerHeader
                (
                child: Center
                  (
                  child: Column
                    (
                    children:
                    [
                      GestureDetector
                        (
                        child: CircleAvatar
                          (
                          backgroundImage: new FileImage(diskImage)??NetworkImage("https://media-exp1.licdn.com/dms/image/C4D03AQGBJvv4Aqpe0A/profile-displayphoto-shrink_400_400/0?e=1610582400&v=beta&t=3IJojANAk3Aqh_aTYH-lxMQemvvWkFb_4AyNvH7jC-o"),
                          radius: 60,
                        ),
                        onTap: ()
                        {
                          Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new AccountPage()));
                        },
                      ),
                      Text( name ?? "Scott Jeffreys")
                    ],
                  ),
                ),
              ),
              ListTile
                (
                  leading: Icon(Icons.account_circle),
                  title: Text('Account Page'),
                  onTap: ()
                  {
                    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new AccountPage()));
                  }
              ),
              ListTile
                (
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Store Page'),
                  onTap: ()
                  {
                    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new StorePage()));
                  }
              ),
              ListTile
                (
                  leading: Icon(Icons.attach_money),
                  title: Text('Seller\'s Interface'),
                  onTap: ()
                  {
                    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new SellersPage()));
                  }
              ),
              ListTile
                (
                  leading: Icon(Icons.beenhere),
                  title: Text('Wishlist'),
                  onTap: ()
                  {
                    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new WishListPage()));
                  }
              ),
              ListTile
                (
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: ()
                  {
                    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new SettingsPage()));
                  }
              ),
              ListTile
                (
                leading: Icon(Icons.power_settings_new),
                title: Text('Sign Out'),
                onTap: () async{
                  nameState.name = null;
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LoginPage()));
                  //

                },

              ),
            ],
          ),
        ),
        backgroundColor: Colors.yellow,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HorizontalTextbookDisplay(DatabaseRouting().textbooks.sublist(1,4),Text("Books",style: TextStyle(fontWeight: FontWeight.bold),)),
                HorizontalTextbookDisplay(DatabaseRouting().textbooks.sublist(2,9),Text("More Books",style: TextStyle(fontWeight: FontWeight.bold),)),
                HorizontalTextbookDisplay(DatabaseRouting().textbooks.sublist(3,7),Text("The Books",style: TextStyle(fontWeight: FontWeight.bold),)),
              ]
          ),
        ),
    );
  }
}

