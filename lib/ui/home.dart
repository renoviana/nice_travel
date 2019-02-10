import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/signIn.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
    @required this.user
  }):super(key:key);

  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 signOut(){
   FirebaseAuth.instance.signOut().then((value){
     Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Nome:${widget.user.displayName}'),
            Text('Email:${widget.user.email}'),
            RaisedButton(onPressed: signOut)
          ],
        ),
      ),
    );
  }
}
