import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nice_travel/integration/json/serializers.dart';
import 'package:nice_travel/model/ScheduleDay.dart';

part 'ScheduleDayJson.g.dart';

abstract class ScheduleDayJson
    implements Built<ScheduleDayJson, ScheduleDayJsonBuilder> {
  static Serializer<ScheduleDayJson> get serializer =>
      _$scheduleDayJsonSerializer;

  @nullable
  double get priceDay;

  @nullable
  int get day;

  @nullable
  int get id;

  @nullable
  int get qtdActivities;

  @nullable
  String get typeFirstActivity;

  ScheduleDayJson._();

  factory ScheduleDayJson([updates(ScheduleDayJsonBuilder b)]) =
      _$ScheduleDayJson;

  ScheduleDay parseScheduleDayJsonToSchedule(String jsonToSchule) {
    final parsed = json.jsonDecode(jsonToSchule);

    return ScheduleDay(standardSerializers.deserializeWith(
        ScheduleDayJson.serializer, parsed));
  }

  List<ScheduleDay> parseScheduleDayJsonToSchedules(String jsonToSchule) {
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
