import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/util/ValidateLoginAction.dart';
import 'package:scoped_model/scoped_model.dart';

import '../new_schedule/new_schedule_page.dart';
import 'controller/schedule_controller.dart';
import 'widget/my_schedule_list.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final scheduleController = Modular.get<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      scheduleController.configUserModel(model);
      return Scaffold(
        key: _scaffoldKey,
        body: MyScheduleList(),
        floatingActionButton: FloatingActionButton(
          key: Key("new_schedule_button"),
          onPressed: () => validateLoginAction(
              context,
              model,
              null,
              _scaffoldKey,
              () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NewSchedulePage()))),
          child: Icon(Icons.add_circle),
          backgroundColor: Colors.blue,
        ),
      );
    });
  }
}
