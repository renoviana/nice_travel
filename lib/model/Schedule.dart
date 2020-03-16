import 'package:mobx/mobx.dart';
import 'package:nice_travel/integration/json/ScheduleJson.dart';

part 'Schedule.g.dart';

class Schedule = ScheduleBase with _$Schedule;

abstract class ScheduleBase with Store {
  int scheduleCod;
  int qtdDays;
  List<String> imagesUrl = [];
  String cityAddress;

  @observable
  double priceFinal;
  String userName;
  String userUID;
  int numberStar;
  bool isPublish;

  @action
  updatePrice(priceFinalUpdated){
    this.priceFinal = priceFinalUpdated;
  }
  ScheduleBase.newInstance() {
    this.qtdDays = 1;
  }

  get firstImage => imagesUrl != null ? imagesUrl.first : '';

  ScheduleBase(ScheduleJson scheduleJson) {
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

