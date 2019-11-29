import 'package:flutter/material.dart';
import 'package:nice_travel/controller/schedule/MyListScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/travel/list/ScheduleListItem.dart';

class MyScheduleList extends StatefulWidget {
  final UserModel _model;
  MyScheduleList(this._model);

  @override
  _MyScheduleListState createState() => _MyScheduleListState(_model);
}

class _MyScheduleListState extends State<MyScheduleList> {
  final UserModel _model;
  _MyScheduleListState(this._model);

  @override
  void initState() {
    super.initState();
    if(_model.isLoggedIn()) {
      myListScheduleBloc.loadSchedules(_model.sessionUser.uid);
    }
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

