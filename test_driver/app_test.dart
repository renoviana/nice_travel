import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

//  testReplicateSchedule(driver);


  group('Test new Schedule Day', () {
    test('new Schedule Day', () async {
      final menuButton = find.byValueKey("menu_button");
      final cronogramasButton = find.byValueKey("DrawerTile_1");
      final newScheduleButton = find.byValueKey("new_schedule_button");
      final scheduleNameField = find.byValueKey("new_schedule_name_field");
      final autocompleteField = find.byValueKey("autocomplete_field_07fd9f6c6674a7c95962aa56a701da7cb752f98b");
      final dayField = find.byValueKey("new_schedule_day_field");
      final saveNewSchedule = find.byValueKey("save_new_schedule");


      await tapWithDelay(driver, menuButton );
      await tapWithDelay(driver, cronogramasButton );
      await tapWithDelay(driver, newScheduleButton );
      await enterText(driver, scheduleNameField, "Salvador");
      await tapWithDelay(driver, autocompleteField );
      await enterText(driver, dayField, "3");
      await tapWithDelay(driver, saveNewSchedule );
      sleep(const Duration(seconds: 5));
    });
  });
}

Future enterText(FlutterDriver driver, SerializableFinder scheduleNameField, String text) async {
  await tapWithDelay(driver, scheduleNameField);
  driver.enterText(text);
  sleep(const Duration(seconds: 2));
}

Future testReplicateSchedule(FlutterDriver driver) async {
  group('Test Replicate Schedule', () {
    test('show Schedule List', () async {
      final scheduleList = find.byType("ScheduleList");
      final cityScheduleItem = find.text("Cocos, BA, 47680-000, Brazil");
      await verifyIfPresent(driver, scheduleList);
      await tapWithDelay(driver, cityScheduleItem);
    });

    test('duplicate Schedule Day', () async {
      final daySchedulePage = find.byType("DaySchedulePage");
      final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
      final addDayButton = find.byValueKey("add_schedule_day");
      final adicionarButton = find.byValueKey("adicionar_snackbar");

      await verifyIfPresent(driver, daySchedulePage);
      await verifyIfPresent(driver, buttonBarScheduleDay);

      await tapWithDelay(driver, addDayButton);
      await tapWithDelay(driver, adicionarButton);
    });

    test('remove Schedule Day', () async {
      final daySchedulePage = find.byType("DaySchedulePage");
      final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
      final removeButton = find.byValueKey("remover_schedule_day");
      final removerModalButton = find.text("OK");

      await verifyIfPresent(driver, daySchedulePage);
      await verifyIfPresent(driver, buttonBarScheduleDay);

      await tapWithDelay(driver, removeButton);
      await tapWithDelay(driver, removerModalButton);
    });
  });
}

isPresent(SerializableFinder finder, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 2)}) async {
  try {
    await driver.waitFor(finder, timeout: timeout);
    return true;
  } catch (exception) {
    print('Erro ao buscar o elemento: ${finder.finderType}');
    return false;
  }
}

Future verifyIfPresent(
    FlutterDriver driver, SerializableFinder scheduleList) async {
  expect(await isPresent(scheduleList, driver), isTrue);
}

tapWithDelay(FlutterDriver driver, SerializableFinder button) async {
  expect(await isPresent(button, driver), isTrue);
  await driver.tap(button);
  sleep(const Duration(seconds: 1));
}
