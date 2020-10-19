import 'package:flutter/material.dart';
import 'package:hofswap/Containers/PageContainer.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'Pages/LandingPage.dart';
import 'Pages/StorePage.dart';
import 'Singeltons/UserAccount.dart';
void main() async {
  new UserAccount.instantiate("Dalton Leight",null,null,null,5,"dleight1@pride.hofstra.ed","700000000",null,null);
  runApp(MyApp());
  await new DatabaseRouting().init();


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        //backgroundColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
      home: PageContainer(),
      //home: LoginPage(),
    );
  }
}