import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hofswap/Picture_state.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Utilities/NotificationHandler.dart';
import 'package:hofswap/name_state.dart';
import 'package:hofswap/theme_state.dart';
import 'package:hofswap/Picture_state.dart';
import 'package:provider/provider.dart';
import 'Pages/LoginPage.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() async
{
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
  /**
   * Notification code
   */
  await Firebase.initializeApp();
  new DatabaseRouting().init();
  FirebaseMessaging messaging = FirebaseMessaging();
  String string = await messaging.getToken();
  ///Prints token to add to firebase messaging platform.
  print("Token is: " + string.toString());
  ///Configure provides handling for notification events
  messaging.configure(
      onMessage: (message) {print('Got a message whilst in the foreground!');print('Message data: ${message.toString()}');return;},
      //onBackgroundMessage: backgroundHandler
      );
  /**
   * End of Notification Instantiation
   */
}

Future<void> backgroundHandler(message) async
{
  await Firebase.initializeApp();
  print("Handling a background message: " + message.toString());
  return;
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