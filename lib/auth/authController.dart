import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class AuthController implements BlocBase {
  var _msgController = BehaviorSubject<String>.seeded('');

  Stream<String> get outMsg => _msgController.stream;
  Sink<String> get inMsg => _msgController.sink;

  void setMsg(String msg) {
    _msgController.add(_msgController.value);
  }

  @override
  void dispose() {
    _msgController.close();
  }
}
