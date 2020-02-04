import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  isPresent(SerializableFinder byValueKey, FlutterDriver driver,
      {Duration timeout = const Duration(seconds: 1)}) async {
    try {
      await driver.waitFor(byValueKey, timeout: timeout);
      return true;
    } catch (exception) {
      return false;
    }
  }

  group('Test Replicate Schedule', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    FlutterDriver driver;


    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      driver.requestData("UserModel.newInstance");
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('show Schedule List', () async {
      final scheduleList = find.byType("ScheduleList");
      final cityScheduleItem = find.text("Cocos, BA, 47680-000, Brazil");
      expect(await isPresent(scheduleList, driver), isTrue);
      await tapWithDelay(driver, cityScheduleItem);
    });

    test('duplicate Schedule Day', () async {
      final daySchedulePage = find.byType("DaySchedulePage");
      final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
      final addDayButton = find.byValueKey("add_schedule_day");
      final adicionarButton = find.byValueKey("adicionar_snackbar");

      expect(await isPresent(daySchedulePage, driver), isTrue);
      expect(await isPresent(buttonBarScheduleDay, driver), isTrue);

      await tapWithDelay(driver, addDayButton);
      await tapWithDelay(driver, adicionarButton);
    });

    test('remove Schedule Day', () async {
      final daySchedulePage = find.byType("DaySchedulePage");
      final buttonBarScheduleDay = find.byType("ButtonBarScheduleDay");
      final removeButton = find.byValueKey("remover_schedule_day");
      final removerModalButton = find.text("OK");

      expect(await isPresent(daySchedulePage, driver), isTrue);
      expect(await isPresent(buttonBarScheduleDay, driver), isTrue);

      await tapWithDelay(driver, removeButton);
      driver.waitFor(removerModalButton);
      await tapWithDelay(driver, removerModalButton);
    });

  });
}

tapWithDelay(FlutterDriver driver, SerializableFinder button) async {
  driver.waitFor(button);
  await driver.tap(button);
  sleep(const Duration(seconds: 1));
}
