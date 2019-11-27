import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';

class NewSchedulePage extends StatefulWidget {
  final Schedule _schedule;

  NewSchedulePage(this._schedule);

  @override
  _NewSchedulePageState createState() => _NewSchedulePageState(_schedule);
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  final Schedule _schedule;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  _NewSchedulePageState(this._schedule);

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          _schedule.nameCity ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: CloseButton(),
      ),
      body: builtActivity(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => save(context),
        child: Icon(Icons.save),
        backgroundColor: Colors.blue,
      ),
    );
  }

  save(BuildContext context) {}

  builtActivity() {
    return Container();
  }

}
