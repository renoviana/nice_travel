import 'package:nice_travel/integration/ScheduleJson.dart';

class Schedule {
  List<ScheduleDay> scheduleDay;
  int qtdDays;
  String imageUrl;
  String nameCity;
  double priceFinal;

  Schedule(ScheduleJson scheduleJson){
    this.qtdDays = scheduleJson.qtdDays;
    this.imageUrl = scheduleJson.imageUrl;
    this.nameCity = scheduleJson.nameCity;
    this.priceFinal = scheduleJson.priceFinal;
    this.scheduleDay = null;
  }

}

class ScheduleDay {
  final List<Activities> activities;
  final int day;
  final double priceDay;

  ScheduleDay(this.activities, this.day, this.priceDay);
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
