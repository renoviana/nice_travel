import 'package:nice_travel/integration/json/ActivityJson.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/util/FormatUtil.dart';

class Schedule {
  int scheduleCod;
  int qtdDays;
  String imageUrl;
  String cityAddress;
  double priceFinal;
  String userName;
  String userUID;
  int numberStar;
  bool isPublish;

  Schedule.newInstance(){
    this.qtdDays = 1;
  }

  Schedule(ScheduleJson scheduleJson) {
    this.qtdDays = scheduleJson.qtdDays;
    this.imageUrl = scheduleJson.imageUrl;
    this.cityAddress = scheduleJson.cityAddress;
    this.priceFinal = scheduleJson.priceFinal;
    this.scheduleCod = scheduleJson.scheduleCod;
    this.userName = scheduleJson.userName;
    this.userUID = scheduleJson.userUID;
    this.numberStar = scheduleJson.numberStar;
    this.isPublish = scheduleJson.publish;
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
  String styleActivity;
  DateTime startActivityDate;
  DateTime finishActivityDate;
  int idScheduleDay;
  int id;

  Activity(ActivityJson activityJson) {
    this.description = activityJson.description;
    this.nameOfPlace = activityJson.nameOfPlace;
    this.price = activityJson.price;
    this.startActivityDate = formatarStringToHora(activityJson.startActivity);
    this.finishActivityDate = formatarStringToHora(activityJson.finishActivity);
    this.styleActivity = activityJson.styleActivity;
    this.idScheduleDay = activityJson.idScheduleDay;
    this.id = activityJson.id;
  }

  Activity.newInstance(int idScheduleDay) {
    this.idScheduleDay = idScheduleDay;
    this.price = 0.0;
    this.styleActivity = "OTHER";
    this.startActivityDate = DateTime(1,1,2000);
    this.finishActivityDate = DateTime(1,1,2000);
    this.description = '';
    this.nameOfPlace = '';
  }
}
