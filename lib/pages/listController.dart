import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ListController implements BlocBase {
  var _listController = BehaviorSubject<List<String>>.seeded(['Teste']);

  Stream<List<String>> get outList => _listController.stream;
  Sink<List<String>> get inList => _listController.sink;

  void addList() {
    _listController.add(_listController.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
