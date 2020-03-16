
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'main.dart';
import 'main_controller.dart';
import 'module/schedule/controller/schedule_controller.dart';
import 'module/tabs/controller/tabs_controller.dart';
import 'module/travel/controller/travel_controller.dart';

class AppModule extends MainModule {

  @override
  List<Bind> get binds => [
    Bind((i) => MainController()),
    Bind((i) => TravelController()),
    Bind((i) => TabsController()),
    Bind((i) => ScheduleController())
  ];

  @override
  Widget get bootstrap => MainPage();

  @override
  List<Router> get routers =>  [
    Router("/", child: (_, args) => MainPage()),
  ];


}