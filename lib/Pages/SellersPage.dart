import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellersPage extends StatefulWidget
{
  SellersPage() {}

  @override
  State<StatefulWidget> createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage>
{

  List<TextEditingController> textControllers = new List<TextEditingController>();
  @override
  void dispose() {
  // Clean up the controller when the widget is disposed.
    for(TextEditingController t in textControllers)
      {
        t.dispose();
      }
  super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
  return Scaffold
    (
    appBar: AppBar(title: Text("Seller's Interface"),),
    body: Column(
      children:
      [
      FlatButton(child: Text("Add a textbook"),onPressed: (){openTextbookInterface(context);},)
      ],
    )
  );
  }

  Future<dynamic> openTextbookInterface(BuildContext context)
  {
    final _formKey = GlobalKey<FormState>();
    return showDialog
      (
        context: context,
        builder: (context)
        {
          textControllers.addAll([new TextEditingController(),new TextEditingController(),new TextEditingController(),]);
        return AlertDialog
          (
            content: Form
              (
                child: Column
                (
                  children:
                  [
                    ...addField(0, "Enter Textbook Title"),
                    ...addField(1, "Enter ISBN Number"),
                    ...addField(2, "Price")
                  ],
                ),
              ),
          );
        }
      );
  }

  List<Widget> addField(int index,String text)
  {
    return
    [
      Text(text),
      Padding(padding: EdgeInsets.all(10),child: Container(height: 50.0, width: 159.0,child: TextField(decoration: new InputDecoration(labelText: "",labelStyle: TextStyle(color: Colors.black,),fillColor: Colors.white,focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0)),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0))), controller: textControllers[index]),),)
      ];
  }
}