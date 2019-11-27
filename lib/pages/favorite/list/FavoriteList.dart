import 'package:flutter/material.dart';
import 'package:nice_travel/controller/travel/ListScheduleBloc.dart';
import 'package:nice_travel/model/Schedule.dart';
import 'package:nice_travel/pages/favorite/list/FavoriteListItem.dart';

class FavoriteList extends StatelessWidget {
  FavoriteList() {
    listScheduleBloc.loadSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Schedule>>(
        stream: listScheduleBloc.getListSchedule,
        initialData: [],
        builder: (context, snapshot) {
          return
            (snapshot.hasData && snapshot.data.length > 0) ?
            Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return FavoriteListItem(snapshot.data[index]);
                  },
                  itemCount: 1,
                )
            ) : Container();
        }
    );
  }
}
