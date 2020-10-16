import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/SellersPage.dart';
import 'package:hofswap/Pages/StorePage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Utilities/CardReader.dart';


class LandingPage extends StatefulWidget
{
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
{
  @override
  Widget build(BuildContext context) {
    /**
     *

    CardReader c = new CardReader();
    c.getCard();
     **/
    return Scaffold
      (
      appBar: AppBar(title: Text("Landing Page"),),
        drawer: Drawer
          (
            child: ListView(
              children:
              [
                Center(
                  child:UserAccountsDrawerHeader(
                    accountName: Align(child: Text("Test"),alignment: Alignment.centerLeft,),
                    accountEmail: Text("Test2"),

                    currentAccountPicture: GestureDetector
                      (
                      child: CircleAvatar
                        (
                        backgroundImage: NetworkImage("https://www.hofstra.edu/images/academics/colleges/seas/computer-science/csc-sjeffr2.jpg"),
                      ),
                    ),
                    decoration: BoxDecoration
                      (
                      color: Colors.lightBlueAccent,
                    ),
                  ),
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
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile
                  (
                  leading: Icon(Icons.power_settings_new),
                  title: Text('Sign Out'),
                ),
              ],
          ),
      ),
        backgroundColor: const Color(0xfff7e942),
        body: Align(alignment:Alignment.center, child:Image(image:AssetImage("assets/logo.jpg")))
    );
  }
}
