import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_travel/controller/AutoCompleteBloc.dart';
import 'package:nice_travel/model/PlacesModel.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/travel/card/AutoCompleteField.dart';

class NewSchedulePage extends StatefulWidget {
  final Schedule _schedule;

  NewSchedulePage(this._schedule);

  @override
  _NewSchedulePageState createState() => _NewSchedulePageState(_schedule);
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  final Schedule _schedule;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  AutoCompleteTextField<GooglePlacesModel> _field;
  AutoCompleteField autoCompleteField;

  TextEditingController _qtdDaysController;

  _NewSchedulePageState(this._schedule);

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    autoCompleteField = new AutoCompleteField(InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Vai para onde?",
        labelStyle: TextStyle(color: Colors.black),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            autoCompleteField.field.clear();
            autoCompleteBloc.setCityInputStatus.add(true);
          },
        )));
    _field = autoCompleteField.field;
    _qtdDaysController =
        new TextEditingController(text: _schedule.qtdDays.toString());
    _qtdDaysController.addListener(updateProductModelValue);
  }

  updateProductModelValue() {
    setState(() {
      _schedule.qtdDays = _qtdDaysController.toString() as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          _schedule.nameCity ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: CloseButton(),
      ),
      body: buildSchedule(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => save(context),
        child: Icon(Icons.save),
        backgroundColor: Colors.blue,
      ),
    );
  }

  save(BuildContext context) {}

  buildSchedule() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              autovalidate: true,
              key: _formKey,
              child: Wrap(
                runSpacing: 20,
                runAlignment: WrapAlignment.start,
                children: <Widget>[
                  Container(child: _field),
                  _buildQtdDaysText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildQtdDaysText() {
    return new TextField(
      controller: _qtdDaysController,
      maxLength: 2,
      decoration: InputDecoration(
          labelText: "Quantidade de dias",
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
    );
  }
}
