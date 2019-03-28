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
    Widget cardimg() {
      String url;
      if (this.trip.city.photos == null || this.trip.city.photos.length == 0)
        return Image.asset(
          'assets/cityplaceholder.png',
          height: 180,
        );

      return CachedNetworkImage(
        height: 180,
        imageUrl:
            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${this.trip.city.photos[0].photoReference}&key=${kGoogleApiKey}',
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    }

    return GestureDetector(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            cardimg(),
            ListTile(
              title: Text(this.trip.city.name),
              subtitle: Text("${this.trip.numberOfDays.toString()} dias"),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => TripDetails(this.trip)));
      },
    );
  }
}
