import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/common/activity/ActivityTimeline.dart';
import 'package:nice_travel/widgets/ModalDialog.dart';
import 'package:nice_travel/widgets/ShowToast.dart';
import 'package:nice_travel/widgets/ValidateLoginAction.dart';
import 'package:nice_travel/widgets/showCircularProgress.dart';
import 'package:scoped_model/scoped_model.dart';

class ButtonBarScheduleDay extends StatefulWidget {
  final Schedule _trip;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  ButtonBarScheduleDay(this._trip, this._scaffoldKey);

  @override
  _ButtonBarScheduleDayState createState() => _ButtonBarScheduleDayState(_trip, _scaffoldKey);
}

class _ButtonBarScheduleDayState extends State<ButtonBarScheduleDay> {
  final Schedule _trip;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  bool hasLiked = false;

  _ButtonBarScheduleDayState(this._trip, this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildQtdStar(context),
          Wrap(
            children: <Widget>[
              buildVoteButton(model, context),
              buildRemoverButton(model, context),
              buildPublishButton(model, context),
              createIconAddDay(model, context),
            ],
          ),
        ],
      );
    });
  }

  Widget buildQtdStar(BuildContext context) {
    return Text(
      '${_trip.numberStar} ⭐',
      style: TextStyle(
          color: Colors.black,
          fontFamily: "OpenSans",
          fontSize: 24,
          fontWeight: FontWeight.bold),
    );
  }

  buildVoteButton(UserModel model, BuildContext context) {
    if (!isOwner(model) && model.isLoggedIn()) {
      return AnimatedOpacity(
          child: MaterialButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 40.0,
                    color: Colors.yellow,
                  ),
                  textButton("Curtir"),
                ],
              ),
              onPressed: () => voteAction(model, context)),
          duration: Duration(seconds: 1),
          opacity: hasLiked ? 0.4 : 1.0);
    }
    return Container();
  }

  voteAction(UserModel model, BuildContext context) {
    ScheduleApiConnection.instance
        .voteTravelSchedule(_trip.scheduleCod, model)
        .then((voted) => votedAction(voted, context));
  }

  void updateLike() {
    if (!hasLiked) {
      setState(() {
        hasLiked = true;
      });
    }
  }

  votedAction(String voted, BuildContext context) {
    updateLike();
    if (voted == "true") {
      setState(() {
        _trip.numberStar += 1;
      });
      showToastMessage(
          "Obrigado pelo voto, o seu voto foi computado.", _scaffoldKey);
    } else {
      showToastMessage(
          "Obrigado pelo voto, mas seu voto já foi computado.", _scaffoldKey);
    }
  }

  buildPublishButton(UserModel model, BuildContext context) {
    if (isOwner(model) && !_trip.isPublish) {
      return MaterialButton(
        key: Key("publish_schedule_button"),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.publish,
              size: 40.0,
              color: Colors.green,
            ),
            textButton("Publicar"),
          ],
        ),
        onPressed: () {
          publishDialog(context, "Deseja tornar esse cronograma público?",
              () => publishAction(model, context));
        },
      );
    }

    return Container();
  }

  Widget buildRemoverButton(UserModel model, BuildContext context) {
    if (isOwner(model)) {
      return MaterialButton(
        key: Key('remover_schedule'),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.delete,
              size: 40.0,
              color: Colors.red,
            ),
            textButton("Remover"),
          ],
        ),
        onPressed: () {
          removerDialog(context, "Deseja remover esse cronograma?",
              () => deleteAction(model, context));
        },
      );
    }

    return Container();
  }

  publishAction(UserModel model, BuildContext context) {
    ScheduleApiConnection.instance
        .publishSchedule(_trip.scheduleCod)
        .then((_) => {
              Navigator.pop(context),
              setState(() {
                _trip.isPublish = true;
              })
            });
  }

  Text textButton(String text) => Text(
        text,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      );

  bool isOwner(UserModel model) =>
      _trip.scheduleCod != null &&
      model.isLoggedIn() &&
      model.sessionUser.uid == _trip.userUID;

  deleteAction(UserModel model, BuildContext context) {
    showCircularProgress(context);
    ScheduleApiConnection.instance
        .deleteSchedule(_trip.scheduleCod)
        .then((_) => {
              Navigator.pop(context),
              Navigator.pop(context),
              Navigator.pop(context),
            });
  }

  Widget createIconAddDay(UserModel model, BuildContext context) {
    return MaterialButton(
      key: Key("add_schedule_day"),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.add_circle,
            size: 40.0,
            color: Colors.blue,
          ),
          textButton("Novo dia"),
        ],
      ),
      onPressed: () {
        validateLoginAction(context, model, _trip, _scaffoldKey,
            () => sendActivityTimelineWithNewDay(context));
      },
    );
  }


  Future sendActivityTimelineWithNewDay(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityTimeline.newInstance(_trip.scheduleCod)));
  }

}
