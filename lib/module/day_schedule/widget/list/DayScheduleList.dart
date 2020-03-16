import 'package:drag_list/drag_list.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListDayScheduleBloc.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/ScheduleDay.dart';
import 'package:nice_travel/module/day_schedule/widget/list/DayScheduleDetails.dart';
import 'package:nice_travel/widgets/error_connection_widget.dart';
import 'package:nice_travel/widgets/loading_widget.dart';

class DayScheduleList extends StatelessWidget {
  final Schedule _schedule;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  DayScheduleList(this._schedule, this._scaffoldKey) {
    listScheduleDayBloc.loadSchedules(_schedule.scheduleCod);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<ScheduleDay>>>(
      stream: listScheduleDayBloc.getListScheduleDay,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Loading(
                loadingMessage: snapshot.data.message,
              );
              break;
            case Status.COMPLETED:
              return buildList(snapshot.data);
              break;
            case Status.ERROR:
              return ErrorConnection(
                errorMessage: snapshot.data.message,
                onRetryPressed: () => listScheduleDayBloc.loadSchedules(_schedule.scheduleCod),
              );
              break;
          }
          return Container();
        }
      },
    );
  }

  Widget buildList(ApiResponse<List<ScheduleDay>> snapshot) {
    return Expanded(
      child: DragList<ScheduleDay>.handleless(
        items: snapshot.data,
        itemExtent: 105.0,
        builder: (context, item) {
          return DayScheduleDetails( item, _schedule, _scaffoldKey, key: Key("day_details_${item.day}"));
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
}
