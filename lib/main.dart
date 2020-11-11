import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hofswap/Containers/PageContainer.dart';
import 'package:hofswap/Picture_state.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/name_state.dart';
import 'package:hofswap/theme_state.dart';
import 'package:hofswap/Picture_state.dart';
import 'package:provider/provider.dart';
import 'Objects/Textbook.dart';
import 'Pages/LoginPage.dart';
import 'Pages/NewUserPage.dart';
import 'Singeltons/UserAccount.dart';
void main() async {
  //new UserAccount.instantiate("Dalton Leight", "dleight1@pride.hofstra.edu", 2, "70292000", new List<String>());

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeState()),
          ChangeNotifierProvider(create: (_) => NameState()),
          ChangeNotifierProvider(create: (_) => PictureState()),
        ],
        child: MyApp(),
      )
  );
  await Firebase.initializeApp();
  new DatabaseRouting().init();
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ThemeState provider = Provider.of<ThemeState>(context);
    return MaterialApp
      (
      themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'HofSwap',

        theme: ThemeData(
            primaryColor: Colors.indigoAccent,
            primaryColorBrightness: Brightness.light,
            brightness: Brightness.light,
            primaryColorDark: Colors.indigoAccent,
            canvasColor: Colors.white,
            textTheme: TextTheme(
              body1: TextStyle(color: Colors.black),
              body2: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
              caption: TextStyle(color: Colors.black),
              display1: TextStyle(color: Colors.black),
              display2: TextStyle(color: Colors.black),
              display3: TextStyle(color: Colors.black),
              display4: TextStyle(color: Colors.black),
              headline: TextStyle(color: Colors.black),
              subhead: TextStyle(color: Colors.black), // <-- that's the one
              title: TextStyle(color: Colors.black),
            ),
            // next line is important!
            appBarTheme: AppBarTheme(brightness: Brightness.light)),
        darkTheme: ThemeData(
            textTheme: TextTheme(
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white),
              button: TextStyle(color: Colors.white),
              caption: TextStyle(color: Colors.white),
              display1: TextStyle(color: Colors.white),
              display2: TextStyle(color: Colors.white),
              display3: TextStyle(color: Colors.white),
              display4: TextStyle(color: Colors.white),
              headline: TextStyle(color: Colors.white),
              subhead: TextStyle(color: Colors.white), // <-- that's the one
              title: TextStyle(color: Colors.white),
            ),
            primaryColor: Colors.black,
            primaryColorBrightness: Brightness.dark,
            primaryColorLight: Colors.white,
            brightness: Brightness.dark,
            primaryColorDark: Colors.black,
            indicatorColor: Colors.black,
            canvasColor: Colors.black,
            // next line is important!
            appBarTheme: AppBarTheme(brightness: Brightness.dark)),
      home: LoginPage(),
    );
  }
}