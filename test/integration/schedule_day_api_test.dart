// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';

void main() {

  test('Test parse Json to ScheduleDays', () async {
    var json = '[{"id":148,'
        '"day":1,'
        '"priceDay":9.99,'
        '"qtdActivities":1,'
        '"typeFirstActivity":"Other"},'
        '{"id":152,'
        '"day":2,'
        '"priceDay":0,'
        '"qtdActivities":0,'
        '"typeFirstActivity":null},'
        '{"id":151,'
        '"day":3,'
        '"priceDay":0,'
        '"qtdActivities":0,'
        '"typeFirstActivity":null'
        '}]';

    var scheduleDays = ScheduleDayJson().parseScheduleDayJsonToSchedules(json);

    expect(scheduleDays.length, 3);
    expect(scheduleDays[0], isNot(scheduleDays[1]));
  });

  test('Test parse Json to ScheduleDay', () async {
    var json = '{"id":148,'
        '"day":1,'
        '"priceDay":9.99,'
        '"qtdActivities":1,'
        '"typeFirstActivity":"Other"}';

    var scheduleDay = ScheduleDayJson().parseScheduleDayJsonToSchedule(json);

    expect(scheduleDay.id ,148);
    expect(scheduleDay.day ,1);
    expect(scheduleDay.priceDay ,9.99);
    expect(scheduleDay.qtdActivities ,1);
    expect(scheduleDay.typeFirstActivity ,"Other");
  });
}
