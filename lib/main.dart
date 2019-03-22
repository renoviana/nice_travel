import 'package:flutter/material.dart';
import 'package:nice_travel/auth/authController.dart';
import './auth/signIn.dart';

import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nice Travel',
        theme: ThemeData(
          fontFamily: 'Raleway',
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.blue[600],
              ),
          // This colors the [InputOutlineBorder] when it is selected
          primaryColor: Colors.blue[500],
          textSelectionHandleColor: Colors.green[500],
        ),
        home: BlocProvider<AuthController>(
            child: SignIn(), bloc: AuthController()));
  }
}
