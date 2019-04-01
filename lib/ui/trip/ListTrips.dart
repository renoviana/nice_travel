import 'package:flutter/material.dart';

import 'package:nice_travel/model/Trip.dart';
import 'package:nice_travel/controller/listController.dart';
import 'package:nice_travel/ui/trip/TripCard.dart';

class ListTrips extends StatelessWidget {
  final Widget child;
  final ListController bloc;
  ListTrips(this.bloc, {Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.getList();

    //bloc.addToList(Trip('', 1, 'teste'));
    return StreamBuilder(
      stream: this.bloc.outList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Trip> lista = snapshot.data;

          if (lista.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    )
                  ],
                )
              ],
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                padding: EdgeInsets.all(12),
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
