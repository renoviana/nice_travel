import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;
  final int qtd;

  DrawerTile(this.icon, this.text, this.controller, this.page, this.qtd);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => navigateToSelectedItem(context),
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: controller.page.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              SizedBox(
                width: 32.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              ),
              buildRawMaterialButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRawMaterialButton(BuildContext context) {
    if (qtd == null) {
      return Container();
    }
    return RawMaterialButton(
      onPressed: () => navigateToSelectedItem(context),
      child: Text(qtd.toString()),
      shape: CircleBorder(),
      elevation: 4.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(5.0),
    );
  }

  void navigateToSelectedItem(BuildContext context) {
    Navigator.of(context).pop();
    controller.jumpToPage(page);
  }
}
