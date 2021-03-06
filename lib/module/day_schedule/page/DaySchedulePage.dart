import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/module/day_schedule/widget/ButtonBarScheduleDay.dart';
import 'package:nice_travel/module/day_schedule/widget/list/DayScheduleList.dart';
import 'package:nice_travel/util/custom_box_shadow.dart';
import 'package:nice_travel/util/format_util.dart';
import 'package:scoped_model/scoped_model.dart';

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
      return CarouselSlider.builder(
        itemCount: trip.imagesUrl.length,
        height: 240,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        autoPlay: true,
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        enlargeCenterPage: true,
        itemBuilder: (BuildContext context, int itemIndex) => Container(
            margin: EdgeInsets.symmetric(horizontal:3.0),
            height: _heigthAppBar,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBar(
                  leading: new IconButton(
                    key: Key("schedule_back_button_$itemIndex"),
                    icon: new Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
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
              boxShadow: [buildBoxShadow(3.0)],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(1), BlendMode.dstATop),
                  image: CachedNetworkImageProvider(trip.imagesUrl[itemIndex])),
            )),
      );
    });
  }

  Widget cityinfoWidget() {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [buildBoxShadow(3.0)],
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
    return Observer(
      builder:(_) =>  Text(
        'Preço médio: R\$: ${getValueFormatted(trip.priceFinal)}',
        style: TextStyle(
            color: Colors.white,
            fontFamily: "OpenSans",
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
