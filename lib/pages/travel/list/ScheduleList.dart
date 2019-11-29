import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/list/ScheduleListItem.dart';

class ScheduleList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Schedule>>(
        stream: listScheduleBloc.getListSchedule,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
              color: Colors.white,
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ScheduleListItem(snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
              ),
            );
          }
        });
  }
}
