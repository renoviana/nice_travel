import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListDayScheduleBloc.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/travel/activity/ActivityTimeline.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/widgets/ModalDialog.dart';
import 'package:nice_travel/widgets/ValidateLoginAction.dart';
import 'package:nice_travel/widgets/showCircularProgress.dart';
import 'package:scoped_model/scoped_model.dart';

class DayScheduleDetails extends StatefulWidget {
  final Widget child;
  final ScheduleDay scheduleDay;
  final Schedule schedule;
  final GlobalKey<ScaffoldState> scaffoldKey;

  DayScheduleDetails(this.scheduleDay, this.schedule, this.scaffoldKey,
      {Key key, this.child})
      : super(key: key);

  _DayScheduleDetailsState createState() => _DayScheduleDetailsState();
}

class _DayScheduleDetailsState extends State<DayScheduleDetails> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: buildLeadingIcon(),
              title: Text(
                "${widget.scheduleDay.day}º Dia",
                style: TextStyle(fontFamily: "Literata"),
              ),
              subtitle: Text(
                "R\$: ${getValueFormatted(widget.scheduleDay.priceDay)}",
                style: TextStyle(
                  fontSize: 14,
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
                  onPressed: () => validateLoginAction(
                      context,
                      model,
                      widget.schedule,
                      widget.scaffoldKey,
                      () => removerDialog(
                          context,
                          'Deseja remover o dia ${widget.scheduleDay.day}?',
                          deleteScheduleDay))),
              onTap: sendActivityTimeline,
            ),
          ),
        ),
      );
    });
  }

  Widget buildLeadingIcon() {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Icon(Icons.attach_money, color: Colors.green, size: 25,),
   );
  }

  deleteScheduleDay() {
    showCircularProgress(context);
    ScheduleDayApiConnection.instance
        .deleteScheduleDay(widget.scheduleDay.id)
        .then((_) => {
              listScheduleDayBloc.loadSchedules(widget.schedule.scheduleCod),
              Navigator.pop(context),
              Navigator.pop(context),
            });
  }

  Future sendActivityTimeline() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityTimeline(widget.scheduleDay, widget.schedule)));
  }
}
