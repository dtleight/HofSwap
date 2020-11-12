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
    int len;
    //tb.sale_log ==null?len=0:len=tb.sale_log.values.length;
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
                   Expanded(
                     child: Column
                     (
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:
                     [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column
                             (
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             mainAxisSize: MainAxisSize.max,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>
                             [
                               Row(children: [Flexible(child: Text("Title: " + tb.title + "\n", overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold))),]),
                               Row(children: [Flexible(child: Text("ISBN: " + tb.ISBN + "\n", overflow: TextOverflow.ellipsis,maxLines: 1,)),]),
                               Row(children: [Flexible(child: Text("Authors: " + tb.getDisplayAuthors(tb.authors.length),overflow: TextOverflow.ellipsis,maxLines: 2)),]),
                               //Row(children: [Text("Seller: "), Text("Dalton Leight"),]),
                               //Row(children: [Text("Price: "), Text("99.99"),]),
                               //Row(children: [Text("Condition: "), Text("Horrible"),]),
                             ],
                       ),
                          ),
                        ),
                       Flexible(child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children:
                          [
                            Container
                              (
                              height: 50,
                              width: 90,
                              child: FlatButton
                                (
                                  child: Text("Add to Wishlist", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: "Textbook has been added to Wishlist",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black38,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    return addToWishlist();
                                    },
                                  color: Colors.indigoAccent,

                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                ),
                            ),
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
              Text("Purchase Options",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
              Flexible(flex: 2,
                child: ListView.builder(
                    itemCount: new DatabaseRouting().textbookse[tb.ISBN]==null?0:new DatabaseRouting().textbookse[tb.ISBN].sale_log.values.length,
                    itemBuilder: (BuildContext context, int i)
                    {
                      return buildSaleableTextbook(new DatabaseRouting().textbookse[tb.ISBN].sale_log.values.toList()[i], new DatabaseRouting().textbookse[tb.ISBN].sale_log.keys.toList()[i]);
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
    List<String> info = await new DatabaseRouting().getHofswapInformation();
    final smtpServer = gmail(info[0], info[1]);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(info[0])
      ..recipients.add(email) //recipent email
      ..subject = 'I am Interested in Your Textbook!' //subject of the email
      ..text = 'Hello!\n\nI am interested in purchasing your copy of ' + tb.title
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column
                      (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("Book Information: \n", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("     Price: \$" + sale_info['price'].toStringAsFixed(2)),
                        Text("     Condition: " + sale_info['condition']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 90,
                      child:FlatButton
                        (
                        child: Text("Contact Seller", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                        color: Colors.indigoAccent,
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
                  ),
                  ]
            )
        ),
    );
  }
}