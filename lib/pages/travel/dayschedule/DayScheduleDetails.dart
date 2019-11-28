import 'package:flutter/material.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/travel/activity/ActivityTimeline.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/widgets/RemoverDialog.dart';
import 'package:nice_travel/widgets/ValidateLoginAction.dart';
import 'package:scoped_model/scoped_model.dart';

class DayScheduleDetails extends StatefulWidget {
  final Widget child;
  final ScheduleDay scheduleDay;
  final GlobalKey<ScaffoldState> scaffoldKey;

  DayScheduleDetails(this.scheduleDay, this.scaffoldKey,
      {Key key, this.child}) : super(key: key);

  _DayScheduleDetailsState createState() => _DayScheduleDetailsState();
}

class _DayScheduleDetailsState extends State<DayScheduleDetails> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              "Dia  ${widget.scheduleDay.day}",
              style: TextStyle(fontFamily: "Literata"),
            ),
            subtitle: Text(
              "R\$: ${getValueFormatted(widget.scheduleDay.priceDay)}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.green,
                fontFamily: "OpenSans",
              ),
            ),
            trailing: MaterialButton(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              minWidth: 60,
              height: 100,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(60.0)),
              onPressed: () =>
                  validateLoginAction(
                      context,
                      model,
                      widget.scaffoldKey,
                          () =>
                          removerDialog(
                              context,
                              'Deseja remover o dia ${widget.scheduleDay.day}?',
                              deleteScheduleDay))
            ),
            onTap: sendActivityTimeline,
          ),
        ),
      );
    });
  }

  deleteScheduleDay() {
    ScheduleDayApiConnection.instance.deleteScheduleDay(widget.scheduleDay.id);
    Navigator.pop(context);
  }

  Future sendActivityTimeline() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityTimeline(widget.scheduleDay)));
  }
}
