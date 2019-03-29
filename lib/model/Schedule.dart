import 'package:nice_travel/integration/ScheduleDayJson.dart';
import 'package:nice_travel/integration/ScheduleJson.dart';

class Schedule {
  int qtdDays;
  String imageUrl;
  String nameCity;
  double priceFinal;

  Schedule(ScheduleJson scheduleJson) {
    this.qtdDays = scheduleJson.qtdDays;
    this.imageUrl = scheduleJson.imageUrl;
    this.nameCity = scheduleJson.nameCity;
    this.priceFinal = scheduleJson.priceFinal;
  }
}

class ScheduleDay {
  int day;
  double priceDay;

  ScheduleDay(ScheduleDayJson scheduleDayJson) {
    this.day = scheduleDayJson.day;
    this.priceDay = scheduleDayJson.priceDay;
  }
}

class Activities {
  final String description;
  final String nameOfPlace;
  final double price;
  final DateTime startActivity;
  final DateTime finishActivity;
  final String styleActivity;

  Activities(this.description, this.nameOfPlace, this.price, this.startActivity,
      this.finishActivity, this.styleActivity);
}
