import 'package:flutter/material.dart';

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

List<String> getStyleDescription(){
   return Style.values.map((s) => s.toString().replaceAll("Style.", "").replaceAll("_", " ")).toList();
}

const icons = 'NiceTravelIcons';

class IconStyleActivity {
  Icon icon;
  Color color;

  IconStyleActivity(String styleActivity) {
    Style style = Style.values.firstWhere((s) => s.toString().replaceAll("_", " ").toLowerCase()
        .contains(styleActivity.toLowerCase()));
    switch (style){
      case Style.BAR:
        icon = Icon(Icons.local_bar);
        color = Colors.deepPurpleAccent;
        break;
      case Style.RESTAURANT:
        icon = Icon(Icons.restaurant);
        color = Colors.orange;
        break;
      case Style.MUSEUM:
        icon = Icon(Icons.account_balance);
        color = Colors.brown;
        break;
      case Style.SHOP:
        icon = Icon(Icons.shopping_cart);
        color = Colors.purple;
        break;
      case Style.HISTORICAL_MONUMENT:
        icon = Icon(Icons.camera_alt);
        color = Colors.pinkAccent;
        break;
      case Style.SWIMMING:
          icon = Icon(const IconData(0xe838, fontFamily: icons));
    color = Colors.blue;
        break;
      case Style.PARK:
        icon = Icon(Icons.directions_bike);
        color = Colors.green;
        break;
      case Style.CHURCH:
        icon = Icon(const IconData(0xe800, fontFamily: icons));
        color = Colors.yellow;
        break;
      case Style.SPORT:
        icon = Icon(const IconData(0xf1e3, fontFamily: icons));
        color = Colors.lightGreen;
        break;
      case Style.OTHER:
        icon = Icon(Icons.forward);
        color = Colors.black26;
        break;
    }
  }


}
