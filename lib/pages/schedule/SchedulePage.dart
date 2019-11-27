import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';

import 'NewSchedulePage.dart';
import 'list/MyScheduleList.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScheduleList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendNewSchedulePage(),
        child: Icon(Icons.save),
        backgroundColor: Colors.blue,
      ),
    );
  }

  sendNewSchedulePage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewSchedulePage(Schedule.newInstance())));
  }
}
