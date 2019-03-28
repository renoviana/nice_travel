// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {

  test('Test get schedule by city name', () async {
    final url = "http://localhost:8080/schedule/city?cityName=Salvador";
    final response = await http.get(url);
    expect(response.statusCode, 200);
    final jsonString = response.body;
    String salvador = "Salvador";
    expect(true, jsonString.contains(salvador));
  });

  test('Test create schedule ', () async {
    final url = "http://localhost:8080/schedule?placeID=ChIJrTLr-GyuEmsRBfy61i59si0&numberDays=2";
    final response = await http.post(url);
    expect(response.statusCode, 200);
    final jsonString = response.body;
    String mockReturn = '{"qtdDays":2,"scheduleDay":null,"imageUrl":"https://s3.amazonaws.com/bk-static-prd-newctn/files/styles/discover_destaque/s3/2016-12/42%20-%20Salvador%20de%20Bahia_4.jpg?itok=2NW2cjVV","nameCity":"ChIJrTLr-GyuEmsRBfy61i59si0","scheduleCod":1,"priceFinal":0}';
    expect(mockReturn, jsonString);
  });

  test('Test publish schedule ', () async {
    final url = "http://localhost:8080/schedule/publish?travelId=1";
    final response = await http.post(url);
    expect(response.statusCode, 200);
    final jsonString = response.body;
    expect("true", jsonString);
  });
}
