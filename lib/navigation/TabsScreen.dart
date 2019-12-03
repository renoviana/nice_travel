import 'package:flutter/material.dart';
import 'package:nice_travel/pages/schedule/SchedulePage.dart';
import 'package:nice_travel/pages/travel/TravelPage.dart';

import 'CustomDrawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  TabsScreenState createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  final _pageController = PageController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        buildViagem(),
        buildCronograma(),
      ],
    );
  }

  Scaffold buildViagem() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Nice Travel"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.map),
          )
        ],
      ),
      body: TravelPage(),
      drawer: CustomDrawer(_pageController),
    );
  }

  Scaffold buildCronograma() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Nice Travel"),
      ),
      body: SchedulePage(),
      drawer: CustomDrawer(_pageController),
    );
  }

}
