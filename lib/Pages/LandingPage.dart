import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget
{
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff7e942),
        body: Align(alignment:Alignment.center, child:Image(image:AssetImage("assets/logo.jpg")))
    );
  }
}
