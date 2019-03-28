import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import 'package:nice_travel/pages/ListTrips.dart';
import 'package:nice_travel/controller/listController.dart';
import 'package:nice_travel/pages/addCronograma.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;

  const Home({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

const kGoogleApiKey = "AIzaSyC9b4oUjYYnSj5jLqdUidl4Wdy1cEskoJI";

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget current = ListTrips();
    return Scaffold(
      body:
          BlocProvider<ListController>(child: current, bloc: ListController()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddCronograma()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.star), title: Text('Favoritos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Cronogramas')),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Info'),
          ),
        ],
      ),
    );
  }
}
