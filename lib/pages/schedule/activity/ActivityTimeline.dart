import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/ListActivitiesBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ActivityTimeline extends StatelessWidget {
  ActivityTimeline(ScheduleDay scheduleDay) {
    listActivitiesBloc.loadActivity(scheduleDay.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Activity>>(
          stream: listActivitiesBloc.getListActivity,
          initialData: [],
          builder: (context, snapshot) {
            return snapshot.hasData && snapshot.data.length > 0
                ? Timeline.builder(itemBuilder: (ctx, i) {
                    return createTimeLine(ctx, i, snapshot);
                  })
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
    return new TimelineModel(Card(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(activity.startActivity.toString(),
                style: textTheme.caption),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              activity.nameOfPlace,
              style: textTheme.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    ));
  }
}
