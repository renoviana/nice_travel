import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/AutoCompleteBloc.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';
import 'package:nice_travel/model/PlacesModel.dart';
import 'package:nice_travel/pages/travel/card/AutoCompleteField.dart';

class ScheduleCard extends StatelessWidget {

  AutoCompleteTextField<GooglePlacesModel> _field;
  AutoCompleteField autoCompleteField;
  ScheduleCard(){
    autoCompleteField = new AutoCompleteField(InputDecoration(
        hintText: "Vai para onde?",
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            autoCompleteField.field.clear();
            autoCompleteField.clearPlaceID();
            updateSchedules();
            autoCompleteBloc.setCityInputStatus.add(true);
          },
        )), () => updateSchedules());
    _field = autoCompleteField.field;
  }

  void updateSchedules() {
      listScheduleBloc.loadSchedules(autoCompleteField.getPlaceId());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 2.00,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                Container(child: _field),
              ],
            ),
            padding: EdgeInsets.only(bottom: 10.00),
          ),
        ));
  }

}
