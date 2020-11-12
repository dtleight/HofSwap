import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Pages/FocusedStoreView.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';

class SearchPopout extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _SearchPopoutState();
  }

}
class _SearchPopoutState extends State<SearchPopout>
{

  List<TextEditingController> textControllers = new List<TextEditingController>();
  final _formKey = GlobalKey<FormState>();
  Widget widgy;
  _SearchPopoutState(){ textControllers.addAll([new TextEditingController(),new TextEditingController(),new TextEditingController()]);
  widgy = buildForm();}
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
      return AlertDialog(
        backgroundColor: Colors.yellow,
        content: Scaffold(
            backgroundColor: Colors.yellow,
            body: AnimatedSwitcher(
              child: widgy,
            duration: Duration(seconds: 1),),
        ),);
  }

  Widget buildForm()
  {
    return SingleChildScrollView(

      child: Column
        (
        mainAxisSize: MainAxisSize.min,
        children:
        [
          Form
            (
            key: _formKey,
            child: Column
              (
              children:
              [
                SizedBox(height: 20,),
                Text('Please Enter a Topic to Search By:', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40,),
                ...addField(0, "Textbook Title",(value){if(value =="" && textControllers[1].text == "" &&  textControllers[2].text == ""){return "Please Enter a Value";}return null;}),
                ...addField(1, "ISBN Number",(value){if(value =="" && textControllers[0].text == "" &&  textControllers[2].text == ""){return "Please Enter a Value";}return null;}),
                ...addField(2, "Author",(value){if(value =="" && textControllers[0].text == "" &&  textControllers[1].text == ""){return "Please Enter a Value";}return null;}),

                Align(
                  //alignment: Alignment.bottomCenter,

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
                        if(_formKey.currentState.validate())
                          widgy = constructSuggestions(textControllers[1].text,textControllers[0].text,textControllers[2].text);
                      });
                    },),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget constructSuggestions(String isbn,String title, String author)
  {
    return FutureBuilder(future: TextbookBuilder().queryTextbook(isbn, title, author),
      builder: (BuildContext context, AsyncSnapshot<List<Textbook>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
               return TextbookBuilder().buildTextbookCell(
                      snapshot.data[index], () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (ctxt) => new FocusedStoreView(
                            snapshot.data[index])));
                  }
                );
              });
        }
        return Scaffold();
      }
      );
  }
  List<Widget> addField(int index,String text, [Function validation])
  {
    return
      [
        Text(text, style: TextStyle(color: Colors.black)),
        Padding(padding: EdgeInsets.all(10),child: Container(height: 80.0, width: 250,child:
          TextFormField(style: TextStyle(color: Colors.black), decoration: new InputDecoration(labelText: "",labelStyle: TextStyle(color: Colors.black,),
            fillColor: Colors.white, filled: true, focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0)),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0))),
              controller: textControllers[index], validator: validation),),)
      ];
  }
}