import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/travel/activity/ActivityTimeline.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/widgets/CustomBoxShadow.dart';
import 'package:nice_travel/widgets/RemoverDialog.dart';
import 'package:nice_travel/widgets/ValidateLoginAction.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DayScheduleList.dart';

class DaySchedulePage extends StatefulWidget {
  final Widget child;
  final Schedule trip;

  DaySchedulePage(this.trip, {Key key, this.child}) : super(key: key);

  _DaySchedulePageState createState() => _DaySchedulePageState();
}

class _DaySchedulePageState extends State<DaySchedulePage> {
  double _heigthAppBar = 280;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  citycardContainer(
                      card: Container(
                        padding: EdgeInsets.only(left: 12, right: 12, top: 5),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.rectangle),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            cityinfoWidget(),
                            DayScheduleList(widget.trip, _scaffoldKey),
                          ],
                        ),
                      )),
                  imageAppBar(),
                ],
              ),
            ],
          ),
        ));
  }

  Widget citycardContainer({Widget card}) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height - _heigthAppBar,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Color(0xff758698),
      margin: EdgeInsets.only(top: _heigthAppBar),
      child: card,
    );
  }

  Widget imageAppBar() {
    return Container(
        height: _heigthAppBar,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        decoration: BoxDecoration(
          boxShadow: [CustomWidgets.buildBoxShadow(3.0)],
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(1), BlendMode.dstATop),
              image: CachedNetworkImageProvider(widget.trip.imageUrl)),
        ));
  }

  Widget cityinfoWidget() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                children: <Widget>[
                  cityNameTitle(),
                  priceScheduleSubTitle(),
                ],
              ),
            ),
            buildRemoverButton(model),
            createIconAddDay(model),
          ],
        ),
      );
    });
  }

  Widget cityNameTitle() {
    return Text(
      '${widget.trip.nameCity}',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Literata",
        fontSize: 30,
      ),
    );
  }

  Widget createIconAddDay(UserModel model) {
    return IconButton(
      icon: Icon(
        Icons.add_circle,
        size: 40.0,
        color: Colors.blue,
      ),
      onPressed: () {
        //TODO verificar se está logado, se estiver deverá verificar se o cronograma é da pessoa logada,
        // caso seja ok, caso contrario deverá criar um novo cronograma.
        validateLoginAction(
            context,
            model,
            _scaffoldKey,
                () => sendActivityTimelineWithNewDay());
      },
    );
  }


  buildButtons() {

  }

  Widget buildRemoverButton(UserModel model) {
    if (ableDelete(model)) {
      return IconButton(
        icon: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.red,
        ),
        onPressed: () {
          removerDialog(
              context, "Deseja remover esse cronograma?", deleteAction);
        },
      );
    }

    return Container();
  }

  bool ableDelete(UserModel model) => widget.trip.scheduleCod != null && model.isLoggedIn() && model.sessionUser.uid == widget.trip.userUID;

  deleteAction() {
    ScheduleApiConnection.instance.deleteSchedule(widget.trip.scheduleCod);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future sendActivityTimelineWithNewDay() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ActivityTimeline.newInstance(widget.trip.scheduleCod)));
  }

  Widget priceScheduleSubTitle() {
    return Text(
      'Preço médio: R\$: ${getValueFormatted(widget.trip.priceFinal)}',
      style: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.green),
    );
  }

}
