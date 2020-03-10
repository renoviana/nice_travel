import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nice_travel/app_module.dart';
import 'package:nice_travel/module/travel/travel_page.dart';
import 'package:nice_travel/module/travel/widget/card/schedule_card.dart';
import 'package:nice_travel/module/travel/widget/list/schedule_list.dart';
void main() {

  setUpAll(() {
    Modular.init(AppModule());
  });

  testWidgets('Test TravelPage Components', (WidgetTester tester) async {
    Widget testWidget = new MaterialApp(home: new TravelPage());
    await tester.pumpWidget(testWidget);

    expect(find.byType(ScheduleCard), findsOneWidget);
    expect(find.byType(ScheduleList), findsOneWidget);
  });

}
