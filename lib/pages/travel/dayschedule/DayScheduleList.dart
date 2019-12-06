import 'package:drag_list/drag_list.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListDayScheduleBloc.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/dayschedule/DayScheduleDetails.dart';

class DayScheduleList extends StatelessWidget {
  final Schedule _schedule;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  DayScheduleList(this._schedule, this._scaffoldKey) {
    listScheduleDayBloc.setListScheduleDay.add(null);
    listScheduleDayBloc.loadSchedules(_schedule.scheduleCod);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScheduleDay>>(
      stream: listScheduleDayBloc.getListScheduleDay,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
            color: Colors.white,
          );
        } else {
          return Expanded(
            child: DragList<ScheduleDay>.handleless(
              items: snapshot.data,
              itemExtent: 92.0,
              builder: (context, item) {
                return DayScheduleDetails(item, _schedule, _scaffoldKey);
              },
              onItemReorder: (from, to) {
                var idFrom = snapshot.data[from].id;
                var idTo = snapshot.data[to].id;
                ScheduleDayApiConnection.instance.reorderDays(idFrom, idTo).then(
                    (_) => listScheduleDayBloc
                        .loadSchedules(_schedule.scheduleCod));
                // handle item reorder on your own
              },
            ),
          );
        }
      },
    );
  }
}
