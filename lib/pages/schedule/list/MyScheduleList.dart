import 'package:flutter/material.dart';
import 'package:nice_travel/controller/schedule/MyListScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/favorite/list/FavoriteListItem.dart';

class MyScheduleList extends StatelessWidget {
  MyScheduleList() {
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
              print(snapshot.data[index].nameCity);
              return FavoriteListItem(snapshot.data[index]);
            },
            itemCount: snapshot.data.length,
          );
        });
  }
}
