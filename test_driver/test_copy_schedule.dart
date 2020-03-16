
import 'package:flutter_driver/flutter_driver.dart';

import 'test_util.dart';

Future showScheduleList(FlutterDriver driver) async {
  final scheduleList = find.byType("ScheduleList");
  final cityScheduleItem = find.text("Cocos, BA, 47680-000, Brazil");
  await verifyIfPresent(driver, scheduleList);
  await tapWithDelay(driver, cityScheduleItem);
}

Future duplicateScheduleDay(FlutterDriver driver) async {
  await addNewScheduleDay(driver);
  final adicionarButton = find.byValueKey("adicionar_snackbar");
  await tapWithDelay(driver, adicionarButton);
}

Future addNewScheduleDay(FlutterDriver driver) async {
  final daySchedulePage = find.byType("DaySchedulePage");
  final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
  final addDayButton = find.byValueKey("add_schedule_day");

  await verifyIfPresent(driver, daySchedulePage);
  await verifyIfPresent(driver, buttonBarScheduleDay);

  await tapWithDelay(driver, addDayButton);
}

Future goBackScheduleList(FlutterDriver driver) async {
  final backButton = find.byValueKey("schedule_back_button_3");

  await tapWithDelay(driver, backButton, timeout: Duration(seconds: 6));
}


Future goBackScheduleDay(FlutterDriver driver) async {
  final backButton = find.byValueKey("activity_timeline_back_button");
  await tapWithDelay(driver, backButton);
}


Future removeSchedule(FlutterDriver driver) async {
  final daySchedulePage = find.byType("DaySchedulePage");
  final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
  final removeButton = find.byValueKey("remover_schedule");
  final removerModalButton = find.text("OK");
  final title = find.text("Deseja remover esse cronograma?");

  await verifyIfPresent(driver, daySchedulePage);
  await verifyIfPresent(driver, buttonBarScheduleDay);

  await tapWithDelay(driver, removeButton);
  await verifyIfPresent(driver, title);
  await tapWithDelay(driver, removerModalButton);
}

Future removeScheduleDay(FlutterDriver driver) async {
  final daySchedulePage = find.byType("DaySchedulePage");
  final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
  final removeButton = find.byValueKey("remover_schedule_day_1");
  final removerModalButton = find.text("OK");
  final title = find.text("Deseja remover o dia 1?");
  await verifyIfPresent(driver, daySchedulePage);
  await verifyIfPresent(driver, buttonBarScheduleDay);

  await tapWithDelay(driver, removeButton);
  await verifyIfPresent(driver, title);
  await tapWithDelay(driver, removerModalButton);
}
