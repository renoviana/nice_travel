import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/model/api.dart';

class TripDetails extends StatefulWidget {
  final Widget child;
  final Trip trip;
  TripDetails(this.trip, {Key key, this.child}) : super(key: key);

  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  String url = '';
  double _heigthAppBar = 280;

  @override
  Widget build(BuildContext context) {
    if (widget.trip.city.photos == null ||
        widget.trip.city.photos.length == 0) {
      url = widget.trip.city.defaultimg;
    } else {
      url =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${widget.trip.city.photos[0].photoReference}&key=$kGoogleApiKey';
    }
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              citycardContainer(
                  card: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[cityinfoWidget(), listDays()],
                ),
              )),
              imageAppBar(),
            ],
          ),
          // Container(
          //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          //   child: listDays(),
          // )
        ],
      ),
    ));
  }

  Widget citycardContainer({Widget card}) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
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
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(1), BlendMode.dstATop),
              image: CachedNetworkImageProvider(url)),
        ));
  }

  Widget cityinfoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          infoTitle(),
        ],
      ),
    );
  }

  Widget infoTitle() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${widget.trip.city.name}',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget infoBar(List<Widget> itens) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
      child: Row(
        children: itens,
      ),
    );
  }

  Widget infoItem(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 18,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  Widget listDays() {
    return Container(
      child: Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: widget.trip.numberOfDays,
          itemBuilder: (BuildContext context, int i) {
            return new ListTile(
              title: Text("Dia  $i"),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
