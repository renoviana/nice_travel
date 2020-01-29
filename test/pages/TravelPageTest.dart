import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nice_travel/pages/travel/TravelPage.dart';
import 'package:nice_travel/pages/travel/card/ScheduleCard.dart';
import 'package:nice_travel/pages/travel/list/ScheduleList.dart';

void main() {

  testWidgets('Test TravelPage Components', (WidgetTester tester) async {
    Widget testWidget = new MaterialApp(home: new TravelPage());
    await tester.pumpWidget(testWidget);

    expect(find.byType(ScheduleCard), findsOneWidget);
    expect(find.byType(ScheduleList), findsOneWidget);
  });

}
