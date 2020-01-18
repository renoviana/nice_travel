import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/login/SignIn.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/common/dayschedule/ScheduleDetailsPage.dart';
import 'package:nice_travel/widgets/showCircularProgress.dart';

void showToastMessage(String message, GlobalKey<ScaffoldState> _scaffoldKey) {
  _scaffoldKey.currentState.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text(message)),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    buildShowSnackBarToLogin(BuildContext context, UserModel model,
        GlobalKey<ScaffoldState> _scaffoldKey) {
  _scaffoldKey.currentState.removeCurrentSnackBar();
  return _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: const Text('É necessário realizar login'),
      action: SnackBarAction(
          label: 'Login',
          onPressed: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignIn(model)))
              }),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    buildShowSnackBarToDuplicateSchedule(BuildContext context, UserModel model,
        Schedule schedule, GlobalKey<ScaffoldState> _scaffoldKey) {
  _scaffoldKey.currentState.removeCurrentSnackBar();
  return _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content:
          const Text('Para alterar é necessário adicionar esse cronograma.'),
      action: SnackBarAction(
          label: 'Adicionar',
          onPressed: () => _duplicate(context, model, schedule)),
    ),
  );
}

void _duplicate(
    BuildContext context, UserModel model, Schedule schedule) {
  showCircularProgress(context);
  ScheduleApiConnection.instance
      .duplicateSchedule(schedule.scheduleCod, model.sessionUser)
      .then((scheduleCreated) =>
          _navigateToDaySchedulePage(context, model, scheduleCreated));
}

void _navigateToDaySchedulePage(
    BuildContext context, UserModel model, Schedule scheduleCreated) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => DaySchedulePage(scheduleCreated), settings: RouteSettings(name: "/daySchedulePage")),
      ModalRoute.withName('/'));
}
