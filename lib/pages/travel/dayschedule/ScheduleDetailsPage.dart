import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/travel/activity/ActivityTimeline.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/widgets/CustomBoxShadow.dart';
import 'package:nice_travel/widgets/ModalDialog.dart';
import 'package:nice_travel/widgets/ShowToast.dart';
import 'package:nice_travel/widgets/ValidateLoginAction.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DayScheduleList.dart';

class DaySchedulePage extends StatefulWidget {
  final Schedule trip;

  DaySchedulePage(this.trip);

  @override
  _DaySchedulePageState createState() => _DaySchedulePageState(this.trip);
}

class _DaySchedulePageState extends State<DaySchedulePage> {
  final Schedule trip;

  _DaySchedulePageState(this.trip);

  double _heigthAppBar = 240;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  imageAppBar(context),
                  citycardContainer(context,
                      card: Container(
                        child: Column(
                          children: <Widget>[
                            cityinfoWidget(),
                            const SizedBox(
                              height: 8.0,
                            ),
                            DayScheduleList(trip, _scaffoldKey),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ));
  }

  Widget citycardContainer(BuildContext context, {Widget card}) {
    return Container(
      height: MediaQuery.of(context).size.height - _heigthAppBar,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: _heigthAppBar),
      child: card,
    );
  }

  Widget imageAppBar(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
          height: _heigthAppBar,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cityNameTitle(),
                      priceScheduleSubTitle(),
                    ]),
              ),
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [CustomWidgets.buildBoxShadow(3.0)],
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(1), BlendMode.dstATop),
                image: CachedNetworkImageProvider(trip.imageUrl)),
          ));
    });
  }

  buildCurtirButton(UserModel model) {
    if (isOwner(model) && !trip.isPublish) {
      return BottomNavigationBarItem(
          icon: Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          title: new Text('Curtir'));
    }
  }

  Widget cityinfoWidget() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [CustomWidgets.buildBoxShadow(3.0)],
        ),
        child: Row(
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
        ),
      );
    });
  }

  Widget cityNameTitle() {
    return Text(
      '${trip.cityAddress}',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Literata",
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
    );
  }

  Widget priceScheduleSubTitle() {
    return Text(
      'Preço médio: R\$: ${getValueFormatted(trip.priceFinal)}',
      style: TextStyle(
          color: Colors.white,
          fontFamily: "OpenSans",
          fontSize: 14,
          fontWeight: FontWeight.bold),
    );
  }

  Widget createIconAddDay(UserModel model, BuildContext context) {
    return MaterialButton(
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
        //TODO verificar se está logado, se estiver deverá verificar se o cronograma é da pessoa logada,
        // caso seja ok, caso contrario deverá criar um novo cronograma.
        validateLoginAction(context, model, widget.trip, _scaffoldKey,
            () => sendActivityTimelineWithNewDay(context));
      },
    );
  }

  Widget buildRemoverButton(UserModel model, BuildContext context) {
    if (isOwner(model)) {
      return MaterialButton(
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

  Text textButton(String text) => Text(
        text,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      );

  bool isOwner(UserModel model) =>
      trip.scheduleCod != null &&
      model.isLoggedIn() &&
      model.sessionUser.uid == trip.userUID;

  deleteAction(UserModel model, BuildContext context) {
    ScheduleApiConnection.instance
        .deleteSchedule(trip.scheduleCod)
        .then((_) => {
              Navigator.pop(context),
              Navigator.pop(context),
            });
  }

  Future sendActivityTimelineWithNewDay(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityTimeline.newInstance(trip.scheduleCod)));
  }

  buildPublishButton(UserModel model, BuildContext context) {
    if (isOwner(model) && !trip.isPublish) {
      return MaterialButton(
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
          removerDialog(context, "Deseja tornar esse cronograma público?",
              () => publishAction(model, context));
        },
      );
    }

    return Container();
  }

  publishAction(UserModel model, BuildContext context) {
    ScheduleApiConnection.instance
        .publishSchedule(trip.scheduleCod)
        .then((_) => {
              Navigator.pop(context),
              setState(() {
                trip.isPublish = true;
              })
            });
  }

  Widget buildQtdStar(BuildContext context) {
    return Text(
      '${trip.numberStar} ⭐',
      style: TextStyle(
          color: Colors.black,
          fontFamily: "OpenSans",
          fontSize: 24,
          fontWeight: FontWeight.bold),
    );
  }

  buildVoteButton(UserModel model, BuildContext context) {
    if (!isOwner(model) && model.isLoggedIn()) {
      return MaterialButton(
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
          onPressed: () => voteAction(model, context));
    }
    return Container();
  }

  voteAction(UserModel model, BuildContext context) {
    ScheduleApiConnection.instance
        .voteTravelSchedule(trip.scheduleCod, model)
        .then((voted) => votedAction(voted, context));
  }

  votedAction(Response voted, BuildContext context) {
    if (voted.body == "true") {
      setState(() {
        trip.numberStar += 1;
      });
      showToastMessage(
          "Obrigado pelo voto, o seu voto foi computado.", _scaffoldKey);
    } else {
      showToastMessage(
          "Obrigado pelo voto, mas seu voto já foi computado.", _scaffoldKey);
    }
  }
}
