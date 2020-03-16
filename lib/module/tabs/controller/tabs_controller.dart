import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';

part 'tabs_controller.g.dart';

class TabsController = _TabsControllerBase with _$TabsController;

abstract class _TabsControllerBase extends PageController with Store {
  initializeSchedules() {
    listScheduleBloc.loadSchedules(null);
  }
}
