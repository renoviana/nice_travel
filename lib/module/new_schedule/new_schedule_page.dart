import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_travel/controller/AutoCompleteBloc.dart';
import 'package:nice_travel/integration/ScheduleApiConnection.dart';
import 'package:nice_travel/model/PlacesModel.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/util/show_circular_progress.dart';
import 'package:nice_travel/util/validate_field.dart';
import 'package:nice_travel/widgets/auto_complete_field.dart';
import 'package:nice_travel/widgets/show_toast.dart';
import 'package:scoped_model/scoped_model.dart';

class NewSchedulePage extends StatefulWidget {
  NewSchedulePage();

  @override
  _NewSchedulePageState createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  String _placeId;
  int _qtdDays;
  String _nameCity;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  AutoCompleteTextField<GooglePlacesModel> _field;
  AutoCompleteField autoCompleteField;

  TextEditingController _qtdDaysController;

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    autoCompleteField = new AutoCompleteField(
        InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Vai para onde?",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                autoCompleteField.field.clear();
                autoCompleteField.clearPlaceID();
                changeCity();
                autoCompleteBloc.setCityInputStatus.add(true);
              },
            )),
            () => changeCity());
    _field = autoCompleteField.field;
    _qtdDaysController = new TextEditingController();
    _qtdDaysController.addListener(updateProductModelValue);
  }

  changeCity() {
    setState(() {
      _nameCity = _field.textField.controller.text;
      _placeId = autoCompleteField.getPlaceId();
    });
  }

  updateProductModelValue() {
    setState(() {
      if (_qtdDaysController.text != "") {
        _qtdDays = int.parse(_qtdDaysController.text);
      } else {
        _qtdDays = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_field.controller != null) {
      _field.controller.dispose();
    }
    _qtdDaysController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          _nameCity ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: CloseButton(),
      ),
      body: buildSchedule(),
    );
  }

  buildSchedule() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
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
                    Container(key: Key("new_schedule_name_field"), child: _field),
                    _buildQtdDaysText(),
                  ],
                ),
              ),
              buildSaveButton(model),
            ],
          ),
        ),
      );
    });
  }

  buildSaveButton(UserModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: MaterialButton(
        key: Key('save_new_schedule'),
        height: 45,
        //Wrap with Material
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
        elevation: 12.0,
        color: Colors.blue,
        clipBehavior: Clip.antiAlias,
        // Add This
        child: new Text('Salvar',
            style: new TextStyle(fontSize: 16.0, color: Colors.white)),
        onPressed: () {
          save(context, model);
        },
      ),
    );
  }

  _buildQtdDaysText() {
    return new TextFormField(
      key: Key("new_schedule_day_field"),
      validator: validateRequiredField,
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

  save(BuildContext context, UserModel model) async {
    if (_formKey.currentState.validate() && _nameCity != "") {
      showCircularProgress(context);
      ScheduleApiConnection.instance
          .createSchedule(_placeId, _qtdDays, model.sessionUser)
          .then((_) => _afterSuccessSave())
          .catchError((error) => _showErrorMessage(error));
    } else {
      showToastMessage("É necessário preencher todos os campos", _scaffoldKey);
    }
  }

  _showErrorMessage(error) {
    Navigator.pop(context);
    print(error);
    showToastMessage('Erro ao tentar salvar esse crongrama. '
        '\nPor favor, tente mais tarde.', _scaffoldKey);

  }

  _afterSuccessSave() {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
