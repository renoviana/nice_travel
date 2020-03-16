import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'test_copy_schedule.dart';
import 'test_create_schedule.dart';
import 'test_util.dart';

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

  group('Test Replicate Schedule -> ', () {
    test('show Schedule List', () async {
      await showScheduleList(driver);
      sleepEndTest();
    });

    test('duplicate Schedule', () async {
      await duplicateScheduleDay(driver);
      sleepEndTest();
    });

    test('remove Schedule ', () async {
      await removeSchedule(driver);
      sleepEndTest();
    });

    sleepEndTest(duration: 2);
  });

  group('Test new Schedule -> ', () {
    test('go to my Schedule List ', () async {
      await goToMySchedule(driver);
      sleepEndTest();
    });

    test('create new Schedule', () async {
      await testNewSchedule(driver);
      sleepEndTest();
    });

    test('go to Schedule Detail', () async {
      await goToScheduleDetail(driver);
      sleepEndTest();
    });

    test('publish Schedule', () async {
      await publishSchedule(driver);
      sleepEndTest();
    });

    test('go back schedule List', () async {
      await goBackScheduleList(driver);
      sleepEndTest();
    });

    sleepEndTest(duration: 3);

  });

  group('Test new Schedule Day -> ', () {
    test('go to my Schedule', () async {
      await goToMySchedule(driver);
      sleepEndTest();
    });

    test('go to Schedule Detail', () async {
      await goToScheduleDetail(driver);
      sleepEndTest();
    });

    test('create new Schedule Day', () async {
      await addNewScheduleDay(driver);
      sleepEndTest();
    });

    test('go back Schedule Day', () async {
      await goBackScheduleDay(driver);
      sleepEndTest();
    });

    test('go back schedule List', () async {
      await goBackScheduleList(driver);
      sleepEndTest();
    });


    sleepEndTest(duration: 3);

  });

  group('Test new Activity -> ', () {
    test('go to my Schedule', () async {
      await goToMySchedule(driver);
      sleepEndTest();
    });

    test('go to Schedule Day Detail', () async {
      await goToScheduleDetail(driver);
      sleepEndTest();
    });

    test('go to Activity Timeline', () async {
      await goToActivityDay(driver);
      sleepEndTest();
    });

    test('create Activity Timeline', () async {
      await createNewActivity(driver);
    });
    sleepEndTest(duration: 3);

  });

  group('Delete all -> ', () {

    test('delete Activity', () async {
      await deleteActivityByName(driver, "Café da manhã");
      sleepEndTest();
    });

    test('go back Schedule Day', () async {
      await goBackScheduleDay(driver);
      sleepEndTest();
    });

    test('remove Schedule Day', () async {
      await removeScheduleDay(driver);
      sleepEndTest();
    });

    test('remove Schedule', () async {
      await removeSchedule(driver);
      sleepEndTest();
    });

    sleepEndTest(duration: 3);
  });
}
