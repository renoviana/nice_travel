import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/schedule/activity/ActivityTimeline.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/widgets/CustomBoxShadow.dart';

import 'DayScheduleList.dart';

class DaySchedulePage extends StatefulWidget {
  final Widget child;
  final Schedule trip;

  DaySchedulePage(this.trip, {Key key, this.child}) : super(key: key);

  _DaySchedulePageState createState() => _DaySchedulePageState();
}

class _DaySchedulePageState extends State<DaySchedulePage> {
  double _heigthAppBar = 280;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    DayScheduleList(widget.trip),
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
      height: MediaQuery.of(context).size.height - _heigthAppBar,
      width: MediaQuery.of(context).size.width,
      color: Color(0xff758698),
      margin: EdgeInsets.only(top: _heigthAppBar),
      child: card,
    );
  }

  Widget imageAppBar() {
    return Container(
        height: _heigthAppBar,
        width: MediaQuery.of(context).size.width,
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
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              cityNameTitle(),
              priceScheduleSubTitle(),
            ],
          ),
          createIconAddDay(),
        ],
      ),
    );
  }

  Widget cityNameTitle() {
    return Text(
      '${widget.trip.nameCity}',
      style: TextStyle(
        fontFamily: "Literata",
        fontSize: 30,
      ),
    );
  }

  Widget createIconAddDay() {
    return MaterialButton(
      child: Center(
          child: Icon(
        Icons.add_circle,
        size: 40.0,
        color: Colors.blue,
      )),
      minWidth: 50,
      height: 65,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(100.0)),
      onPressed: () {
        sendActivityTimelineWithNewDay();
      },
    );
  }

  Future sendActivityTimelineWithNewDay() async {
    ScheduleDay scheduleDay = await ScheduleDayApiConnection.instance
        .addScheduleDay(widget.trip.scheduleCod);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ActivityTimeline(scheduleDay)));
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
