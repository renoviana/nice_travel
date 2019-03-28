import 'package:http/http.dart' as http;

class ApiConnection {

  getScheduleByCityName(String cityName, int sizeElements) async {
    final url = "http://localhost:8080/schedule/city?cityName=$cityName&sizeElements=$sizeElements";
    final response = await http.get(url);
    if(response.statusCode == 200) {
      return response.body;
    }
    return response.statusCode;
  }

}