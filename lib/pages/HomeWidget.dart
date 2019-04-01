import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:nice_travel/controller/listController.dart';
import 'package:nice_travel/pages/addCronograma.dart';
import 'package:nice_travel/ui/trip/ListTrips.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;

  const Home({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget map;
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;
  bool onmap = false;

  Icon switchMapIcon() {
    if (onmap) {
      return Icon(
        Icons.list,
        color: Colors.blueGrey,
      );
    }
    return Icon(
      Icons.map,
      color: Colors.blueGrey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ListController bloc = BlocProvider.of<ListController>(context);
    map = MapsWidget(bloc);
    List<Widget> _screens = [ListTrips(bloc), ListTrips(bloc), map];
    return Scaffold(
      appBar: AppBar(
        title: Text("My Trips",
            style: TextStyle(
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
            icon: switchMapIcon(),
            onPressed: () {
              setState(() {
                onmap = !onmap;

                if (onmap)
                  _currentIndex = 2;
                else
                  _currentIndex = 1;
              });
            },
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddCronograma(bloc)));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        currentIndex: _currentIndex,
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
