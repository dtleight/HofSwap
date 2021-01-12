import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/ConversationPage.dart';

class ChatPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
   return ChatPageState();
  }

}

class ChatPageState extends State<ChatPage>
{
  ChatPageState(){}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(title: Text("Chat"),),
      backgroundColor: Colors.yellow,
      body: ListView(
        children: [
          ListTile
            (
            onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new ConversationPage()));},
            leading: Icon(Icons.person),
            title: Text("Person Name"),
          ),
        ],
      ),
    );
  }

}