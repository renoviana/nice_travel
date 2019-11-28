import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/widgets/ShowToast.dart';

validateLoginAction(BuildContext context, UserModel model,
    GlobalKey<ScaffoldState> _scaffoldKey, Function function) {
  print(model.isLoggedIn());
  if (!model.isLoggedIn()) {
    buildShowSnackBarToLogin(context, model, _scaffoldKey);
  } else {
    Function.apply(function, []);
  }
}
