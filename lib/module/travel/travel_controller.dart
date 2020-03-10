
import 'package:mobx/mobx.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';

part 'travel_controller.g.dart';

class TravelController = _TravelControllerBase with _$TravelController;
abstract class _TravelControllerBase with Store {

  initializeSchedules(){
    listScheduleBloc.loadSchedules(null);
  }
}