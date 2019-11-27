import 'package:flutter/material.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/activity/ActivityTimeline.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/widgets/RemoverDialog.dart';

class DayScheduleDetails extends StatefulWidget {
  final Widget child;
  final ScheduleDay scheduleDay;

  DayScheduleDetails(this.scheduleDay, {Key key, this.child}) : super(key: key);

  _DayScheduleDetailsState createState() => _DayScheduleDetailsState();
}

class _DayScheduleDetailsState extends State<DayScheduleDetails> {
  @override
  Widget build(BuildContext context) {
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
              Icons.remove_circle_outline,
              color: Colors.red,
            ),
            minWidth: 60,
            height: 100,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(60.0)),
            onPressed: () => removerDialog(
                context,
                'Deseja remover o dia ${widget.scheduleDay.day}?',
                deleteScheduleDay),
          ),
          onTap: sendActivityTimeline,
        ),
      ),
    );
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
