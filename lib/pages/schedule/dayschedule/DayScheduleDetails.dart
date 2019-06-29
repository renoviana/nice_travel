import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/util/FormatUtil.dart';

class DayScheduleDetails extends StatefulWidget {
  final Widget child;
  final ScheduleDay scheduleDay;

  DayScheduleDetails(this.scheduleDay, {Key key, this.child}) : super(key: key);

  _DayScheduleDetailsState createState() => _DayScheduleDetailsState();
}

class _DayScheduleDetailsState extends State<DayScheduleDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
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
          child: Icon(Icons.remove_circle, color: Colors.red,),
          minWidth: 60,
          height: 100,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(60.0)),
          onPressed: () { /*TODO REMOVER*/},
        ),
        onTap: () { /*TODO EDIT*/},
      ),
    );
  }
}
