import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/pages/favorite/FavoritePage.dart';
import 'package:nice_travel/pages/schedule/SchedulePage.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Row(children: [
            Icon(Icons.menu),
            SizedBox(
              width: 20,
            ),
            Text("Nice Travel"),
          ]),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(icon: Icon(Icons.star)),
            ],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.map),
            )
          ],
        ),
        body: TabBarView(children: [
          SchedulePage(),
          FavoritePage(),
        ]),
      ),
    );
  }
}
