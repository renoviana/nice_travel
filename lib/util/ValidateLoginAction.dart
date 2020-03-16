import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/widgets/show_toast.dart';

validateLoginAction(BuildContext context, UserModel model, Schedule schedule,
    GlobalKey<ScaffoldState> _scaffoldKey, Function function) {
  if (!model.isLoggedIn()) {
    buildShowSnackBarToLogin(context, model, _scaffoldKey);
  } else {
    if(schedule != null && !_isOwner(model, schedule)){
      buildShowSnackBarToDuplicateSchedule(context, model, schedule, _scaffoldKey);
    } else {
      Function.apply(function, []);
    }
  }
}

bool _isOwner(UserModel model, Schedule schedule) =>
    schedule.scheduleCod != null &&
        model.isLoggedIn() &&
        model.sessionUser.uid == schedule.userUID;