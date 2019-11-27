import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/list/ScheduleListItem.dart';

class ScheduleList extends StatelessWidget {
  ScheduleList() {
    listScheduleBloc.loadSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Schedule>>(
        stream: listScheduleBloc.getListSchedule,
        initialData: [],
        builder: (context, snapshot) {
          return Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ScheduleListItem(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            ),
          );
        });
  }
}
