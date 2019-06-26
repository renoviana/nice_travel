import 'package:rxdart/subjects.dart';

class AutoCompleteBloc {
  Stream<bool> get getCityInputStatus => _isCityInputNull.stream;
  Sink<bool> get setCityInputStatus => _isCityInputNull.sink;

  final _isCityInputNull = BehaviorSubject<bool>.seeded(true);
}

var autoCompleteBloc = new AutoCompleteBloc();
