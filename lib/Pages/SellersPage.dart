import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Popouts/SellersPopout.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';
import 'package:http/http.dart' as http;

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

    textControllers.addAll([new TextEditingController(),new TextEditingController(),new TextEditingController()]);
    widgy = constructForm();
  }
  List<TextEditingController> textControllers = new List<TextEditingController>();
  Widget widgy;
  String placeholderValue = "Good";

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
    backgroundColor: Colors.yellow,
    body: Column(
      children: [
        Flexible( flex: 1,
          child: AnimatedSwitcher
              (
              child: widgy,
              duration: Duration(seconds: 1),
            ),
        ),
      ],
    ),
  );
  }

  Widget constructForm()
  {
    return SingleChildScrollView(
<<<<<<< HEAD
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please Enter the Following Information:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),

                ...addField(context, 0, "Textbook Title", (value) {
                  if (value == "" &&
                      textControllers[1].text == "" &&
                      textControllers[2].text == "") {
                    return "One field needs a value";
                  }
                  return null;
                }, ),
                ...addField(context, 1, "ISBN Number", (value) {
                  if (value == "" &&
                      textControllers[0].text == "" &&
                      textControllers[2].text == "") {
                    return "One field needs a value";
                  }
                  return null;
                }),
                ...addField(context, 2, "Author", (value) {
                  if (value == "" &&
                      textControllers[0].text == "" &&
                      textControllers[1].text == "") {
                    return "One field needs a value";
                  }
                  return null;
                }),
                Align(
                  //alignment: Alignment.bottomCenter,

                  child: FlatButton(
                    color: Colors.indigoAccent,
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate())
                          widgy = constructSuggestions(textControllers[1].text,
                              textControllers[0].text, textControllers[2].text);
                      });
                    },
                  ),
                ),
              ],
=======
      child: Column
        (
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
                      Text('Please Enter the Following Information:', textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 40,),
                  ...addField(0, "Textbook Title",(value){if(value =="" && textControllers[1].text == "" &&  textControllers[2].text == ""){return "One field needs a value";}return null;}),
                  ...addField(1, "ISBN Number",(value){if(value =="" && textControllers[0].text == "" &&  textControllers[2].text == ""){return "One field needs a value";}return null;}),
                  ...addField(2, "Author",(value){if(value =="" && textControllers[0].text == "" &&  textControllers[1].text == ""){return "One field needs a value";}return null;}),

                  Align(
                    //alignment: Alignment.bottomCenter,

                    child: FlatButton
                      (
                      color: Color.fromARGB(255, 0, 0, 254),
                      child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.yellowAccent)
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
>>>>>>> parent of 5fb25e1... Change picture every in the app
            ),
        ],
      ),
    );
  }
  Widget confirmBook(Textbook tb)
  {
    return Center(
      child: Column
        (
        children:
        [
          Text(tb.title,textScaleFactor: 2,),
          Expanded(child: FutureBuilder(
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
          ),flex:3),
          Text(tb.authors.toString().substring(1,tb.authors.toString().length-1)),
          Text(tb.ISBN),
          Align(
            alignment: Alignment.bottomCenter,
<<<<<<< HEAD
            child: FlatButton(
              color: Colors.indigoAccent,
              child:
                  Text("Confirm", style: TextStyle(color: Colors.white)),
              onPressed: () {
=======
            child: FlatButton
              (
              color: Color.fromARGB(255, 0, 0, 254),
              child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.yellowAccent)
              ),
              onPressed: ()
              {
>>>>>>> parent of 5fb25e1... Change picture every in the app
                setState(() {
                  //Confirm page
                  showDialog(
                      context: context,
                      builder: (BuildContext context)
                      {
                        return SellersPopout(tb);
                      }
                  );
                });
              },),)
        ],
      ),
    );
  }

  Widget constructSuggestions(String isbn,String title, String author)
  {
    return FutureBuilder(future: TextbookBuilder().queryTextbook(isbn, title, author),
      builder: (BuildContext context, AsyncSnapshot<List<Textbook>> snapshot)
      {
        if (snapshot.hasData) {
          return ListView.builder(itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return TextbookBuilder().buildTextbookCell(
                  snapshot.data[index], () { setState(() {
                widgy = confirmBook(snapshot.data[index]);
                  });
              });
            },
          );
        }
        return Scaffold();
      },
    );
  }


<<<<<<< HEAD
    Color bgColor = provider.isDark ? Colors.black : Colors.white;

    return [
      Text(text, style: TextStyle( fontSize: 15)),
      Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 80.0,
          width: 250,
          child: TextFormField(style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(
                  labelText: "",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: bgColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0))),
              controller: textControllers[index],
              validator: validation),
        ),
      )
    ];
=======
  List<Widget> addField(int index,String text, [Function validation])
  {
    return
    [
      Text(text, style: TextStyle(color: Colors.black, fontSize: 15)),
      Padding(padding: EdgeInsets.all(10),child: Container(height: 80.0, width: 250,child: TextFormField(decoration: new InputDecoration(labelText: "",labelStyle: TextStyle(color: Colors.black,),fillColor: Colors.white, filled: true, focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0)),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0))), controller: textControllers[index], validator: validation),),)
      ];
>>>>>>> parent of 5fb25e1... Change picture every in the app
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
                    });
                  },
                ),
              )
          );
        }
    );
  }
}

