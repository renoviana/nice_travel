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

  double _heigthAppBar = 280;
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
                  citycardContainer(context,
                      card: Container(
                        padding: EdgeInsets.only(left: 12, right: 12, top: 5),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.rectangle),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            cityinfoWidget(),
                            DayScheduleList(trip, _scaffoldKey),
                          ],
                        ),
                      )),
                  imageAppBar(context),
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
      color: Color(0xff758698),
      margin: EdgeInsets.only(top: _heigthAppBar),
      child: card,
    );
  }

  Widget imageAppBar(BuildContext context) {
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
  }

  Widget cityinfoWidget() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildQtdStar(context),
            Wrap(
              spacing: 10, // to apply margin horizontally
              runSpacing: 10, // to apply margin vertically
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
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle,
            size: 40.0,
            color: Colors.blue,
          ),
          onPressed: () {
            //TODO verificar se está logado, se estiver deverá verificar se o cronograma é da pessoa logada,
            // caso seja ok, caso contrario deverá criar um novo cronograma.
            validateLoginAction(context, model, _scaffoldKey,
                () => sendActivityTimelineWithNewDay(context));
          },
        ),
        textButton("Novo dia"),
      ],
    );
  }

  buildButtons() {}

  Widget buildRemoverButton(UserModel model, BuildContext context) {
    if (isOwner(model)) {
      return Column(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              size: 40.0,
              color: Colors.red,
            ),
            onPressed: () {
              removerDialog(context, "Deseja remover esse cronograma?",
                  () => deleteAction(model, context));
            },
          ),
          textButton("Remover"),
        ],
      );
    }

    return Container();
  }

  Text textButton(String text) => Text(
        text,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );

  bool isOwner(UserModel model) =>
      trip.scheduleCod != null &&
      model.isLoggedIn() &&
      model.sessionUser.uid == trip.userUID;

  deleteAction(UserModel model, BuildContext context) {
    ScheduleApiConnection.instance.deleteSchedule(trip.scheduleCod);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future sendActivityTimelineWithNewDay(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityTimeline.newInstance(trip.scheduleCod)));
  }

  buildPublishButton(UserModel model, BuildContext context) {
    if (isOwner(model) && !trip.isPublish) {
      return Column(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.publish,
              size: 40.0,
              color: Colors.green,
            ),
            onPressed: () {
              removerDialog(context, "Deseja tornar esse cronograma público?",
                  () => publishAction(model, context));
            },
          ),
          textButton("Publicar"),
        ],
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.star,
                size: 40.0,
                color: Colors.yellow,
              ),
              onPressed: () => voteAction(model, context)),
          textButton("Curtir"),
        ],
      );
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
          "Obrigado pelo voto, mas seu voto já foi computado.",
          _scaffoldKey);
    }
  }
}
