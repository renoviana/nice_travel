import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nice_travel/integration/json/serializers.dart';
import 'package:nice_travel/model/Schedule.dart';

part 'ScheduleJson.g.dart';

abstract class ScheduleJson
    implements Built<ScheduleJson, ScheduleJsonBuilder> {
  static Serializer<ScheduleJson> get serializer => _$scheduleJsonSerializer;

  @nullable
  int get scheduleCod;

  @nullable
  int get qtdDays;

  @nullable
  String get imageUrl;

  @nullable
  String get cityAddress;

  @nullable
  double get priceFinal;

  @nullable
  String get userUID;

  @nullable
  int get numberStar;

  @nullable
  String get userName;

  @nullable
  bool get publish;

  ScheduleJson._();

  factory ScheduleJson([updates(ScheduleJsonBuilder b)]) = _$ScheduleJson;

  List<Schedule> parseScheduleJsonToSchedules(String jsonToSchule) {
    final parsed = json.jsonDecode(jsonToSchule);

    List<Schedule> schedules = new List();
    for (var scheduleJson in parsed) {
      var deserializeWith = standardSerializers.deserializeWith(
          ScheduleJson.serializer, scheduleJson);
      schedules.add(Schedule(deserializeWith));
    }
    return schedules;
  }

  Schedule parseScheduleJsonToSchedule(String jsonToSchule) {
    final scheduleJson = json.jsonDecode(jsonToSchule);
    var deserializeWith = standardSerializers.deserializeWith(
        ScheduleJson.serializer, scheduleJson);
    return Schedule(deserializeWith);
  }
}
