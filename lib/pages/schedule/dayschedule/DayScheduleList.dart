import 'package:flutter/material.dart';
import 'package:nice_travel/controller/ListDayScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/schedule/dayschedule/DayScheduleDetails.dart';

class DayScheduleList extends StatelessWidget {
  DayScheduleList(Schedule schedule) {
    listScheduleDayBloc.loadSchedules(schedule.scheduleCod);
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
                return DayScheduleDetails(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            ),
          );
        });
  }
}
