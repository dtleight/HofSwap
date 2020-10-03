import 'package:flutter/material.dart';
import 'package:hofswap/Containers/PageContainer.dart';
import 'Pages/LandingPage.dart';
import 'Pages/StorePage.dart';
void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PageContainer(),
    );
  }
}