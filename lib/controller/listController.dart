import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:nice_travel/model/Trip.dart';

class ListController implements BlocBase {
  static List<Trip> tripteste = [
    new Trip('Salvador', 10, [
      DayActivities([
        Activities('Pelourinho', '12:00'),
        Activities('Mercado Modelo', '12:30')
      ]),
      DayActivities([Activities('Pelourinho', '12:00')]),
      DayActivities([Activities('Pelourinho', '12:00')]),
      DayActivities([Activities('Pelourinho', '12:00')]),
      DayActivities([Activities('Pelourinho', '12:00')]),
      DayActivities([Activities('Pelourinho', '12:00')]),
    ])
  ];

  var _listController = BehaviorSubject<List<Trip>>(seedValue: tripteste);

  Stream<List<Trip>> get outList => _listController.stream;
  Sink<List<Trip>> get inList => _listController.sink;

  void addList() {
    _listController.add(_listController.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
