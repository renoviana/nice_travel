import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/util/FormatUtil.dart';

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
          boxShadow: [buildBoxShadow()],
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(1), BlendMode.dstATop),
              image: CachedNetworkImageProvider(widget.trip.imageUrl)),
        ));
  }

  BoxShadow buildBoxShadow() {
    return BoxShadow(
      color: Colors.grey,
      blurRadius: 1.5,
      spreadRadius: 1.5,
      offset: Offset(
        1.5, // horizontal move
        3.0, // vertica move
      ),
    );
  }

  Widget cityinfoWidget() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              cityNameTitle(),
              createIconAddDay(),
            ],
          ),
          Row(
            children: <Widget>[
              priceScheduleSubTitle(),
            ],
          ),
        ],
      ),
    );
  }

  Widget cityNameTitle() {
    return Text(
      '${widget.trip.nameCity}',
      style: TextStyle(
        fontFamily: "Literata",
        fontSize: 25,
      ),
    );
  }

  Widget createIconAddDay() {
    return MaterialButton(
      child: Icon(Icons.add_circle_outline),
      minWidth: 40,
      height: 55,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(60.0)),
      onPressed: () { /*TODO ADICIONAR NOVO DIA*/},
    );
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
