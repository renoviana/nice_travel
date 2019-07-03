// import 'package:firebase_database/firebase_database.dart';

// import 'package:nice_travel/model/Trip.dart';

// class FirebaseInstance {
//   DatabaseReference _ref =
//       new FirebaseDatabase(databaseURL: 'https://flutter-6f091.firebaseio.com/')
//           .reference()
//           .child('nicetravel');

//   // Future<List<Trip>> getTrips() async {
//   //   List<Trip> list = [];
//   //   final response = await _ref.child('trip').once();
//   //   if (response.value != null) {
//   //     Map<dynamic, dynamic> results = response.value;
//   //     results.forEach((index, values) {
//   //       list.add(Trip.fromSnapshot(values));
//   //     });
//   //   }
//   //   return list;
//   // }

//   // setTrip(Trip trip) {
//   //   _ref.child('trip').push().set(trip.toJson()).then((onValue) {});
//   // }
// }
