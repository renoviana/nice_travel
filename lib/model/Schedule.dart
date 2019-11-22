import 'package:nice_travel/integration/json/ActivityJson.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';

class Schedule {
  int scheduleCod;
  int qtdDays;
  String imageUrl;
  String nameCity;
  double priceFinal;

  Schedule(ScheduleJson scheduleJson) {
    this.qtdDays = scheduleJson.qtdDays;
    this.imageUrl = scheduleJson.imageUrl;
    this.nameCity = scheduleJson.nameCity;
    this.priceFinal = scheduleJson.priceFinal;
    this.scheduleCod = scheduleJson.scheduleCod;
  }
}

class ScheduleDay {
  int day;
  double priceDay;
  int id;

  ScheduleDay(ScheduleDayJson scheduleDayJson) {
    this.day = scheduleDayJson.day;
    this.priceDay = scheduleDayJson.priceDay;
    this.id = scheduleDayJson.id;
  }
}

class Activity {
  String description;
  String nameOfPlace;
  double price;
  String startActivity;
  String finishActivity;
  String styleActivity;
  int idScheduleDay;
  int id;

  Activity(ActivityJson activityJson) {
    this.description = activityJson.description;
    this.nameOfPlace = activityJson.nameOfPlace;
    this.price = activityJson.price;
    this.startActivity = activityJson.startActivity;
    this.finishActivity = activityJson.finishActivity;
    this.styleActivity = activityJson.styleActivity;
    this.idScheduleDay = activityJson.idScheduleDay;
    this.id = activityJson.id;
  }

}
