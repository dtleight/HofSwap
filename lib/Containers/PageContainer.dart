import 'package:flutter/cupertino.dart';
import 'package:hofswap/Pages/AccountPage.dart';
import 'package:hofswap/Pages/LandingPage.dart';
import 'package:hofswap/Pages/StorePage.dart';

class PageContainer extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageContainer> {
  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        AccountPage(),
        LandingPage(),
        StorePage(),
      ],
    );
  }
}