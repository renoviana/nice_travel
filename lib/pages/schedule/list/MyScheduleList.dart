import 'package:flutter/material.dart';
import 'package:nice_travel/controller/schedule/MyListScheduleBloc.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/common/ScheduleListItem.dart';
import 'package:nice_travel/widgets/ErrorConnection.dart';
import 'package:nice_travel/widgets/Loading.dart';

class MyScheduleList extends StatelessWidget {
  final UserModel _model;

  MyScheduleList(this._model){
    loadList();
  }

  void loadList() {
    if (_model.isLoggedIn()) {
      myListScheduleBloc.loadSchedules(_model.sessionUser.uid);
    } else {
      myListScheduleBloc.clearList();
    }
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
                  onRetryPressed: () => loadList(),
                );
                break;
            }
            return Container();
          }
        });
  }

  ListView buildList(ApiResponse<List<Schedule>> snapshot) {
     return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ScheduleListItem(snapshot.data[index]);
      },
      itemCount: snapshot.data.length,
    );
  }
}
