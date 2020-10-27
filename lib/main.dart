import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hofswap/Containers/PageContainer.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'Objects/Textbook.dart';
import 'Pages/LoginPage.dart';
import 'Pages/NewUserPage.dart';
import 'Singeltons/UserAccount.dart';
void main() async {
  //new UserAccount.instantiate("Dalton Leight", "dleight1@pride.hofstra.edu", 2, "70292000", new List<String>());

  runApp(MyApp());
  await Firebase.initializeApp();
  await new DatabaseRouting().init();


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp
      (
      debugShowCheckedModeBanner: false,
      title: 'HofSwap',
      theme: ThemeData
        (
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 0, 0, 254)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
      home: LoginPage(),
    );
  }
}