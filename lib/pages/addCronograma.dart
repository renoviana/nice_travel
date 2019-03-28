import 'package:flutter/material.dart';
import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';

class AddCronograma extends StatefulWidget {
  final Widget child;

  AddCronograma({Key key, this.child}) : super(key: key);

  _AddCronogramaState createState() => _AddCronogramaState();
}

const kGoogleApiKey = "AIzaSyC9b4oUjYYnSj5jLqdUidl4Wdy1cEskoJI";

class _AddCronogramaState extends State<AddCronograma> {
  GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey: kGoogleApiKey);

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
    if (_confirmButton) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator()],
        ),
      );
    }
    return Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.all(15),
          child: RaisedButton(
              child: Text("Selecione seu destino"),
              onPressed: () async {
                Prediction p = await showGooglePlacesAutocomplete(
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
        Container(
          margin: EdgeInsets.all(15),
          child: new TextField(
            controller: controller,
            decoration: new InputDecoration(hintText: "Destino"),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15),
          child: new TextField(
            decoration: new InputDecoration(hintText: "Quantidade de dias"),
          ),
        ),
      ],
    );
  }
}
