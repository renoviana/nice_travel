import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:nice_travel/integration/json/serializers.dart';
import 'package:nice_travel/model/Schedule.dart';

part 'ActivityJson.g.dart';

abstract class ActivityJson
    implements Built<ActivityJson, ActivityJsonBuilder> {
  static Serializer<ActivityJson> get serializer => _$activityJsonSerializer;

  @nullable
  String get description;

  @nullable
  String get nameOfPlace;

  @nullable
  double get price;

  @nullable
  prefix0.TimeOfDay get startActivity;

  @nullable
  prefix0.TimeOfDay get finishActivity;

  @nullable
  String get styleActivity;

  @nullable
  int get idScheduleDay;

  @nullable
  int get id;

  ActivityJson._();

  factory ActivityJson([updates(ActivityJsonBuilder b)]) = _$ActivityJson;

  Activity parseActivityJsonToActivity(String jsonToSchule) {
    final parsed = json.jsonDecode(jsonToSchule);
    var deserializeWith =
        standardSerializers.deserializeWith(ActivityJson.serializer, parsed);
    return Activity(deserializeWith);
  }

  List<Activity> parseActivityJsonToActivities(String jsonToSchule) {
    final parsed = json.jsonDecode(jsonToSchule);

    List<Activity> activities = new List();
    for (var scheduleJson in parsed) {
      var deserializeWith = standardSerializers.deserializeWith(
          ActivityJson.serializer, scheduleJson);
      activities.add(Activity(deserializeWith));
    }
    return activities;
  }
}
