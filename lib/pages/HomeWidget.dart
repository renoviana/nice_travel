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
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  List<Widget> _screens = [ListTrips(), ListTrips(), ListTrips()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Trips",
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider<ListController>(
          child: _screens[_currentIndex], bloc: ListController()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => BlocProvider(
                    bloc: ListController(),
                    child: AddCronograma(),
                  )));
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
