import 'package:dio/dio.dart';
import 'package:nice_travel/model/CityModel.dart';
import 'package:nice_travel/model/PlacesModel.dart';
import 'package:nice_travel/model/api.dart';

class CitiesResource {
  Dio dio = new Dio();

  GooglePlacesModel googlePlacesModel = new GooglePlacesModel();

  Future<List<GooglePlacesModel>> getCities(query) async {
    var response = await dio.get(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json",
        queryParameters: {
          "input": query,
          "language": "pt-BR",
          "types": "(cities)",
          "key": kGoogleApiKey
        });
    List<GooglePlacesModel> lista =
        googlePlacesModel.fromJsonList(response.data['predictions']);
    return lista;
  }
}
