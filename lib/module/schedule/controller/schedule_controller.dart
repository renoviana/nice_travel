import 'package:mobx/mobx.dart';
import 'package:nice_travel/controller/schedule/MyListScheduleBloc.dart';
import 'package:nice_travel/model/UserModel.dart';

part 'schedule_controller.g.dart';

class ScheduleController = _ScheduleControllerBase with _$ScheduleController;

abstract class _ScheduleControllerBase with Store {

  UserModel _model;
  initializeMySchedules() {
    if (_model.isLoggedIn()) {
      myListScheduleBloc.loadSchedules(_model.sessionUser.uid);
    } else {
      myListScheduleBloc.clearList();
    }
  }

  configUserModel(UserModel model){
    _model = model;
    model.signInSilently();
  }
}
