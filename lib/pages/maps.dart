// import 'dart:async';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';

// import 'package:nice_travel/pages/schedule/ScheduleDetails.dart';

// class MapsWidget extends StatefulWidget {
//   MapsWidget(this.bloc);
//   @override
//   _MapsWidgetState createState() => _MapsWidgetState();
// }

// class _MapsWidgetState extends State<MapsWidget> {
//   Completer<GoogleMapController> _controller = Completer();

//   CameraPosition _brasil = CameraPosition(
//     target: LatLng(-13.7056818, -69.6487261),
//     zoom: 4,
//   );

//   @override
//   Widget build(BuildContext context) {
//     Set<Marker> markers = Set();

//     //bloc.getList();
//     StreamSubscription subscription = widget.bloc.outList.listen((onData) {
//       setState(() {
//         _brasil = CameraPosition(
//           target: LatLng(onData[0].city.geometry.location.lat,
//               onData[0].city.geometry.location.lng),
//           zoom: 4,
//         );
//       });
//       onData.forEach((results) {
//         setState(() {
//           markers.add(Marker(
//               markerId: MarkerId(results.city.id),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         ScheduleDetails(results)));
//               },
//               position: LatLng(results.city.geometry.location.lat,
//                   results.city.geometry.location.lng)));
//         });
//       });
//     });
//     if (markers.length != 0) {
//       subscription.cancel();
//     }
//     return GoogleMap(
//       mapType: MapType.terrain,
//       markers: markers,
//       initialCameraPosition: _brasil,
//       onMapCreated: (GoogleMapController controller) {
//         _controller.complete(controller);
//       },
//     );
//   }

// //   void _showDialog(Result cidade) {
// //     // flutter defined function
// //     showDialog(
// //         context: context,
// //         builder: (_) => Column(
// //                 verticalDirection: VerticalDirection.up,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Container(
// //                     width: 80.0,
// //                     height: 80.0,
// //                     child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.end,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: <Widget>[
// //                           Container(
// //                               child: Center(
// //                             child: Text(
// //                               cidade.name.substring(0, 1),
// //                               style: TextStyle(
// //                                   fontSize: 50,
// //                                   color: Colors.white,
// //                                   fontWeight: FontWeight.w900),
// //                             ),
// //                           ))
// //                         ]),
// //                     decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         color: Colors.blueGrey,
// //                         image: DecorationImage(
// //                             fit: BoxFit.cover,
// //                             colorFilter: new ColorFilter.mode(
// //                                 Colors.white.withOpacity(0.6),
// //                                 BlendMode.dstATop),
// //                             image: CachedNetworkImageProvider(
// //                                 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${cidade.photos[0].photoReference}&key=$kGoogleApiKey'))),
// //                   )
// //                 ]));
// //   }
// //   // Future<void> _goToTheLake() async {
// //   //   final GoogleMapController controller = await _controller.future;
// //   //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// //   // }
// }
