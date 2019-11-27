import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/dayschedule/ScheduleDetailsPage.dart';
import 'package:nice_travel/widgets/CustomBoxShadow.dart';

class FavoriteListItem extends StatelessWidget {
  final Schedule schedule;
  FavoriteListItem(this.schedule);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 6),
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.blueGrey,
              boxShadow: [CustomWidgets.buildBoxShadow(5.0)],
              image: buildDecorationImage()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.schedule.nameCity,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        Container(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            Text(
                              /*TODO Criar busca do autor*/
                              "Reno Viana",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        )
                      ]))
            ],
          )),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DaySchedulePage(this.schedule)));
      },
    );
  }

  DecorationImage buildDecorationImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(
            Colors.white.withOpacity(0.8), BlendMode.dstATop),
        image: CachedNetworkImageProvider(this.schedule.imageUrl));
  }

}
