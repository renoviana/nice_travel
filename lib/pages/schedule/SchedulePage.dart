import 'package:flutter/material.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/widgets/ValidateLoginAction.dart';
import 'package:scoped_model/scoped_model.dart';

import 'NewSchedulePage.dart';
import 'list/MyScheduleList.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      model.signInSilently();
      return Scaffold(
        key: _scaffoldKey,
        body: MyScheduleList(model),
        floatingActionButton: FloatingActionButton(
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
