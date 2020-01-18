import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:nice_travel/integration/AcitivityApiConnection.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/common/activity/ActivityTimeline.dart';
import 'package:nice_travel/pages/common/activity/IconStyleActivity.dart';
import 'package:nice_travel/widgets/ModalDialog.dart';
import 'package:nice_travel/widgets/ShowToast.dart';
import 'package:nice_travel/widgets/ValidateField.dart';
import 'package:nice_travel/widgets/showCircularProgress.dart';

class ActivityPage extends StatefulWidget {
  final Activity _activity;
  final ScheduleDay _scheduleDay;
  final Schedule _schedule;

  ActivityPage(this._activity, this._scheduleDay, this._schedule);

  @override
  _ActivityPageState createState() =>
      _ActivityPageState(_activity, _scheduleDay, _schedule);
}

class _ActivityPageState extends State<ActivityPage> {
  final Activity _activity;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final ScheduleDay _scheduleDay;
  final Schedule _schedule;

  MoneyMaskedTextController _moneyController;
  TextEditingController _nameController;
  TextEditingController _descriptionController;

  _ActivityPageState(this._activity, this._scheduleDay, this._schedule);

  updateProductModelValue() {
    setState(() {
      _activity.price = _moneyController.numberValue;
      _activity.nameOfPlace = _nameController.text;
      _activity.description = _descriptionController.text;
    });
  }

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  void initControllers() {
    _nameController = new TextEditingController(text: _activity.nameOfPlace);
    _descriptionController =
        new TextEditingController(text: _activity.description);
    _moneyController = MoneyMaskedTextController(
        initialValue: _activity.price,
        decimalSeparator: ',',
        thousandSeparator: '.');
    _moneyController.addListener(updateProductModelValue);
    _descriptionController.addListener(updateProductModelValue);
    _nameController.addListener(updateProductModelValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          _activity.nameOfPlace ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: CloseButton(),
      ),
      body: builtActivity(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => save(context),
        child: Icon(Icons.save),
        backgroundColor: Colors.blue,
      ),
    );
  }

  builtActivity() {
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
                  _builtNameText(),
                  _builtPriceText(),
                  _builtTimeInicio(),
                  _builtTimeFim(),
                  _builtStyleActivity(),
                  _builtDescriptionText(),
                ],
              ),
            ),
            buildRemoverButton(),
          ],
        ),
      ),
    );
  }

  buildRemoverButton() {
    if (_activity.id != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        child: MaterialButton(
          height: 45,
          //Wrap with Material
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          elevation: 18.0,
          color: Color(0xFF801E08),
          clipBehavior: Clip.antiAlias,
          // Add This
          child: new Text('Deletar',
              style: new TextStyle(fontSize: 16.0, color: Colors.white)),
          onPressed: () {
            removerDialog(
                context, "Deseja remover essa atividade?", deleteAction);
          },
        ),
      );
    }
    return Container();
  }

  deleteAction() {
    showCircularProgress(context);
    ActivityApiConnection.instance.deleteActivity(_activity.id).then((_) => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      ActivityTimeline(_scheduleDay, _schedule)),
              ModalRoute.withName('/daySchedulePage')),
        });
  }

  save(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      showCircularProgress(context);
      ActivityApiConnection.instance.addActivity(_activity).then(
          (_) => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            ActivityTimeline(_scheduleDay, _schedule)),
                    ModalRoute.withName('/daySchedulePage')),
              }, onError: (message) {
        Navigator.pop(context);
        showToastMessage(message, _scaffoldKey);
      });
    } else {
      showToastMessage("É necessário preencher todos os campos", _scaffoldKey);
    }
  }

  bool predicateRoute(Route r) {
    print(r.settings);
    print(r.toString());
    return r.isFirst;
  }

  Widget _builtDescriptionText() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 10,
      validator: validateRequiredField,
      decoration: InputDecoration(
          labelText: "Descrição",
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
      style: TextStyle(color: Colors.black, fontSize: 18.0),
      textAlign: TextAlign.justify,
    );
  }

  Widget _builtNameText() {
    return TextFormField(
      controller: _nameController,
      validator: validateRequiredField,
      decoration: InputDecoration(
          labelText: "Atividade",
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
      style: TextStyle(color: Colors.black, fontSize: 18.0),
      textAlign: TextAlign.start,
    );
  }

  _builtPriceText() {
    return TextField(
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
            labelText: "Preço diário",
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder()),
        controller: _moneyController,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ));
  }

  _builtTimeInicio() {
    return DateTimeField(
      readOnly: true,
      decoration: InputDecoration(
          labelText: 'Início da atividade',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
      format: DateFormat("HH:mm"),
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
              currentValue ?? _activity.startActivityDate),
        );
        return DateTimeField.convert(time);
      },
      initialValue: _activity.startActivityDate,
      onChanged: (dt) => setState(() => _activity.startActivityDate = dt),
    );
  }

  _builtTimeFim() {
    return DateTimeField(
      readOnly: true,
      decoration: InputDecoration(
          labelText: 'Fim da atividade',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
      format: DateFormat("HH:mm"),
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
              currentValue ?? _activity.finishActivityDate),
        );
        return DateTimeField.convert(time);
      },
      validator: _validateDate,
      initialValue: _activity.finishActivityDate,
      onChanged: (dt) => setState(() => _activity.finishActivityDate = dt),
    );
  }

  String _validateDate(DateTime date) {
    if (_activity.finishActivityDate != null &&
        _activity.startActivityDate
                .difference(_activity.finishActivityDate)
                .inMinutes >
            0) {
      return "A data final precisa ser maior do que a data inicial.";
    }
    return null;
  }

  _builtStyleActivity() {
    return FormBuilderDropdown(
      attribute: "atividade",
      decoration: InputDecoration(
          labelText: 'Tipo da atividade',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
      initialValue: _activity.styleActivity.toUpperCase(),
      hint: Text('Select Gender'),
      onChanged: (tp) => _activity.styleActivity = tp,
      validators: [FormBuilderValidators.required()],
      items: getStyleDescription()
          .map((tp) => DropdownMenuItem(
              value: tp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconStyleActivity(tp).icon,
                  Text("$tp"),
                ],
              )))
          .toList(),
    );
  }
}
