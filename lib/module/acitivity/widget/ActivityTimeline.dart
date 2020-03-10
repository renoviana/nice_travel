import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListActivitiesBloc.dart';
import 'package:nice_travel/integration/ApiResponse.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Acitivty.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/ScheduleDay.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/util/ValidateLoginAction.dart';
import 'package:nice_travel/widgets/ErrorConnectionWidget.dart';
import 'package:nice_travel/widgets/LoadingWidget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import '../ActivityPage.dart';
import 'IconStyleActivity.dart';

class ActivityTimeline extends StatefulWidget {
  ScheduleDay _scheduleDay;
  Schedule _schedule;
  int _scheduleCod;

  ActivityTimeline(this._scheduleDay, this._schedule);

  ActivityTimeline.newInstance(this._scheduleCod);

  @override
  _ActivityTimelineState createState() => _ActivityTimelineState(
      this._scheduleDay, this._scheduleCod, this._schedule);
}

class _ActivityTimelineState extends State<ActivityTimeline> {
  ScheduleDay _scheduleDay;
  int _scheduleCod;
  Schedule _schedule;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _ActivityTimelineState(this._scheduleDay, this._scheduleCod, this._schedule);

  @override
  void initState() {
    super.initState();
    if (this._scheduleDay == null) {
      newScheduleDay();
    }
    loadList();
  }

  loadList() {
    if (this._scheduleDay != null) {
      listActivitiesBloc.loadActivity(_scheduleDay.id);
    } else {
      listActivitiesBloc.clearList();
    }
  }

  newScheduleDay() {
    ScheduleDayApiConnection.instance
        .addScheduleDay(_scheduleCod)
        .then((scheduleDay) => setState(() {
              _scheduleDay = scheduleDay;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return _scheduleDay == null
        ? Container(
            child: Center(child: CircularProgressIndicator()),
            color: Colors.white,
          )
        : ScopedModelDescendant<UserModel>(builder: (context, child, model) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                  leading: new IconButton(
                    key: Key("activity_timeline_back_button"),
                    icon: new Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                title: Row(children: [
                  new Text('${_scheduleDay.day}º Dia '),
                ]),
                actions: <Widget>[
                  IconButton(
                    key: Key("new_activity"),
                    onPressed: () => validateLoginAction(
                        context,
                        model,
                        _schedule,
                        _scaffoldKey,
                        () => sendToNewActivity(context)),
                    icon: Icon(Icons.add_circle_outline),
                  )
                ],
              ),
              body: StreamBuilder<ApiResponse<List<Activity>>>(
                  stream: listActivitiesBloc.getListActivity,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Loading();
                    } else {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );
                          break;
                        case Status.COMPLETED:
                          return buildList(snapshot.data, model);
                          break;
                        case Status.ERROR:
                          return ErrorConnection(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () => loadList(),
                          );
                          break;
                      }
                      return Container();
                    }
                  }),
            );
          });
  }

  StatelessWidget buildList(
      ApiResponse<List<Activity>> snapshot, UserModel model) {
    if (snapshot.data.length > 0)
      return Timeline.builder(
        position: TimelinePosition.Left,
        itemBuilder: (ctx, i) {
          return createTimeLine(ctx, i, snapshot, model);
        },
        itemCount: snapshot.data.length,
      );
    else {
      return new Container(
        child: Center(
            child: Text(
          "Nenhuma atividade cadastrada ainda :(",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      );
    }
  }

  TimelineModel createTimeLine(BuildContext context, int i,
      ApiResponse<List<Activity>> snapshot, UserModel model) {
    var activity = snapshot.data[i];
    final textTheme = Theme.of(context).textTheme;
    return new TimelineModel(
        GestureDetector(
          onTap: () => validateLoginAction(context, model, _schedule,
              _scaffoldKey, () => sendToEditActivity(context, activity)),
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
                  Text(
                      "${formatarHoraToString(activity.startActivityDate)} - "
                      "${formatarHoraToString(activity.finishActivityDate)}",
                      style: textTheme.caption),
                  Flexible(
                    child: Text(
                      activity.nameOfPlace,
                      style: textTheme.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'R\$: ${getValueFormatted(activity.price)}',
                      style: TextStyle(color: Colors.green, fontSize: 13),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
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
        builder: (BuildContext context) => ActivityPage(
            Activity.newInstance(_scheduleDay.id), _scheduleDay, _schedule)));
  }

  sendToEditActivity(BuildContext context, Activity activity) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityPage(activity, _scheduleDay, _schedule)));
  }
}
