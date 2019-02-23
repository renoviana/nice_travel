import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/signIn.dart';

class InfoUser extends StatefulWidget {
  final FirebaseUser user;

  const InfoUser({Key key, @required this.user}) : super(key: key);

  @override
  _InfoUserState createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: form(),
    );
  }


  signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
    });
  }

  Widget form() {
    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        child: infoUser()
      ),
    );
  }

  Widget infoUser(){
    return Column(
      children: <Widget>[
        Text('Nome:${widget.user.displayName}'),
        Text('Email:${widget.user.email}'),
        RaisedButton(child: Text("Logout"), onPressed: signOut)
      ],
    );
  }
}

