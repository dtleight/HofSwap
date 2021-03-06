import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Pages/SellersPage.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';

class SellersPopout extends StatefulWidget
{
  Textbook textbook;
  SellersPopout(Textbook textbook)
  {
    this.textbook = textbook;
  }

  @override
  State<StatefulWidget> createState() => _SellersPopoutState(textbook);

}

class _SellersPopoutState extends State<SellersPopout>
{
  String placeholderValue = "Good";
  final _formKey = GlobalKey<FormState>();
  Textbook textbook;
  TextEditingController textEditingController = new TextEditingController();
  _SellersPopoutState(Textbook textbook)
  {
    this.textbook = textbook;
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
         return Form
            (
            key: _formKey,
            child: Column
              (
              mainAxisSize: MainAxisSize.min,
              children:
              [
                Text('Please Choose a Condition and Enter a Price:', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {return buildDropDownList();},),
                ...addField(4, "Asking Price",(value) {if(double.tryParse(value) != null && double.tryParse(value)>0.00){return null;}else{return "Invalid Price";}},),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton
                    (
                    color: Colors.indigoAccent,
                    child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white)
                    ),
                    onPressed: ()
                    {
                      setState(() {
                        //Confirm page
                        if (_formKey.currentState.validate()) {
                          textbook.generateNewSeller(textbook, placeholderValue, textEditingController.text);
                          new DatabaseRouting().addTextbook(textbook, placeholderValue, double.parse(textEditingController.text));

                          Navigator.pop(context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Textbook added to the Store",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black38,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        //Add textbook to database
                        //Send a toast to let the user know the book was added.
                        //Send back to home page
                      });
                    },),)
              ],
            ),
          );
        },
      ),
    );
  }
  Widget buildDropDownList()
  {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40, width: 100,
        decoration: new BoxDecoration(color: Colors.white, border: Border.all(width: .7, color: Colors.black),
            borderRadius: new BorderRadius.all(Radius.circular(10.0),)),
        child: Align(
          alignment: Alignment.center,
          child: DropdownButton<String>(
              iconEnabledColor: Colors.grey,
              iconDisabledColor: Colors.grey,
                dropdownColor: Colors.white,
                  value: placeholderValue,
                  items: [generateDropDownItem("Mint"),generateDropDownItem("Great"),generateDropDownItem("Good"),generateDropDownItem("Okay"),generateDropDownItem("Bad"),],
                  onChanged: (String newValue) {setState(() {
                    placeholderValue = newValue;
                  });}),
        ),
      ),
    );
  }

  DropdownMenuItem<String> generateDropDownItem(String text)
  {
    return DropdownMenuItem
      (
      child: Text(text, style: TextStyle(color: Colors.black)),
      value: text,

    );
  }
  List<Widget> addField(int index,String text, [Function validation])
  {
    return
      [
        Text(text, style: TextStyle(color: Colors.black)),
        Padding(padding: EdgeInsets.all(10),child: Container(height: 80.0, width: 250,
          child: TextFormField(style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(labelText: "",labelStyle: TextStyle(color: Colors.black,),
                  fillColor: Colors.white, filled: true, focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0))),
                    controller: textEditingController, validator: validation),),)
      ];
  }
}