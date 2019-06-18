import 'dart:async';

import 'package:rxdart/rxdart.dart';

class AuthController {
  var _msgController = BehaviorSubject<String>.seeded('');

  Stream<String> get outMsg => _msgController.stream;
  Sink<String> get inMsg => _msgController.sink;

  void setMsg(String msg) {
    _msgController.add(_msgController.value);
  }
}

final authController = new AuthController();
