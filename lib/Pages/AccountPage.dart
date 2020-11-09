import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Pages/changePicturePage.dart';

import 'SettingsPage.dart';

class AccountPage extends StatelessWidget
{
  UserAccount account = new UserAccount();
  @override
  Widget build(BuildContext context)
  {
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
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://www.hofstra.edu/images/academics/colleges/seas/computer-science/csc-sjeffr2.jpg"),
            radius: 100,

          ),),
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
        )
        ),
        Flexible(flex: 2,
            child: ListView.builder
            (
            scrollDirection:Axis.horizontal,
            itemCount: new UserAccount().soldBooks.length,
            itemBuilder: (BuildContext context, int index) {
              Textbook tb = new DatabaseRouting().textbookse[new UserAccount().soldBooks[index]];
              return Container
                (
                height: 400,
                width: 200,
                child: GestureDetector(
                  child:  Card
                    (
                    child: Row(children: [
                      Flexible(
                        child: Image(
                          image:NetworkImage("https://images-na.ssl-images-amazon.com/images/I/41j96R1fUfL._SX352_BO1,204,203,200_.jpg"),
                        ),
                      ),
                      Flexible(flex: 2,
                          child:Column(children: [Flexible(child: Text("ISBN: " + tb.ISBN),), Flexible(child: Text("Title: " + tb.title ))],)
                      )
                    ],
                    ),
                  ),
                  onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            children: [
                              Text("Do you want to delete this textbook?"),
                              FlatButton(
                                  onPressed: ()
                                  {
                                    //Remove textbook from database
                                  },
                                  child: Text("Confirm")
                              )
                            ],
                          ),
                        );
                      }
                  );
                },
                ),
              );
            }
            ),
            ),
      ],
            ),
    );
  }
}
