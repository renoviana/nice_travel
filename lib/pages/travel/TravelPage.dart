import 'package:flutter/material.dart';
import 'package:nice_travel/pages/travel/card/ScheduleCard.dart';
import 'package:nice_travel/pages/travel/list/ScheduleList.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
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
