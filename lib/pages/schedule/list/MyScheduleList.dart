import 'package:flutter/material.dart';
import 'package:nice_travel/controller/schedule/MyListScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/list/ScheduleListItem.dart';

class MyScheduleList extends StatefulWidget {
  @override
  _MyScheduleListState createState() => _MyScheduleListState();
}

class _MyScheduleListState extends State<MyScheduleList> {
  @override
  void initState() {
    super.initState();
    myListScheduleBloc.loadSchedules([1,2,3]);
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Schedule>>(
        stream: myListScheduleBloc.getListSchedule,
        initialData: [],
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ScheduleListItem(snapshot.data[index]);
            },
            itemCount: snapshot.data.length,
          );
        });
  }
}

