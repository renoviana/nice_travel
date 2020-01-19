import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/common/dayschedule/ScheduleDetailsPage.dart';
import 'package:nice_travel/widgets/CustomBoxShadow.dart';

class ScheduleListItem extends StatelessWidget {
  final Schedule schedule;

  ScheduleListItem(this.schedule);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 6),
          height: 180,
          decoration: _buildBoxShadow(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCityAdress(),
                        buildCityInfo(context)
                      ]))
            ],
          )),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DaySchedulePage(this.schedule),
            settings: RouteSettings(name: "/daySchedulePage")));
      },
    );
  }

  BoxDecoration _buildBoxShadow() {
    return BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Colors.blueGrey,
            boxShadow: [CustomWidgets.buildBoxShadow(3.0)],
            image: buildDecorationImage());
  }

  Row buildCityInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildPersonName(),
        _buildQtdStar(context),
      ],
    );
  }

  Row _buildPersonName() {
    return Row(
        children: <Widget>[
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          Text(
            this.schedule.userName,
            style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w900),
          ),
        ],
      );
  }

  Text _buildCityAdress() {
    return Text(
      this.schedule.cityAddress,
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.w900),
    );
  }

  Widget _buildQtdStar(BuildContext context) {
    return Text(
      '${schedule.numberStar} ⭐',
      style: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  DecorationImage buildDecorationImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(
            Colors.white.withOpacity(0.8), BlendMode.dstATop),
        image: CachedNetworkImageProvider(this.schedule.firstImage));
  }
}
