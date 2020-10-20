import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hofswap/Containers/PageContainer.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'Objects/Textbook.dart';
import 'Pages/LandingPage.dart';
import 'Pages/StorePage.dart';
import 'Singeltons/UserAccount.dart';
void main() async {
  new UserAccount.instantiate("Dalton Leight",null,null,null,4.2,"dleight1@pride.hofstra.ed","700000000",new List<Textbook>(),null);
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
      home: PageContainer(),
      //home: LoginPage(),
    );
  }
}