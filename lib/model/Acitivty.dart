
import 'package:nice_travel/integration/json/ActivityJson.dart';
import 'package:nice_travel/util/format_util.dart';

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