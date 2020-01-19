import 'package:nice_travel/integration/json/ActivityJson.dart';
import 'package:nice_travel/integration/json/ScheduleDayJson.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';
import 'package:nice_travel/util/FormatUtil.dart';

class Schedule {
  int scheduleCod;
  int qtdDays;
  List<String> imagesUrl = [];
  String cityAddress;
  double priceFinal;
  String userName;
  String userUID;
  int numberStar;
  bool isPublish;

  Schedule.newInstance() {
    this.qtdDays = 1;
  }

  get firstImage => imagesUrl != null ? imagesUrl.first : '';

  Schedule(ScheduleJson scheduleJson) {
    this.qtdDays = scheduleJson.qtdDays;
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
    this.startActivityDate = DateTime(1, 1, 2000);
    this.finishActivityDate = DateTime(1, 1, 2000);
    this.description = '';
    this.nameOfPlace = '';
  }
}
