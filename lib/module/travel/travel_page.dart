import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nice_travel/module/travel/controller/travel_controller.dart';
import 'package:nice_travel/module/travel/widget/card/schedule_card.dart';
import 'package:nice_travel/module/travel/widget/list/schedule_list.dart';

class TravelPage extends StatelessWidget {
  final travelController = Modular.get<TravelController>();

  TravelPage() {
    travelController.initializeSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            ScheduleCard(),
            ScheduleList(),
          ],
        ),
      ),
    );
  }
}
