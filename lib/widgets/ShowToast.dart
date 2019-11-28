import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/login/SignIn.dart';
import 'package:nice_travel/model/UserModel.dart';

void showToastMessage(String message, GlobalKey<ScaffoldState> _scaffoldKey) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text(message)),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    buildShowSnackBarToLogin(BuildContext context, UserModel model,
        GlobalKey<ScaffoldState> _scaffoldKey) {
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
