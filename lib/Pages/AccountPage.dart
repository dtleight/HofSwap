import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Account.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';

import 'SettingsPage.dart';

class AccountPage extends StatelessWidget
{
  UserAccount account = new UserAccount();
  @override
  Widget build(BuildContext context)
  {
    //bottom: TabBar(tabs:[Tab(text: account.name,)],),
    return Scaffold
      (
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
      body:  Column(children:
      [ SizedBox(height: 15,),
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://www.hofstra.edu/images/academics/colleges/seas/computer-science/csc-sjeffr2.jpg"),
            radius: 100,
          ),
        ),
        SizedBox(height: 20,),
        Align(
            alignment: Alignment.center,
            child: Card
              (
              borderOnForeground: false,
              elevation:  0,
              child: Column
                (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Text("Name: "+ account.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text("Email: "+ account.email),
                  Text("Hofstra ID: H" + account.hofstraID),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:
                    [
                      Text("Rating: "),
                      Icon(Icons.star, color: (account.rating >= 1)?Colors.green[500]:Colors.black),
                      Icon(Icons.star,color: (account.rating >= 2)?Colors.green[500]:Colors.black),
                      Icon(Icons.star, color: (account.rating >= 3)?Colors.green[500]:Colors.black),
                      Icon(Icons.star, color: (account.rating >= 4)?Colors.green[500]:Colors.black),
                      Icon(Icons.star, color: (account.rating >= 5)?Colors.green[500]:Colors.black),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("My Selling Page " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 15,),
                  Text("View WishList " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 15,),
                  Text("View People You Follow " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 15,),
                  Text("View People Who Follow You " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ]
            )
        ))
      ],),
    );
  }
}
