import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/pages/listController.dart';
import 'package:nice_travel/ui/TripCard.dart';

class ListTrips extends StatefulWidget {
  final Widget child;

  ListTrips({Key key, this.child}) : super(key: key);

  _ListTripsState createState() => _ListTripsState();
}

class _ListTripsState extends State<ListTrips> {
  @override
  Widget build(BuildContext context) {
    final ListController bloc = BlocProvider.of<ListController>(context);
    return StreamBuilder(
      stream: bloc.outList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<String> lista = snapshot.data;
          if (lista.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("Você ainda não tem uma viagem")],
            );
          } else {
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (BuildContext context, int i) {
                return new TripCard(lista[i]);
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
