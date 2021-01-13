import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Pages/ConversationPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';

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
      body: FutureBuilder
        (
        future: DatabaseRouting().getConversations(UserAccount().conversationIDS),
        builder: (BuildContext context, AsyncSnapshot<dynamic> data)
        {
         return ListView.builder
           (
            itemCount: data.data.length,
             itemBuilder: (BuildContext context, int i)
             {
               DocumentSnapshot conversation = data.data[i];
               print(conversation.data().toString());
               List<dynamic> chatParticipants = conversation.data()['participants'];
               chatParticipants.remove(UserAccount().name);
               return ListTile
               (
                 onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new ConversationPage(conversation,chatParticipants[0].toString())));},
                 leading: Icon(Icons.person),
                 title: Text(chatParticipants[0].toString()),
               );
             }
         );
        },
      )
    );
  }

}