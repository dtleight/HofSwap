import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LoginPage.dart';
import 'package:hofswap/Pages/SellersPage.dart';
import 'package:hofswap/Pages/SettingsPage.dart';
import 'package:hofswap/Pages/StorePage.dart';
import 'package:hofswap/Pages/WishListPage.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';

import 'AccountPage.dart';


class LandingPage extends StatefulWidget
{
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar(title: Text("Landing Page"),),
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
                                      radius: 60,
                                      backgroundImage: NetworkImage("https://www.hofstra.edu/images/academics/colleges/seas/computer-science/csc-sjeffr2.jpg",),
                                    ),
                                  onTap: ()
                                  {
                                    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new AccountPage()));
                                    },
                                ),
                              Text(new UserAccount().name ?? "Scott Jeffreys")
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
                    title: Text('WishList'),
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
                    print("signout");
                    await FirebaseAuth.instance.signOut();
                    print("signed user out");
                    Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new LoginPage()));
                    //

                  },
                ),
              ],
          ),
      ),
        backgroundColor: const Color(0xfff7e942),
        body: Align(alignment:Alignment.center, child:Image(image:AssetImage("assets/logo.png")))
    );
  }
}
