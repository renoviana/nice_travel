
import 'package:flutter_driver/flutter_driver.dart';

import 'test_util.dart';

Future showScheduleList(FlutterDriver driver) async {
  final scheduleList = find.byType("ScheduleList");
  final cityScheduleItem = find.text("Cocos, BA, 47680-000, Brazil");
  await verifyIfPresent(driver, scheduleList);
  await tapWithDelay(driver, cityScheduleItem);
}

Future duplicateScheduleDay(FlutterDriver driver) async {
  final daySchedulePage = find.byType("DaySchedulePage");
  final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
  final addDayButton = find.byValueKey("add_schedule_day");
  final adicionarButton = find.byValueKey("adicionar_snackbar");

  await verifyIfPresent(driver, daySchedulePage);
  await verifyIfPresent(driver, buttonBarScheduleDay);

  await tapWithDelay(driver, addDayButton);
  await tapWithDelay(driver, adicionarButton);
}

Future removeScheduleDay(FlutterDriver driver) async {
  final daySchedulePage = find.byType("DaySchedulePage");
  final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
  final removeButton = find.byValueKey("remover_schedule_day");
  final removerModalButton = find.text("OK");

  await verifyIfPresent(driver, daySchedulePage);
  await verifyIfPresent(driver, buttonBarScheduleDay);

  await tapWithDelay(driver, removeButton);
  await tapWithDelay(driver, removerModalButton);
}
