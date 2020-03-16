import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nice_travel/controller/AutoCompleteBloc.dart';
import 'package:nice_travel/model/PlacesModel.dart';
import 'package:nice_travel/module/travel/controller/travel_controller.dart';
import 'package:nice_travel/widgets/auto_complete_field.dart';

class ScheduleCard extends StatelessWidget {
  AutoCompleteTextField<GooglePlacesModel> _field;
  AutoCompleteField _autoCompleteField;

  final travelController = Modular.get<TravelController>();

  ScheduleCard() {
    _autoCompleteField = new AutoCompleteField(
        InputDecoration(
            hintText: "Vai para onde?",
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _autoCompleteField.field.clear();
                _autoCompleteField.clearPlaceID();
                updateSchedules();
                autoCompleteBloc.setCityInputStatus.add(true);
              },
            )),
        () => updateSchedules());
    _field = _autoCompleteField.field;
  }

  void updateSchedules() {
    travelController.loadSchedules(_autoCompleteField.getPlaceId());
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
            Directionality(textDirection: TextDirection.ltr, child: _field),
          ],
        ),
        padding: EdgeInsets.only(bottom: 10.00),
      ),
    ));
  }
}
