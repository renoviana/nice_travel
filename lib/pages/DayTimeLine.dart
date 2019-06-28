// import 'package:flutter/material.dart';
// import 'package:nice_travel/model/Trip.dart';

// import 'package:timeline_list/timeline.dart';
// import 'package:timeline_list/timeline_model.dart';

// class DayTimeLine extends StatefulWidget {
//   final Widget child;
//   // final DayActivities activities;
//   DayTimeLine(this.activities, {Key key, this.child}) : super(key: key);

//   _DayTimeLineState createState() => _DayTimeLineState();
// }

// class _DayTimeLineState extends State<DayTimeLine> {
//   List<TimelineModel> items = [];

//   void initState() {
//     super.initState();
//     widget.activities.lista.forEach((value) {
//       items.add(TimelineModel(
//           ListTile(
//             title: Text(value.name),
//             subtitle: Text(value.hora),
//           ),
//           position: TimelineItemPosition.right,
//           iconBackground: Colors.redAccent,
//           icon: Icon(Icons.place)));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dia"),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child:
//                 new Timeline(children: items, position: TimelinePosition.Left),
//           )
//         ],
//       ),
//     );
//   }
// }
