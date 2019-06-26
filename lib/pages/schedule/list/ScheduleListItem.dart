import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/schedule/dayschedule/DayScheduleDetails.dart';

class ScheduleListItem extends StatelessWidget {
  final Schedule schedule;
  ScheduleListItem(this.schedule);

  @override
  Widget build(BuildContext context) {
    // Widget cardimg() {
    //   String url;
    //   if (this.trip.city.photos == null || this.trip.city.photos.length == 0)
    //     return Image.asset(
    //       'assets/cityplaceholder.png',
    //       height: 180,
    //     );

    //   return CachedNetworkImage(
    //     height: 180,
    //     imageUrl:
    //         'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${this.trip.city.photos[0].photoReference}&key=$kGoogleApiKey',
    //     width: MediaQuery.of(context).size.width,
    //     fit: BoxFit.cover,
    //     // placeholder: (context, url) => new CircularProgressIndicator(),
    //     // errorWidget: (context, url, error) => new Icon(Icons.error),
    //   );
    // }

    return GestureDetector(
      child: Container(
          margin: EdgeInsets.all(16),
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueGrey,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.6), BlendMode.dstATop),
                  image: CachedNetworkImageProvider(this.schedule.imageUrl))),
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
                      ]))
            ],
          )),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DaySchedulePage(this.schedule)));
      },
    );
  }
}
