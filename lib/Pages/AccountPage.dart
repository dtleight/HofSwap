import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Account.dart';

class AccountPage extends StatelessWidget
{
  Account account = new Account.instantiate("Dalton Leight", null,null,null, 5, "dleight1@pride.hofstra.edu");
  @override
  Widget build(BuildContext context)
  {
    //bottom: TabBar(tabs:[Tab(text: account.name,)],),
    return Scaffold
      (
      appBar: AppBar(title: Text("My Account"),),
      body: Column(children:
      [
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://www.hofstra.edu/images/academics/colleges/seas/computer-science/csc-sjeffr2.jpg"),
            radius: 100,
          ),
        ),
      ],),
    );
  }
}
