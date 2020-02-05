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
  var _scaffoldViagemKey = new GlobalKey<ScaffoldState>();
  var _scaffoldCronogramaKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        buildViagem(context),
        buildCronograma(context),
      ],
    );
  }

  Scaffold buildViagem(BuildContext context) {
    return Scaffold(
      key: _scaffoldViagemKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: _buildMenuLeadingButton(context),
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

  void _handleDrawerButton(BuildContext context) => _scaffoldViagemKey.currentState != null
      ? _scaffoldViagemKey.currentState?.openDrawer()
      : _scaffoldCronogramaKey.currentState?.openDrawer();

  Scaffold buildCronograma(BuildContext context) {
    return Scaffold(
      key: _scaffoldCronogramaKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: _buildMenuLeadingButton(context),
        title: Text("Nice Travel"),
      ),
      body: SchedulePage(),
      drawer: CustomDrawer(_pageController),
    );
  }

  IconButton _buildMenuLeadingButton(BuildContext context) {
    return IconButton(
        key: Key("menu_button"),
        icon: const Icon(Icons.menu),
        onPressed: () => _handleDrawerButton(context),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
  }

}
