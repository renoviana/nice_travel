import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/schedule/activity/ActivityTimeline.dart';
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
            child: Icon(Icons.remove_circle_outline, color: Colors.red,),
            minWidth: 60,
            height: 100,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(60.0)),
            onPressed: removerDialog,
          ),
          onTap: sendActivityTimeline,
        ),
      ),
    );
  }

  Future sendActivityTimeline() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ActivityTimeline(widget.scheduleDay)));
  }


  void removerDialog() {
    showDialog(
      context: context,builder: (_) => AssetGiffyDialog(
      image: new Image.asset("noo.gif"),
      title: Text('Deseja remover o dia ${widget.scheduleDay.day}?',
        style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.w600),
      ),
      description: Text('Esse dia será apagado e não poderá ser revertido.',
        textAlign: TextAlign.center,
        style: TextStyle(),
      ),
      entryAnimation: EntryAnimation.BOTTOM_LEFT,
      onOkButtonPressed: () {},
    ) );
  }
}
