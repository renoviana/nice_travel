import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';
import 'package:nice_travel/pages/travel/card/ScheduleCard.dart';
import 'package:nice_travel/pages/travel/list/ScheduleList.dart';

class TravelPage extends StatelessWidget {

  TravelPage(){
    listScheduleBloc.loadSchedules(null);
  }

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
