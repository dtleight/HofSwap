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
      body: Stack(
        children: <Widget>[
          Container(),
          Container(),
          Transform.translate(
            offset: Offset(0.0, 814.0),
            child: Image(image:AssetImage("assets/logo.jpg")),
          ),
          Transform.translate(
            offset: Offset(-64.0, 200.0),
            child:
            Container(
              width: 540.0,
              height: 405.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(57.0),
                image: DecorationImage(
                  image:  AssetImage('assets/logo.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 814.0),
            child: Image(image:AssetImage("assets/logo.jpg")),
          ),
          Container(),
        ],
      ),
    );
  }
}
