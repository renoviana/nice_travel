import 'package:flutter_driver/flutter_driver.dart';

import 'test_util.dart';

Future goToMyScheduleDay(FlutterDriver driver) async {
  final menuButton = find.byValueKey("menu_button");
  final cronogramasButton = find.byValueKey("DrawerTile_1");
  await tapWithDelay(driver, menuButton);
  await tapWithDelay(driver, cronogramasButton);
  sleepEndTest();
}

Future testNewScheduleDay(FlutterDriver driver) async {
  final newScheduleButton = find.byValueKey("new_schedule_button");
  final scheduleNameField = find.byValueKey("new_schedule_name_field");
  final autocompleteField = find.byValueKey(
      "autocomplete_field_07fd9f6c6674a7c95962aa56a701da7cb752f98b");
  final dayField = find.byValueKey("new_schedule_day_field");
  final saveNewSchedule = find.byValueKey("save_new_schedule");

  await tapWithDelay(driver, newScheduleButton);
  await enterText(driver, scheduleNameField, "Salvador");
  await tapWithDelay(driver, autocompleteField);
  await enterText(driver, dayField, "3");
  await tapWithDelay(driver, saveNewSchedule);
}

Future goToActivityDay(FlutterDriver driver) async {
  final daySchedulePage = find.byType("DaySchedulePage");
  final dayDetails = find.byValueKey("day_details_1");

  await verifyIfPresent(driver, daySchedulePage);
  await tapWithDelay(driver, dayDetails);
}

Future goToScheduleDayDetail(FlutterDriver driver) async {
  final myScheduleList = find.byValueKey("my_schedule_list");
  final cityScheduleItem = find.text("Salvador, State of Bahia, Brazil");

  await verifyIfPresent(driver, myScheduleList);
  await driver.scrollUntilVisible(myScheduleList, cityScheduleItem,
      dyScroll: -400.0);
  await tapWithDelay(driver, cityScheduleItem);
}

Future createNewActivity(FlutterDriver driver) async {
  final newActivityButton = find.byValueKey("new_activity");
  final activityNameText = find.byValueKey("activity_name_text");
  final priceText = find.byValueKey("price_text");
  final dateEndText = find.byValueKey("date_end_text");
  final dateStartText = find.byValueKey("date_start_text");
  final okDate = find.text("OK");
  final styleDropdown = find.byValueKey("style_dropdown");
  final restauranteSelect = find.text("Restaurante");
  final descriptionText = find.byValueKey("description_text");
  final saveActivityButton = find.byValueKey("save_activity_button");

  await tapWithDelay(driver, newActivityButton);
  await enterText(driver, activityNameText, "Café da manhã");
  await enterText(driver, priceText, "30.0");
  await tapWithDelay(driver, dateEndText);
  await tapWithDelay(driver, okDate);
  await tapWithDelay(driver, dateStartText);
  await tapWithDelay(driver, okDate);
  await tapWithDelay(driver, styleDropdown);
  await tapWithDelay(driver, restauranteSelect);
  await enterText(driver, descriptionText, "Café da manhã no hotel.");
  await tapWithDelay(driver, saveActivityButton);
}

Future deleteActivityByName(FlutterDriver driver, String nameActivity) async {
  final activity = find.text(nameActivity);
  await tapWithDelay(driver, activity);

  final activityScroll = find.byValueKey("new_acitivy_scroll");
  final deleteActivityButton = find.byValueKey("delete_activity_button");
  await driver.scrollUntilVisible(activityScroll, deleteActivityButton,
      dyScroll: -400.0);
  final removerModalButton = find.text("OK");
  await tapWithDelay(driver, deleteActivityButton);
  await tapWithDelay(driver, removerModalButton);
}
