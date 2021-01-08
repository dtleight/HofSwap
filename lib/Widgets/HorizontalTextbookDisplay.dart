import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';

class HorizontalTextbookDisplay extends StatelessWidget
{
  List<Textbook> textbooks;
  Widget leadingWidget;
  HorizontalTextbookDisplay(List<Textbook> textbooks,[Widget leadingWidget])
  {
    this.textbooks = textbooks;
    this.leadingWidget = leadingWidget;
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leadingWidget??Container(),
        Container(
          height: 150,
           width:1000,
           color: Colors.white,
           child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: textbooks.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int j) {
                //return SizedBox(height: 50,width: 50,child: TextbookBuilder().getTextbookImage(textbooks[j].ISBN),);
                print(textbooks[j].ISBN);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 10,width: 100,child: Image.network("http://covers.openlibrary.org/b/isbn/" + textbooks[j].ISBN +"-M.jpg",fit: BoxFit.fill,)),
                );
                return TextbookBuilder().getTextbookImage(textbooks[j].ISBN);
              },
            ),
        ),
      ],
    );
  }

}