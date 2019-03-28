import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:nice_travel/controller/listController.dart';
import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/model/api.dart';
import 'package:nice_travel/model/placesDetails.dart';

class AddCronograma extends StatefulWidget {
  final Widget child;

  AddCronograma({Key key, this.child}) : super(key: key);

  _AddCronogramaState createState() => _AddCronogramaState();
}

class _AddCronogramaState extends State<AddCronograma> {
  GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey: kGoogleApiKey);

  final _formKey = GlobalKey<FormState>();

  Result _destino;
  String _dias;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ListController _bloc = BlocProvider.of<ListController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar novo cronograma',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          _googlePlacesButton(),
          _cronogramaForm(),
          Container(
            width: 200,
            height: 60,
            margin: EdgeInsets.all(15),
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  print(_destino);
                  print(_dias);
                  _bloc.addToList(Trip(_destino, int.parse(_dias), 'teste'));
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "Concluir",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _cronogramaForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(15),
              child: new TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: controller,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor selecione um destino';
                  }
                },
                decoration: new InputDecoration(hintText: "Destino"),
              )),
          Container(
            margin: EdgeInsets.all(15),
            child: new TextFormField(
              decoration: new InputDecoration(hintText: "Quantidade de dias"),
              onSaved: (value) => _dias = value,
              keyboardType: TextInputType.numberWithOptions(),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Campo Obrigatório';
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _googlePlacesButton() {
    return new Container(
      height: 50,
      margin: EdgeInsets.all(15),
      child: RaisedButton(
          color: Colors.blueAccent,
          child: Text(
            "Selecione seu destino",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () async {
            Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: kGoogleApiKey,
                    mode: Mode.fullscreen,
                    language: "pt",
                    types: ["(cities)"],
                    components: [new Component(Component.country, "br")])
                .then((value) {
              _places.getDetailsByPlaceId(value.placeId).then((onValue) {
                setState(() {
                  controller.text = onValue.result.formattedAddress;
                  _destino = Result.fromPlaceDetails(onValue.result);
                });
              });
            });
          }),
      width: MediaQuery.of(context).size.width,
    );
  }
}

// Essas classe serve para manter o input destino disabilitado.
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
