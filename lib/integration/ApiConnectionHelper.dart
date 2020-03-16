import 'package:http/http.dart' as http;
import 'package:nice_travel/integration/ApiException.dart';

class ApiConnectionHelper {
//  static const URL_API = "https://nice-travel2.herokuapp.com";
  static const URL_API = "http://192.168.25.185:8080";

  static String encodeFull(String url) {
    var urlFormatted = Uri.encodeFull(url);
    print(urlFormatted);
    return urlFormatted;
  }

  static Future<dynamic> get(url) async {
    final response = await http.get(encodeFull(url));
    return _returnResponse(response);
  }

  static Future<dynamic> post(url) async {
    final response = await http.post(encodeFull(url));
    return _returnResponse(response);
  }

  static Future<dynamic> delete(String url) async {
    final response = await http.delete(url);
    return _returnResponse(response);
  }

  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
