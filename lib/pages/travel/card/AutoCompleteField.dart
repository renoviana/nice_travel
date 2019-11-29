import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/AutoCompleteBloc.dart';
import 'package:nice_travel/controller/resource/CitiesResource.dart';
import 'package:nice_travel/model/PlacesModel.dart';

class AutoCompleteField {
  GlobalKey _key =
      new GlobalKey<AutoCompleteTextFieldState<GooglePlacesModel>>();

  AutoCompleteTextField<GooglePlacesModel> field;

  List<GooglePlacesModel> lista = [];

  String _placeId;
  bool _cityInputisNull = true;
  bool _focusOn = false;

  bool isCityInputNull() => _cityInputisNull;

  String getPlaceId() => _placeId;

  AutoCompleteField(InputDecoration inputDecoration, Function onSelectCity) {
    field = AutoCompleteTextField<GooglePlacesModel>(
      decoration: inputDecoration,
      clearOnSubmit: false,
      onFocusChanged: (focus) =>
          clearOnFocusOutWhenValueWasNotSelected(focus, onSelectCity),
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
        field.textField.controller.text = data.terms[0].value;
        _placeId = data.placeId;
        print('On Autocomplete Changed');
        Function.apply(onSelectCity, []);
        autoCompleteBloc.setCityInputStatus.add(false);
        _cityInputisNull = false;
      },
      textChanged: (String text) async {
        _cityInputisNull = true;

        if (text.length >= 3) {
          await CitiesResource().getCities(text).then((onValue) {
            if (field != null && onValue != null) {
              field.updateSuggestions(onValue);
            }
          });
        }
      },
      key: _key,
      suggestions: lista,
    );
  }

  clearOnFocusOutWhenValueWasNotSelected(bool focus, Function changeCity) {
    if (!focus && _cityInputisNull) {
      field.clear();
      _placeId = null;
      Function.apply(changeCity, []);
    }
    _focusOn = focus;
  }

  clearPlaceID(){
    _placeId = null;
  }
  Widget itemBuilder(BuildContext context, GooglePlacesModel suggestion) {
    return Visibility(
      child: new ListTile(
        title: Text(suggestion.description),
//       trailing: Text(suggestion.terms[1].value),
      ),
      visible: _focusOn,
    );
  }
}
