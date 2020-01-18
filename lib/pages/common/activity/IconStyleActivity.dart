import 'package:flutter/material.dart';
import 'package:nice_travel/widgets/NiceTravelIcons.dart';

enum Style {
  RESTAURANT,
  BAR,
  MUSEUM,
  SHOP,
  HISTORICAL_MONUMENT,
  SWIMMING,
  PARK,
  CHURCH,
  SPORT,
  OTHER,
}

List<String> getStyleDescription() {
  return Style.values
      .map((s) => s.toString().replaceAll("Style.", "").replaceAll("_", " "))
      .toList();
}

class IconStyleActivity {
  Icon icon;
  Color color;
  bool withColor = false;

  IconStyleActivity(String styleActivity, {this.withColor = false}) {
    Style style = Style.values.firstWhere((s) => s
        .toString()
        .replaceAll("_", " ")
        .toLowerCase()
        .contains(styleActivity.toLowerCase()));
    switch (style) {
      case Style.BAR:
        color = Colors.deepPurpleAccent;
        icon = Icon(Icons.local_bar, color: updateIconColor());
        break;
      case Style.RESTAURANT:
        color = Colors.orange;
        icon = Icon(Icons.restaurant, color: updateIconColor());
        break;
      case Style.MUSEUM:
        color = Colors.brown;
        icon = Icon(Icons.account_balance, color: updateIconColor());
        break;
      case Style.SHOP:
        color = Colors.purple;
        icon = Icon(Icons.shopping_cart, color: updateIconColor());
        break;
      case Style.HISTORICAL_MONUMENT:
        color = Colors.pinkAccent;
        icon = Icon(Icons.camera_alt, color: updateIconColor());
        break;
      case Style.SWIMMING:
        color = Colors.blue;
        icon = Icon(NiceTravelIcons.swimming, color: updateIconColor());
        break;
      case Style.PARK:
        color = Colors.green;
        icon = Icon(Icons.directions_bike, color: updateIconColor());
        break;
      case Style.CHURCH:
        color = Colors.yellow;
        icon = Icon(NiceTravelIcons.home, color: updateIconColor());
        break;
      case Style.SPORT:
        color = Colors.lightGreen;
        icon = Icon(NiceTravelIcons.soccer_ball, color: updateIconColor());
        break;
      case Style.OTHER:
        color = Colors.black26;
        icon = Icon(Icons.extension, color: updateIconColor());
        break;
    }
  }

  Color updateIconColor() => this.withColor ? color : Colors.black;
}
