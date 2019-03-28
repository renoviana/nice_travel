import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/model/api.dart';
import 'package:nice_travel/ui/trip/TripDetails.dart';

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
            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${this.trip.city.photos[0].photoReference}&key=$kGoogleApiKey',
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    }

    return GestureDetector(
      child: Container(
          margin: EdgeInsets.all(16),
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueGrey,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.6), BlendMode.dstATop),
                  image: CachedNetworkImageProvider(
                      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${this.trip.city.photos[0].photoReference}&key=${kGoogleApiKey}'))),
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
                          this.trip.city.addressComponents[2].longName,
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
