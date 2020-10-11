import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';

class FocusedStoreView extends StatelessWidget
{
  Textbook textbook;
  FocusedStoreView(Textbook textbook)
  {
    this.textbook = textbook;
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        appBar: AppBar(title: Text(textbook.title),),
      );
  }
}