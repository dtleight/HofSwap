import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/LoginPage.dart';
import 'package:hofswap/Pages/SellersPage.dart';
import 'package:hofswap/Pages/SettingsPage.dart';
import 'package:hofswap/Pages/StorePage.dart';
import 'package:hofswap/Pages/WishListPage.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:provider/provider.dart';

import '../name_state.dart';
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
                                      radius: 60,
                                      backgroundImage: NetworkImage("https://www.hofstra.edu/images/academics/colleges/seas/computer-science/csc-sjeffr2.jpg",),
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
                    await FirebaseAuth.instance.signOut();
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
