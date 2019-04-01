import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/ui/trip/TripDetails.dart';
import 'package:nice_travel/model/api.dart';

class TripCard extends StatelessWidget {
  final Widget child;
  final Trip trip;

  TripCard(this.trip, {Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url;
    if (this.trip.city.photos == null || this.trip.city.photos.length == 0) {
      url = this.trip.city.defaultimg;
    } else {
      url =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${this.trip.city.photos[0].photoReference}&key=$kGoogleApiKey';
    }
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
                  image: CachedNetworkImageProvider(url))),
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
                          this.trip.city.name,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        Container(
                          height: 5,
                        ),
                        Text(
                          this
                              .trip
                              .city
                              .addressComponents[2]
                              .longName
                              .replaceFirst('State of', ''),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ]))
            ],
          )),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => TripDetails(this.trip)));
      },
    );
  }
}
