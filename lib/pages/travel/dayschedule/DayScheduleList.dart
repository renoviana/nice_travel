import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListDayScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/dayschedule/DayScheduleDetails.dart';

class DayScheduleList extends StatefulWidget {
  final Schedule _schedule;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  DayScheduleList(this._schedule, this._scaffoldKey);

  @override
  _DayScheduleListState createState() =>
      _DayScheduleListState(this._schedule, this._scaffoldKey);
}

class _DayScheduleListState extends State<DayScheduleList> {
  final Schedule schedule;
  final GlobalKey<ScaffoldState> scaffoldKey;

  _DayScheduleListState(this.schedule, this.scaffoldKey);

  @override
  void initState() {
    listScheduleDayBloc.loadSchedules(schedule.scheduleCod);
    super.initState();
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
                return DayScheduleDetails(snapshot.data[index], scaffoldKey);
              },
              itemCount: snapshot.data.length,
            ),
          );
        });
  }
}
