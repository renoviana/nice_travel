import 'package:flutter/material.dart';
import 'package:nice_travel/pages/favorite/card/FavoriteCard.dart';
import 'package:nice_travel/pages/favorite/list/FavoriteList.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FavoriteCard(),
          FavoriteList(),
        ],
      ),
    );
  }
}
