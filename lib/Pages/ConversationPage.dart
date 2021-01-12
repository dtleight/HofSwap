import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return ConversationPageState();
  }
}

class ConversationPageState extends State<ConversationPage>
{
  ConversationPageState() {}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
     backgroundColor: Colors.yellow,
     appBar: AppBar(title: Text("Person 1 and Person 2"),),
      body: ListView
        (
        children:
        [
          Bubble(
            alignment: Alignment.topLeft,
            margin: BubbleEdges.only(top: 10),
            nip: BubbleNip.leftTop,
            padding: BubbleEdges.all(20),
            child: Text('Person 1 Message!', style: TextStyle( fontWeight: FontWeight.w600),),
          ),
          Bubble(
            alignment: Alignment.topRight,
            margin: BubbleEdges.only(top: 10),
            nip: BubbleNip.rightTop,
            color: Color.fromRGBO(225, 255, 199, 1.0),
            padding: BubbleEdges.all(20),
            child: Text('Person 2 message!', textAlign: TextAlign.right,style: TextStyle( fontWeight: FontWeight.w600),),
          ),
        ],

      ),
    );
  }

}