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
    return ListTile(
      title: Text(
        "Dia  ${widget.scheduleDay.day}",
        style: TextStyle(fontFamily: "OpenSans"),
      ),
      subtitle: Text(
        "R\$: ${getValueFormatted(widget.scheduleDay.priceDay)}",
        style: TextStyle(fontSize: 12, color: Colors.green),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {},
      ),
      onTap: () {},
    );
  }
}