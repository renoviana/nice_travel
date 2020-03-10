import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/widgets/ErrorConnectionWidget.dart';
import 'package:nice_travel/widgets/LoadingWidget.dart';
import 'package:nice_travel/widgets/schedule/ScheduleListItem.dart';
class ScheduleList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<Schedule>>>(
        stream: listScheduleBloc.getListSchedule,
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
                  onRetryPressed: () => listScheduleBloc.loadSchedules(null),
                );
                break;
            }
            return Container();
          }
        });
  }

  Expanded buildList(ApiResponse<List<Schedule>> snapshot) {
     return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ScheduleListItem(snapshot.data[index]);
        },
        itemCount: snapshot.data.length,
      ),
    );
  }
}
