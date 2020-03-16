import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nice_travel/controller/schedule/MyListScheduleBloc.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/widgets/ErrorConnectionWidget.dart';
import 'package:nice_travel/widgets/LoadingWidget.dart';
import 'package:nice_travel/widgets/schedule/ScheduleListItem.dart';

import '../controller/schedule_controller.dart';

class MyScheduleList extends StatelessWidget {
  final _scheduleController = Modular.get<ScheduleController>();

  MyScheduleList(){
    _scheduleController.initializeMySchedules();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<Schedule>>>(
        stream: myListScheduleBloc.getListSchedule,
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
                  onRetryPressed: () => _scheduleController.initializeMySchedules(),
                );
                break;
            }
            return Container();
          }
        });
  }

  ListView buildList(ApiResponse<List<Schedule>> snapshot) {
     return ListView.builder(
       key: Key("my_schedule_list"),
      itemBuilder: (BuildContext context, int index) {
        return ScheduleListItem(snapshot.data[index]);
      },
      itemCount: snapshot.data.length,
    );
  }
}
