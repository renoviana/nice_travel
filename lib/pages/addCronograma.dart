import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class AddCronograma extends StatefulWidget {
  final Widget child;

  AddCronograma({Key key, this.child}) : super(key: key);

  _AddCronogramaState createState() => _AddCronogramaState();
}

const kGoogleApiKey = "AIzaSyC9b4oUjYYnSj5jLqdUidl4Wdy1cEskoJI";

class _AddCronogramaState extends State<AddCronograma> {
  GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey: kGoogleApiKey);

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  bool _confirmButton = false;

  String _destino = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar novo cronograma',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(child: _formWidget()),
    );
  }

  Widget _formWidget() {
    return Column(
      children: <Widget>[
        new Container(
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
                        mode: Mode.overlay,
                        language: "pt",
                        components: [new Component(Component.country, "br")])
                    .then((value) {
                  _places.getDetailsByPlaceId(value.placeId).then((onValue) {
                    setState(() {
                      controller.text = onValue.result.name;
                    });
                  });
                });
              }),
          width: MediaQuery.of(context).size.width,
        ),
        _cronogramaForm(),
        Container(
          width: 200,
          height: 60,
          margin: EdgeInsets.all(15),
          child: RaisedButton(
            color: Colors.green,
            onPressed: () {
              if (_formKey.currentState.validate()) {}
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
    );
  }

  Widget _cronogramaForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: new FocusScope(
                node: new FocusScopeNode(),
                child: new TextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor selecione um destino';
                    }
                  },
                  decoration: new InputDecoration(hintText: "Destino"),
                )),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: new TextFormField(
              decoration: new InputDecoration(hintText: "Quantidade de dias"),
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
}
