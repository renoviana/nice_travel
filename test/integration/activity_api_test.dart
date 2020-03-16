// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nice_travel/integration/json/ActivityJson.dart';

void main() {
  test('Test parse Json to Activities', () async {
    var json = '[{"description":"cdd",'
        '"nameOfPlace":"bdjsjdjd",'
        '"price":9.99,'
        '"startActivity":"00:00:00",'
        '"finishActivity":"00:00:00",'
        '"styleActivity":"Other",'
        '"idScheduleDay":148,'
        '"id":54},'
        '{"description":"teste",'
        '"nameOfPlace":"aaaa",'
        '"price":9.994,'
        '"startActivity":"12:00:00",'
        '"finishActivity":"13:00:00",'
        '"styleActivity":"Other",'
        '"idScheduleDay":141,'
        '"id":54}'
        ']';

    var activities = ActivityJson().parseActivityJsonToActivities(json);

    expect(activities.length, 2);
    expect(activities[0], isNot(activities[1]));
  });

  test('Test parse Json to Activity', () async {
    var json = '{'
        '"description":"cdd",'
        '"nameOfPlace":"bdjsjdjd",'
        '"price":9.99,'
        '"startActivity":"00:00:00",'
        '"finishActivity":"10:00:00",'
        '"styleActivity":"Other",'
        '"idScheduleDay":148 }';

    var activity = ActivityJson().parseActivityJsonToActivity(json);

    expect(activity.description, "cdd");
    expect(activity.nameOfPlace, "bdjsjdjd");
    expect(activity.price, 9.99);
    expect(activity.startActivityDate.hour, 00);
    expect(activity.finishActivityDate.hour, 10);
    expect(activity.styleActivity, "Other");
    expect(activity.idScheduleDay, 148);
  });
}
