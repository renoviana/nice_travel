import 'package:nice_travel/model/placesDetails.dart';

class Trip {
  final Result city;
  final String dias;
  final int numberOfDays;
  Trip(this.city, this.numberOfDays, this.dias);

  Trip.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : city = Result.fromJson(snapshot['city']),
        dias = snapshot['dias'],
        numberOfDays = snapshot['numberOfDays'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city.toJson();
    data['dias'] = this.dias;
    data['numberOfDays'] = this.numberOfDays;
    return data;
  }
}

class DayActivities {
  final List<Activities> lista;

  DayActivities(this.lista);
}

class Activities {
  final String name;
  final String hora;

  Activities(this.name, this.hora);
}
