import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/UserModel.dart';
import 'navigation/TabsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
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
          home: TabsScreen()
      );
    });
  }

}
