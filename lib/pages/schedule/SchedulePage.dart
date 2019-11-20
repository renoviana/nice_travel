import 'package:flutter/material.dart';
import 'package:nice_travel/pages/schedule/card/ScheduleCard.dart';
import 'package:nice_travel/pages/schedule/list/ScheduleList.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            ScheduleCard(),
            ScheduleList(),
          ],
        ),
      ),
    );
  }
}
