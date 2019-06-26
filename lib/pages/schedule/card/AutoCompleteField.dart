import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/AutoCompleteBloc.dart';
import 'package:nice_travel/controller/resource/CitiesResource.dart';
import 'package:nice_travel/model/CityModel.dart';
import 'package:nice_travel/model/PlacesModel.dart';

class AutoCompleteField {
  GlobalKey _key =
      new GlobalKey<AutoCompleteTextFieldState<GooglePlacesModel>>();

  AutoCompleteTextField<GooglePlacesModel> field;

  List<GooglePlacesModel> lista = [];

  bool _cityInputisNull = true;

  bool isCityInputNull() => _cityInputisNull;

  AutoCompleteField() {
    field = AutoCompleteTextField<GooglePlacesModel>(
      decoration: InputDecoration(
          hintText: "Buscar cronograma para onde?",
          suffixIcon: IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              field.clear();
              autoCompleteBloc.setCityInputStatus.add(true);
            },
          )),
      clearOnSubmit: false,
      itemBuilder: itemBuilder,
      itemFilter: (item, query) {
        return item.terms[0].value
            .toLowerCase()
            .startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.terms[0].value.compareTo(b.terms[0].value);
      },
      itemSubmitted: (GooglePlacesModel data) {
        print(data);
        field.textField.controller.text = data.terms[0].value;
        autoCompleteBloc.setCityInputStatus.add(false);
      },
      textChanged: (String text) async {
        _cityInputisNull = true;

        if (text.length >= 3) {
          await CitiesResource().getCities(text).then((onValue) {
            field.updateSuggestions(onValue);
          });
        }
      },
      key: _key,
      suggestions: lista,
    );
  }

  Widget itemBuilder(BuildContext context, GooglePlacesModel suggestion) {
    return new ListTile(
      title: Text(suggestion.description),
      //trailing: Text(suggestion.terms[1].value),
    );
  }
}
