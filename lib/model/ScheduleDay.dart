
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';

class ScheduleDay {
  int day;
  double priceDay;
  int id;
  int qtdActivities;
  String typeFirstActivity;

  ScheduleDay(ScheduleDayJson scheduleDayJson) {
    this.day = scheduleDayJson.day;
    this.priceDay = scheduleDayJson.priceDay;
    this.id = scheduleDayJson.id;
    this.qtdActivities = scheduleDayJson.qtdActivities;
    this.typeFirstActivity = scheduleDayJson.typeFirstActivity;
  }
}
