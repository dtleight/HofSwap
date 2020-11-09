import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Singeltons/UserAccount.dart';
import '../Objects/Account.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

class FocusedStoreView extends StatelessWidget
{
  Textbook tb;
  bool isSuccessful = false;
  FocusedStoreView(Textbook textbook)
  {
    this.tb = textbook;
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text(tb.title + " by " + tb.authors[0].toString()),),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10,10,0,0),
          child:
          Column(
            children: [
              Flexible(flex: 1,
                child: Row(
                  children:
                  [
                   Flexible(child: Column
                     (
                      children:
                      [
                        FutureBuilder(
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
                      ],
                     ),
                     flex: 4,
                   ),
                   //Flexible(child: SizedBox(),flex: 8,),
                    Flexible(child: FractionallySizedBox(widthFactor: 0.6,heightFactor: 1.0,),),
                   Flexible(
                     child: Column
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
                           Row(children: [Text("Title: ", style: TextStyle(color : Colors.black),),Text( tb.title, style: TextStyle(color: Colors.black),),]),
                           Row(children: [Text("Authors: ", style: TextStyle(color : Colors.black)), Text(tb.authors[0], style: TextStyle(color: Colors.black),),]),
                           //Row(children: [Text("Seller: "), Text("Dalton Leight"),]),
                           //Row(children: [Text("Price: "), Text("99.99"),]),
                           //Row(children: [Text("Condition: "), Text("Horrible"),]),
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
                        ]
                       ),
                       ),
                     ],
                   ),
                     flex: 8,
                   ),
                  ],
                  ),
              ),
              Text("Purchase Options",style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),),
              Flexible(flex: 2,
                child: ListView.builder(
                    itemCount: tb.sale_log.values.length,
                    itemBuilder: (BuildContext context, int i)
                    {
                      return buildSaleableTextbook(tb.sale_log.values.toList()[i], tb.sale_log.keys.toList()[i]);
                    }
                ),
              )
            ],
          )
          ),
      );
  }

  Future<String> sendEmail(String email) async
  {
    Account seller = new Account.instantiate("Dalton Leight","dleight1@pride.hofstra.edu",0);
    List<String> info = await new DatabaseRouting().getHofswapInformation();
    final smtpServer = gmail(info[0], info[1]);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(info[0])
      ..recipients.add(email) //recipent email
      ..subject = 'I am Interested in Your Textbook!' //subject of the email
      ..text = 'Hello ' + seller.name + "! \n\nI am interested in purchasing your copy of " + tb.title
          + ". Please let me know if it is still available by emailing me at " + new UserAccount().email +"! \n\nThank you,\n"+ new UserAccount().name; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
      return "Message sent sucessfully";
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      return e.toString();
      // e.toString() will show why the email is not sending
    }

}

  ///
  /// Add/Remove a textbook from the list, call updateState() to change button text/color
  ///
  void addToWishlist()
  {
      new UserAccount().wishlist.add(tb.ISBN);
      //Update database
      new DatabaseRouting().updateWishlist();
  }

  Widget buildSaleableTextbook(Map<String, dynamic> sale_info, String email)
  {
    return Container(height: 100.0, width: 500.0,
        child: Card
          (
            child:Row
              (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Column
                    (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text("Book Information",),
                      Text("Price: \$" + sale_info['price'].toString()),
                      Text("Condition: " + sale_info['condition']),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 90,
                    child:FlatButton
                      (
                      child: Text("Contact Seller"),
                      color: Colors.blueAccent,
                   onPressed: () async
                      {
                        String str = await sendEmail(email);
                          Fluttertoast.showToast(
                              msg: "Email sent",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black38,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  ]
            )
        ),
    );
  }
}