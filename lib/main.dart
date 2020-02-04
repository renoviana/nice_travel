import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/UserModel.dart';
import 'navigation/TabsScreen.dart';

void main({bool testMode = false}) {
  runApp(MyApp(testMode));
}

class MyApp extends StatelessWidget {
  final bool testMode;
  MyApp(this.testMode);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: testMode ? UserModel.mockLogin() : UserModel.newInstance(),
        child: buildScopedModelDescendant());
  }

  ScopedModelDescendant<UserModel> buildScopedModelDescendant() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      model.signInSilently();
      return MaterialApp(
          title: 'Nice Travel',
          theme: ThemeData(
            fontFamily: 'Raleway',
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.blue[600],
                ),
            // This colors the [InputOutlineBorder] when it is selected
            primaryColor: Colors.blue[500],
            textSelectionHandleColor: Colors.green[500],
          ),
          home: TabsScreen());
    });
  }
}
