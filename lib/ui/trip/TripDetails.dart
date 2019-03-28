import 'package:flutter/material.dart';

import 'package:flutter_url_image_load_fail/flutter_url_image_load_fail.dart';

import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/ui/DayTimeLine.dart';

class TripDetails extends StatefulWidget {
  final Widget child;
  final Trip trip;
  TripDetails(this.trip, {Key key, this.child}) : super(key: key);

  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
          Container(
            child: ListTile(
              title: Text(
                widget.trip.city,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text("${widget.trip.numberOfDays.toString()} dias",
                  style: TextStyle(color: Colors.white)),
            ),
            color: Colors.blueGrey,
          ),
          listDays()
        ],
      ),
    );
  }

  Widget listDays() {
    return new Expanded(
      child: ListView.builder(
        itemCount: widget.trip.dias.length,
        itemBuilder: (BuildContext context, int i) {
          return new ListTile(
            title: Text("Dia  $i"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DayTimeLine(widget.trip.dias[i])));
            },
          );
        },
      ),
    );
  }
}
