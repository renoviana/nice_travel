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
    print(jsonString);
    String salvador = "Salvador";
    expect(true, jsonString.contains(salvador));
  });
}
