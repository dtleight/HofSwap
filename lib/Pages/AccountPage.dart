import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Pages/changePicturePage.dart';
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
          child: diskImage == null ? Container() : CircleAvatar(
            child: Image.file(diskImage),
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
                  Text("Name: "+name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
/**
                  SizedBox(height: 15,),
                  Text("View WishList " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 15,),
                  Text("View People You Follow " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 15,),
                  Text("View People Who Follow You " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    **/
                ]
            )
        )
        ),
        Flexible(flex: 1,
            child: ListView.builder
            (
            scrollDirection:Axis.horizontal,
            itemCount: new UserAccount().soldBooks.length,
            itemBuilder: (BuildContext context, int index) {
              Textbook tb = new DatabaseRouting().textbookse[new UserAccount().soldBooks[index]];
              return Container
                (
                height: 500,
                width: 200,
                child: GestureDetector(
                  child:  Card
                    (
                    child: Row(children: [
                      Flexible(flex:2,
                        child: FutureBuilder(
                          // Paste your image URL inside the htt.get method as a parameter
                          future: http.get(
                              "http://covers.openlibrary.org/b/isbn/" +tb.ISBN +"-M.jpg"),
                          builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text("No connection");
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              case ConnectionState.done:
                                if (snapshot.data.bodyBytes.toString().length <= 10000)
                                  return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png",fit: BoxFit.contain,);
                                // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
                                return Image.memory(snapshot.data.bodyBytes, fit: BoxFit.contain);
                            }
                            return null; // unreachable
                          },
                        ),
                      ),
                      Flexible(flex: 2,
                          child:Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Flexible(child: Text("ISBN: " + tb.ISBN),), Flexible(child: Text("Title: " + tb.title ))],)
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Do you want to delete this textbook?"),
                              FlatButton(
                                  onPressed: ()
                                  {
                                    new DatabaseRouting().deleteTextbook(new UserAccount().email, tb.ISBN,index);
                                    //Remove textbook from database
                                    Navigator.pop(context);
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
