// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';

void main() {
  test('Test parse Json to Schedules', () async {

    var json = '['
        '{"qtdDays":3,'
        '"imagesUrl":["https://maps.googleapis.com/maps/api/place/photo?maxwidth=700&photoreference=CmRaAAAApZaFWraXjWYszVV4FFasUKauO3pcBJ_7d7OnzX_yeH8Fsi_yplT9Uh6IFUeY4HyvHfW_pp_MgSUAX9NgdiO0jZl4fEn52HdAuJ_Ccakbtg2FYEYdmQBcdSY-uXPMmvjnEhDYTQ73KBSQo6GMVCgtb1VHGhR1dQqEAGax5cpEsZHOIdEmQqg5Ig&key=AIzaSyC9b4oUjYYnSj5jLqdUidl4Wdy1cEskoJI"],'
        '"cityAddress":"Cocos, BA, 47680-000, Brazil",'
        '"scheduleCod":26,'
        '"priceFinal":9.99,'
        '"userUID":"123456",'
        '"userName": "Thiago",'
        '"numberStar":1,'
        '"publish":true},'
        '{"qtdDays":5,'
        '"imagesUrl":["https://maps.googleapis.com/maps/api/place/photo?maxwidth=700&photoreference=CmRaAAAApZaFWraXjWYszVV4FFasUKauO3pcBJ_7d7OnzX_yeH8Fsi_yplT9Uh6IFUeY4HyvHfW_pp_MgSUAX9NgdiO0jZl4fEn52HdAuJ_Ccakbtg2FYEYdmQBcdSY-uXPMmvjnEhDYTQ73KBSQo6GMVCgtb1VHGhR1dQqEAGax5cpEsZHOIdEmQqg5Ig&key=AIzaSyC9b4oUjYYnSj5jLqdUidl4Wdy1cEskoJI"],'
        '"cityAddress":"Cocos, BA, 47680-000, Brazil",'
        '"scheduleCod":27,'
        '"priceFinal":10.99,'
        '"userUID":"123456",'
        '"userName": "Thiago",'
        '"numberStar":1,'
        '"publish":true}'
        ''
        ']';
    var scheduleList = ScheduleJson().parseScheduleJsonToSchedules(json);

    expect(scheduleList.length, 2);
    expect(scheduleList[0], isNot(scheduleList[1]));
  });

  test('Test parse Json to Schedule', () async {
    var json = '{"qtdDays":3,'
        '"imagesUrl":["https://maps.googleapis.com/maps/api/place/photo?maxwidth=700&photoreference=CmRaAAAApZaFWraXjWYszVV4FFasUKauO3pcBJ_7d7OnzX_yeH8Fsi_yplT9Uh6IFUeY4HyvHfW_pp_MgSUAX9NgdiO0jZl4fEn52HdAuJ_Ccakbtg2FYEYdmQBcdSY-uXPMmvjnEhDYTQ73KBSQo6GMVCgtb1VHGhR1dQqEAGax5cpEsZHOIdEmQqg5Ig&key=AIzaSyC9b4oUjYYnSj5jLqdUidl4Wdy1cEskoJI"],'
        '"cityAddress":"Cocos, BA, 47680-000, Brazil",'
        '"scheduleCod":26,'
        '"priceFinal":9.99,'
        '"userUID":"123456",'
        '"userName": "Thiago",'
        '"numberStar":1,'
        '"publish":true}';
    var schedule = ScheduleJson().parseScheduleJsonToSchedule(json);

    expect(schedule.qtdDays, 3);
    expect(schedule.imagesUrl[0], contains('googleapis'));
    expect(schedule.cityAddress, 'Cocos, BA, 47680-000, Brazil');
    expect(schedule.scheduleCod, 26);
    expect(schedule.priceFinal, 9.99);
    expect(schedule.userUID, '123456');
    expect(schedule.userName, 'Thiago');
    expect(schedule.numberStar, 1);
    expect(schedule.isPublish, true);
  });
}
