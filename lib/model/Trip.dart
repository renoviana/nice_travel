class Trip {
  final String city;
  final List<DayActivities> dias;
  final int numberOfDays;
  Trip(this.city, this.numberOfDays, this.dias);
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
