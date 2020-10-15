import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import '../Objects/Account.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FocusedStoreView extends StatelessWidget
{
  Textbook tb;
  FocusedStoreView(Textbook textbook)
  {
    this.tb = textbook;
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        appBar: AppBar(title: Text(tb.title + " by " + tb.authors.toString()),),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10,10,0,0),
          child:
          Row(
            children:
            [
             Flexible(child: Column
               (
                children:
                [
                  Image(image: NetworkImage("http://covers.openlibrary.org/b/isbn/" + tb.ISBN +"-M.jpg"),),
                ],
               ),
             ),
             SizedBox(width: 10,),
             Flexible(child: Column
               (
               crossAxisAlignment: CrossAxisAlignment.start,
               children:
               [
                  Column
                   (
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   mainAxisSize: MainAxisSize.max,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>
                   [
                     Row(children: [Text("Title: "),Text( tb.title),]),
                     Row(children: [Text("Authors: "), Text(tb.authors[0]),]),
                     Row(children: [Text("Seller: "), Text("Dalton Leight"),]),
                     Row(children: [Text("Price: "), Text("99.99"),]),
                     Row(children: [Text("Condition: "), Text("Horrible"),]),
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Icon(Icons.star, color: Colors.green[500]),
                         Icon(Icons.star, color: Colors.green[500]),
                         Icon(Icons.star, color: Colors.green[500]),
                         Icon(Icons.star, color: Colors.black),
                         Icon(Icons.star, color: Colors.black),
                       ],
                     )
                   ],
                 ),
                 Flexible(child: Row(
                  children:
                    [
                      Container
                        (
                        height: 50,
                        width: 90,
                        child: FlatButton
                          (
                            child: Text("Add to Wishlist"),
                            onPressed: () {return addToWishlist();},
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width: 90,
                        child:FlatButton
                          (
                            child: Text("Contact Seller"),
                            color: Colors.blueAccent,
                            onPressed: () {return sendEmail();},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                  ]
                 ),
                 ),
               ],
             ),
             ),
            ],
            )
          ),
      );
  }

  void sendEmail() async
  {
    Account sender = new Account.instantiate("Dalton Leight", null, null, null, 0,"dleight1@pride.hofstra.edu");

    String username = "";
    String password = "";

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(sender.email) //recipent email
      ..subject = 'I am Interested in Your Textbook!' //subject of the email
      ..text = 'Hello ' + sender.name + "! \n I am interested in purchasing your copy of " + tb.title
          + ". Please let me know if it is still available! \nThank you."; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }

}
  void addToWishlist()
  {

  }
}