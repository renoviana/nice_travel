import 'package:flutter/material.dart';

import 'list/MyScheduleList.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: MyScheduleList(),
      ),
    );
  }
}
