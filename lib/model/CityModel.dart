class CityModel {
  String estadoId;
  String cidade;
  bool capital;

  CityModel({this.estadoId, this.cidade, this.capital});

  CityModel.fromJson(Map<String, dynamic> json) {
    estadoId = json['estadoId'];
    cidade = json['cidade'];
    capital = json['capital'];
  }

  List<CityModel> fromList(List<dynamic> lista) {
    List<CityModel> citiesList = [];
    lista.forEach((json) => citiesList.add(new CityModel.fromJson(json)));
    return citiesList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estadoId'] = this.estadoId;
    data['cidade'] = this.cidade;
    data['capital'] = this.capital;
    return data;
  }
}
