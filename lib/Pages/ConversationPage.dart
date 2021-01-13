import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';

class ConversationPage extends StatefulWidget
{
  DocumentSnapshot conversation;
  String person;
  ConversationPage(DocumentSnapshot conversation,String person)
  {
    this.conversation = conversation;
    this.person = person;
  }
  @override
  State<StatefulWidget> createState()
  {
    return ConversationPageState(conversation,person);
  }
}

class ConversationPageState extends State<ConversationPage>
{
  DocumentSnapshot conversation;
  String person;
  ConversationPageState(DocumentSnapshot conversation,String person) {this.conversation = conversation;this.person = person;}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
     backgroundColor: Colors.yellow,
     appBar: AppBar(title: Text(person),),
      body: ListView.builder(
        itemCount: conversation['messages'].length,
        itemBuilder: (BuildContext context, int index)
        {
          print(conversation['messages'][index]['sender'].toString());
          return  Bubble(
            alignment: conversation['messages'][index]['sender'].toString()== UserAccount().name?Alignment.topLeft:Alignment.topRight,
            margin: BubbleEdges.only(top: 10),
            nip: conversation['messages'][index]['sender'].toString()== UserAccount().name?BubbleNip.leftTop:BubbleNip.rightTop,
            padding: BubbleEdges.all(20),
            color: conversation['messages'][index]['sender'].toString()== UserAccount().name?Colors.white:Colors.green,
            child: Text(conversation['messages'][index]['message_text'], style: TextStyle( fontWeight: FontWeight.w600),),
          );
        },
      ),
    );
  }

}