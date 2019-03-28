import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/controller/listController.dart';
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
          List<Trip> lista = snapshot.data;
          if (lista.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("Você ainda não tem uma viagem")],
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int i) {
                  return new TripCard(lista[i]);
                },
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}
