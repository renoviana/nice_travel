// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nice_travel/integration/ScheduleDayApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';

void main() {
  test('Test get schedule Day by Schedule cod', () async {
    List<ScheduleDay> schedulesDays =
    await ScheduleDayApiConnection.instance.getScheduleDayByCodSchedule(1);
    expect(true, schedulesDays.first.priceDay > 1);
    expect(true, schedulesDays.first.day == 1);
  });
}
