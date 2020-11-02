import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';

class SellersPage extends StatefulWidget
{
  SellersPage() {}

  @override
  State<StatefulWidget> createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage>
{

  _SellersPageState()
  {

    textControllers.addAll([new TextEditingController(),new TextEditingController(),new TextEditingController(),new TextEditingController(),new TextEditingController(),]);
    widgy = constructForm();
  }
  List<TextEditingController> textControllers = new List<TextEditingController>();
  Widget widgy;
  @override
  void dispose() {
  // Clean up the controller when the widget is disposed.
    for(TextEditingController t in textControllers)
      {
        t.dispose();
      }
  super.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
  return Scaffold
    (
    appBar: AppBar(title: Text("Seller's Interface"),),

    body: AnimatedSwitcher
      (
      child: widgy,
      duration: Duration(seconds: 1),
    ),
  );
  }

  Widget constructForm()
  {
    return Column
      (
      children:
      [
        //FlatButton(child: Text("Add a textbook"),onPressed: (){openTextbookInterface(context);},)
        Form
          (
          child: Column
            (
            children:
            [
              ...addField(0, "Textbook Title"),
              ...addField(1, "ISBN Number"),
              ...addField(2, "Edition"),
              ...addField(3, "Condition"),
              ...addField(4, "Price"),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton
                  (
                  child: Text("Submit"),
                  onPressed: ()
                  {
                    setState(() {
                      print("test");
                      widgy = constructSuggestions(textControllers[1].text,textControllers[2].text,textControllers[2].text);
                    });
                    // buildTextbookSuggestions(context,textControllers[1].text, textControllers[0].text);
                    //new DatabaseRouting().addTextbook(new Textbook(textControllers[0].text,['Temporary Author'],int.parse(textControllers[2].text.toString()),textControllers[1].text,textControllers[3].text));
                  },),)
            ],
          ),
        ),
      ],
    );
  }


  Widget constructSuggestions(String isbn,String title, String author)
  {
    return FutureBuilder(future: TextbookBuilder().queryTextbook(isbn, title, author),
      builder: (BuildContext context, AsyncSnapshot<List<Textbook>> snapshot)
      {
        print(snapshot.data.toString());
        if (snapshot.hasData) {
          return ListView.builder(itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              print("Build Textbook Cell call");
              return TextbookBuilder().buildTextbookCell(
                  snapshot.data[index], () {
                print(snapshot.data[index].title);
              });
            },
          );
        }
        return Scaffold();
      },
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

  Future<Widget> buildTextbookSuggestions(BuildContext context, String isbn, String title, String author) async
  {
    List<Textbook> queriedTextbooks = await TextbookBuilder().queryTextbook(
        isbn, title,author);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog
            (
              title: AppBar(title: Text("Select your Textbook"),),
              titlePadding: EdgeInsets.all(0),
              scrollable: true,
              content: Container(
                height: 3000,
                width: 3000,
                child: ListView.builder(itemCount: queriedTextbooks.length,
                  itemBuilder: (context, index) {
                    return TextbookBuilder().buildTextbookCell(
                        queriedTextbooks[index], () {
                     print("textbook");
                    });
                  },
                ),
              )
          );
        }
    );
  }
}

