import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hofswap/Containers/PageContainer.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'Objects/Textbook.dart';
import 'Pages/LoginPage.dart';
import 'Singeltons/UserAccount.dart';
void main() async {
  new UserAccount.instantiate("Dalton Leight", "dleight1@pride.hofstra.edu", 2.5, "70292000", new List<Textbook>());
  runApp(MyApp());
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
      //home: PageContainer(),
      home: LoginPage(),
    );
  }
}