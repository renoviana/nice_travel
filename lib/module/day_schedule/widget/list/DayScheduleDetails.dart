import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListDayScheduleBloc.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/ScheduleDay.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/module/acitivity/widget/ActivityTimeline.dart';
import 'package:nice_travel/module/acitivity/widget/IconStyleActivity.dart';
import 'package:nice_travel/util/ValidateLoginAction.dart';
import 'package:nice_travel/util/format_util.dart';
import 'package:nice_travel/util/modal_dialog.dart';
import 'package:nice_travel/util/show_circular_progress.dart';
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
              title: _buildTitle(),
              trailing: _buildRemoveButton(context, model),
              onTap: sendActivityTimeline,
            ),
          ),
        ),
      );
    });
  }

  MaterialButton _buildRemoveButton(BuildContext context, UserModel model) {
    return MaterialButton(
        key: Key("remover_schedule_day_${widget.scheduleDay.day}"),
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
                deleteScheduleDay)));
  }

  Text _buildPriceSubtitle() {
    return Text(
      "R\$: ${getValueFormatted(widget.scheduleDay.priceDay)}",
      style: TextStyle(
        fontSize: 14,
        color: Colors.green,
        fontFamily: "OpenSans",
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: <Widget>[
        _buildDayText(),
        _buildActivitiesCount(),
        _buildPriceSubtitle(),
      ],
    );
  }

  Text _buildActivitiesCount() {
    return Text(
      "${widget.scheduleDay.qtdActivities} Atividades",
      style: TextStyle(fontFamily: "Literata"),
    );
  }

  Text _buildDayText() {
    return Text(
      "${widget.scheduleDay.day}º Dia",
      style: TextStyle(fontFamily: "Literata", fontWeight: FontWeight.bold),
    );
  }

  Widget buildLeadingIcon() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.scheduleDay.typeFirstActivity != null
            ? IconStyleActivity(widget.scheduleDay.typeFirstActivity,
                    withColor: true)
                .icon
            : IconStyleActivity(Style.OTHER.toString(), withColor: true).icon);
  }

  deleteScheduleDay() {
    showCircularProgress(context);
    ScheduleDayApiConnection.instance
        .deleteScheduleDay(widget.scheduleDay.id)
        .then((_) => popAfterDeleteSchedule());
  }

  popAfterDeleteSchedule() {
    listScheduleDayBloc.loadSchedules(widget.schedule.scheduleCod);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future sendActivityTimeline() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityTimeline(widget.scheduleDay, widget.schedule)));
  }
}
