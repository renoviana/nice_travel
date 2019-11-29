import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListDayScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/dayschedule/DayScheduleDetails.dart';


class DayScheduleList extends StatelessWidget {
  final Schedule _schedule;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  DayScheduleList(this._schedule, this._scaffoldKey){
    listScheduleDayBloc.loadSchedules(_schedule.scheduleCod);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScheduleDay>>(
        stream: listScheduleDayBloc.getListScheduleDay,
        initialData: [],
        builder: (context, snapshot) {
          return Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return DayScheduleDetails(snapshot.data[index], _schedule, _scaffoldKey);
              },
              itemCount: snapshot.data.length,
            ),
          );
        });
  }

}
