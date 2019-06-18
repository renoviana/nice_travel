// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nice_travel/integration/ApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';

void main() {
  test('Test get schedule by city name', () async {
    var apiConnection = new ApiConnection();
    List<Schedule> schedules = await apiConnection.getScheduleByCityName("Salvador", 1);
    String salvador = "Salvador";
    expect(schedules.first.nameCity, salvador);
  });

  test('Test get schedule Day by Schedule cod', () async {
    var apiConnection = new ApiConnection();
    List<ScheduleDay> schedulesDays = await apiConnection.getScheduleDayByCodSchedule(1);
    expect(true, schedulesDays.first.priceDay > 1);
    expect(true, schedulesDays.first.day == 1);
  });

  test('Test create schedule ', () async {
    final response = await ApiConnection().createSchedule("ChIJrTLr-GyuEmsRBfy61i59si0", 2);
    expect(response.statusCode, 200);
    final jsonString = response.body;
    String mockReturn = """{"qtdDays":2,"imageUrl":"https://s3.amazonaws.com/bk-static-prd-newctn/files/styles/discover_destaque/s3/2016-12/42%20-%20Salvador%20de%20Bahia_4.jpg?itok=2NW2cjVV","nameCity":"ChIJrTLr-GyuEmsRBfy61i59si0","scheduleCod":1,"priceFinal":null}""";
    expect(mockReturn, jsonString);
  });

  test('Test publish schedule ', () async {
    final response = await ApiConnection().publishSchedule(1);
    expect(response.statusCode, 200);
    final jsonString = response.body;
    expect("true", jsonString);
  });
}