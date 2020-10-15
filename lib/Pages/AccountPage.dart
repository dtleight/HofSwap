import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Account.dart';

class AccountPage extends StatelessWidget
{
 Account account = new Account.instantiate("Scott Jefferys", null,null,null, 5, "scott.m.jefferys@hofstra.edu",);
  @override

  Widget build(BuildContext context)
  {
    //bottom: TabBar(tabs:[Tab(text: account.name,)],),
    return Scaffold
      (
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(title: Text("My Account"),backgroundColor: Colors.green,),
      body:  Column(children:
      [ SizedBox(height: 15,),
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://www.hofstra.edu/images/academics/colleges/seas/computer-science/csc-sjeffr2.jpg"),
            radius: 100,
          ),
        ),
        SizedBox(height: 20,),
        Align(alignment: Alignment.center,  child: Card(

            color: Colors.lightBlueAccent,
            borderOnForeground: false,
            elevation:  0,

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [

                  Text("Name: "+account.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text("Email: "+account.email),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Rating: "),


                      Icon(Icons.star, color: Colors.green[500]),
                      Icon(Icons.star, color: Colors.green[500]),
                      Icon(Icons.star, color: Colors.green[500]),
                      Icon(Icons.star, color: Colors.black),
                      Icon(Icons.star, color: Colors.black),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("View WishList " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                    ],
                  ),

                ]
            )
        ))
      ],),
    );
  }
}
