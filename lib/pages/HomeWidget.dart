import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nice_travel/pages/AbsctractWidget.dart';
import 'package:nice_travel/ui/Backdrop.dart';
import 'package:nice_travel/pages/InfoUserWidget.dart';
import 'package:nice_travel/ui/MenuTitle.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;

  const Home({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const baseColors = ColorSwatch(0xFF6AB7A8, {
    'highlight': Color(0xFF6AB7A8),
    'splash': Color(0xFF0ABC9B),
  });

  WidgetPage currentPage;

  final pages = <WidgetPage>[];

  WidgetPage defaultCurrentPage = new WidgetPage(
      name: "Nice Travel",
      color: baseColors,
      iconLocation: Icons.home,
      frontPanel: new Text("TODO IMPLEMENTAR!"),
      frontTitle: new Text("Nice Travel"));

  @override
  void initState() {
    super.initState();
    pages.add(new WidgetPage(
        name: "User info",
        color: baseColors,
        iconLocation: Icons.supervised_user_circle,
        frontPanel: new InfoUser(user: widget.user),
        frontTitle: new Text("User info")));
    pages.add(defaultCurrentPage);
  }

  @override
  Widget build(BuildContext context) {
    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: buildListActions(MediaQuery.of(context).orientation),
    );
    return Backdrop(
      currentPage: currentPage == null ? defaultCurrentPage : currentPage,
      backPanel: listView,
      backTitle: Text('Selecione um item de menu'),
    );
  }

  Widget buildListActions(Orientation deviceOrientation) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var page = pages[index];
          return MenuTitle(
            page: page,
            onTap: onMenuItemTap,
          );
        },
        itemCount: pages.length);
  }

  /// Function to call when a [WidgetPage] is tapped.
  void onMenuItemTap(WidgetPage page) {
    setState(() {
      currentPage = page;
    });
  }
}
