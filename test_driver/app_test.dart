
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

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


//  group('Test Replicate Schedule', () {
//    test('show Schedule List', () async {
//      await showScheduleList(driver);
//      sleepEndTest(duration: 1);
//    });
//
//    test('duplicate Schedule Day', () async {
//      await duplicateScheduleDay(driver);
//      sleepEndTest(duration: 1);
//    });
//
//    test('remove Schedule Day', () async {
//      await removeScheduleDay(driver);
//    });
//    sleepEndTest(duration: 2);
//  });

  group('Test new Schedule Day', () {
    test('go to my Schedule day', () async {
      await goToMyScheduleDay(driver);
      sleepEndTest();
    });

//    test('create new Schedule Day', () async {
//      await testNewScheduleDay(driver);
//      sleepEndTest();
//    });

    test('go to Schedule Day Detail', () async {
      await goToScheduleDayDetail(driver);
      sleepEndTest();
    });

    test('go to Activity Timeline', () async {
      await goToActivityDay(driver);
      sleepEndTest();
    });

    test('create Activity Timeline', () async {
      await createNewActivity(driver);
      sleepEndTest(duration: 3);
    });
  });
}



