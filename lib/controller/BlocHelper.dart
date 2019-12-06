import 'dart:io';

class BlocHelper {
  static getErrorMessage(Exception e) {
    print(e);
    if (e is SocketException) {
      return "Erro de conexão com a internet.";
    }
    return e.toString();
  }
}
