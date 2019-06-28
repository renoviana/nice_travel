import 'package:flutter/material.dart';
import 'package:nice_travel/login/signIn.dart';
import 'package:nice_travel/pages/home/HomePage.dart';

import 'integration/ApiConnection.dart';
import 'model/Schedule.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getSchedules();
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
        home: HomePage());
  }

  //TODO REMOVER ESSE MÉTODO, ELE É TEMPORARIO APENAS PARA VALIDAR.
  Future getSchedules() async {
    var apiConnection = new ApiConnection();
    List<Schedule> schedules =
        await apiConnection.getScheduleByCityName("Salvador", 1);
    print(schedules.first.nameCity);
  }
}
