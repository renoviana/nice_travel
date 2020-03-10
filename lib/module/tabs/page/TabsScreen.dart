import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nice_travel/module/schedule/page/SchedulePage.dart';
import 'package:nice_travel/module/travel/page/TravelPage.dart';

import '../tabs_controller.dart';
import '../widget/CustomDrawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  TabsScreenState createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  final _tabsController = Modular.get<TabsController>();

  var _scaffoldViagemKey = new GlobalKey<ScaffoldState>();
  var _scaffoldCronogramaKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _tabsController,
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
      drawer: CustomDrawer(),
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
      drawer: CustomDrawer(),
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
