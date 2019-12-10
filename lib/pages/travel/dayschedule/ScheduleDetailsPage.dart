import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/pages/travel/dayschedule/ButtonBarScheduleDay.dart';
import 'package:nice_travel/util/FormatUtil.dart';
import 'package:nice_travel/widgets/CustomBoxShadow.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DayScheduleList.dart';

class DaySchedulePage extends StatefulWidget {
  final Schedule trip;

  DaySchedulePage(this.trip);

  @override
  _DaySchedulePageState createState() => _DaySchedulePageState(this.trip);
}

class _DaySchedulePageState extends State<DaySchedulePage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Schedule trip;
  double _heigthAppBar = 240;
  AnimationController _controller;
  Animation<Color> animation;

  _DaySchedulePageState(this.trip);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = ColorTween(
      begin: Colors.yellow,
      end: Colors.grey,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
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

  Widget cityinfoWidget() {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [CustomWidgets.buildBoxShadow(3.0)],
        ),
        child: ButtonBarScheduleDay(trip, _scaffoldKey));
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
}
