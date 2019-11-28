import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListActivitiesBloc.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'ActivityPage.dart';
import 'IconStyleActivity.dart';

class ActivityTimeline extends StatefulWidget {
  ScheduleDay _scheduleDay;
  int _scheduleCod;

  ActivityTimeline(this._scheduleDay);

  ActivityTimeline.newInstance(this._scheduleCod);

  @override
  _ActivityTimelineState createState() =>
      _ActivityTimelineState(this._scheduleDay, this._scheduleCod);
}

class _ActivityTimelineState extends State<ActivityTimeline> {
  ScheduleDay _scheduleDay;
  int _scheduleCod;

  _ActivityTimelineState(this._scheduleDay, this._scheduleCod);

  @override
  void initState() {
    super.initState();
    if (this._scheduleDay != null) {
      listActivitiesBloc.loadActivity(_scheduleDay.id);
    } else {
      newScheduleDay();
    }
  }

  newScheduleDay() async {
    var scheduleDay =
        await ScheduleDayApiConnection.instance.addScheduleDay(_scheduleCod);
    setState(() {
      _scheduleDay = scheduleDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _scheduleDay == null
        ? Container(child: Center(child: CircularProgressIndicator()), color: Colors.white,)
        : Scaffold(
            appBar: AppBar(
              title: Row(children: [
                new Text('${_scheduleDay.day}º Dia '),
              ]),
              actions: <Widget>[
                IconButton(
                  onPressed: () => sendToNewActivity(context),
                  icon: Icon(Icons.add_circle_outline),
                )
              ],
            ),
            body: StreamBuilder<List<Activity>>(
                stream: listActivitiesBloc.getListActivity,
                initialData: [],
                builder: (context, snapshot) {
                  return snapshot.hasData && snapshot.data.length > 0
                      ? Timeline.builder(
                          position: TimelinePosition.Left,
                          itemBuilder: (ctx, i) {
                            return createTimeLine(ctx, i, snapshot);
                          },
                          itemCount: snapshot.data.length,
                        )
                      : new Container(
                          child: Text("Não tem elementos"),
                        );
                }),
          );
  }

  TimelineModel createTimeLine(
      BuildContext context, int i, AsyncSnapshot<List<Activity>> snapshot) {
    var activity = snapshot.data[i];
    final textTheme = Theme.of(context).textTheme;
    return new TimelineModel(
        GestureDetector(
          onTap: () => sendToEditActivity(context, activity),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(formatarHoraToString(activity.startActivityDate),
                      style: textTheme.caption),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Flexible(
                    child: Text(
                      activity.nameOfPlace,
                      style: textTheme.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        iconBackground: IconStyleActivity(activity.styleActivity).color,
        icon: IconStyleActivity(activity.styleActivity).icon);
  }

  sendToNewActivity(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityPage(Activity.newInstance(_scheduleDay.id))));
  }

  sendToEditActivity(BuildContext context, Activity activity) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ActivityPage(activity)));
  }
}
