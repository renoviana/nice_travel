import 'package:flutter/material.dart';
import 'package:nice_travel/model/UserModel.dart';

class TabModel {
  final IconData icon;
  final String name;
  final int qtd;
  final int pageId;

  TabModel.name(this.icon, this.name, this.pageId, this.qtd);

  static Future<List<TabModel>> getTabModels(UserModel userModel) async {
    List<TabModel> tabs = [];
    tabs.add(TabModel.name(Icons.date_range, "Viagem", 0, null));
    tabs.add(TabModel.name(Icons.favorite, "Meus cronogramas", 1, null));
    return tabs;
  }
}
