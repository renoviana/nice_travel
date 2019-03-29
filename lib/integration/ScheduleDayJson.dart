import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nice_travel/integration/serializers.dart';
import 'package:nice_travel/model/Schedule.dart';

part 'ScheduleDayJson.g.dart';


abstract class ScheduleDayJson implements Built<ScheduleDayJson, ScheduleDayJsonBuilder> {

  static Serializer<ScheduleDayJson> get serializer => _$scheduleDayJsonSerializer;

  @nullable
  double get priceDay;

  @nullable
  int get day;

  ScheduleDayJson._();
  factory ScheduleDayJson([updates(ScheduleDayJsonBuilder b)]) = _$ScheduleDayJson;

  List<ScheduleDay> parseScheduleDayJsonToSchedule(String jsonToSchule) {
    final parsed = json.jsonDecode(jsonToSchule);

    List<ScheduleDay> schedulesDay = new List();
    for (var scheduleJson in parsed) {
      var deserializeWith = standardSerializers.deserializeWith(
          ScheduleDayJson.serializer, scheduleJson);
      schedulesDay.add(ScheduleDay(deserializeWith));
    }
    return schedulesDay;
  }
}


