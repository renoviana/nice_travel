import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nice_travel/app_module.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/UserModel.dart';
import 'module/tabs/tabs_screen.dart';

void main({bool testMode = false}) {
  runApp(ModularApp(module: AppModule()));
}

class MainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
//        model: testMode ? UserModel.mockLogin() : UserModel.newInstance(),
        model: UserModel.mockLogin(),
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
