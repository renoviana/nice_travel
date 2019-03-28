import 'package:flutter/material.dart';

import 'package:flutter_url_image_load_fail/flutter_url_image_load_fail.dart';

import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/ui/trip/TripDetails.dart';

class TripCard extends StatelessWidget {
  final Widget child;
  final Trip trip;

  TripCard(this.trip, {Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LoadImageFromUrl(
              'https://rodoviariaonline.com.br/wp-content/uploads/2018/11/deseja-um-pouco-de-axe-confira-as-8-principais-praias-em-salvador-640x427.jpg',
              (image) =>
                  image, //What widget returns when the image is loaded successfully
              () => Text(
                  'Loading...'), //What widget returns when the image is loading
              (IRetryLoadImage retryLoadImage, code, message) {
                //What widget returns when the image failed to load
                retryLoadImage.retryLoadImage();
                return Container();
              },
            ),
            ListTile(
              title: Text(this.trip.city),
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
