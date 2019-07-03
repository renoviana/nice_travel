import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/controller/AutoCompleteBloc.dart';
import 'package:nice_travel/model/PlacesModel.dart';
import 'package:nice_travel/pages/favorite/card/AutoCompleteField.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({Key key}) : super(key: key);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  AutoCompleteTextField<GooglePlacesModel> _field;
  AutoCompleteField autoCompleteField;

  @override
  void initState() {
    super.initState();
    autoCompleteField = new AutoCompleteField();
    _field = autoCompleteField.field;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      margin: EdgeInsets.all(10),
      elevation: 2.00,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(child: _field),
            StreamBuilder(
              stream: autoCompleteBloc.getCityInputStatus,
              initialData: true,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == true) return Container();
                return hiddenColumn();
              },
            ),
          ],
        ),
        padding: EdgeInsets.only(bottom: 10.00),
      ),
    ));
  }

  Column hiddenColumn() {
    return Column(
      children: <Widget>[
        TextField(decoration: InputDecoration(hintText: "Quantos dias?")),
        Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          color: Colors.blue,
          child: RaisedButton(
            onPressed: () => {},
            child: Text(
              "Buscar",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
