import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nice_travel/integration/serializers.dart';
import 'package:nice_travel/model/Schedule.dart';

part 'ScheduleJson.g.dart';

abstract class ScheduleJson
    implements Built<ScheduleJson, ScheduleJsonBuilder> {
  static Serializer<ScheduleJson> get serializer => _$scheduleJsonSerializer;

  int get scheduleCod;

  int get qtdDays;

  String get imageUrl;

// BuiltList<int> get scheduleDay;
  String get nameCity;

  double get priceFinal;

  ScheduleJson._();

  factory ScheduleJson([updates(ScheduleJsonBuilder b)]) = _$ScheduleJson;

  List<Schedule> parseScheduleJsonToSchedule(String jsonToSchule) {
    final parsed = json.jsonDecode(jsonToSchule);

    List<Schedule> schedules = new List();
    for(var scheduleJson in parsed){
      var deserializeWith = standardSerializers.deserializeWith(ScheduleJson.serializer, scheduleJson);
      schedules.add(Schedule(deserializeWith));
    }
    return schedules;
  }
}
