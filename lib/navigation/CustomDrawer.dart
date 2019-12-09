import 'package:flutter/material.dart';
import 'package:nice_travel/login/SignIn.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/widgets/NiceTravelIcons.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DrawerTile.dart';
import 'TabModel.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return Stack(
          children: <Widget>[
            _buildDrawerBack(),
            ListView(
              padding: EdgeInsets.only(left: 32.0, top: 16.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  height: 170.0,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Image.asset("logo.png"),
                      ),
                      buildSignInButton(context, model)
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                ),
                createDrawerTiles(model),
              ],
            )
          ],
        );
      }),
    );
  }

  Positioned buildSignInButton(BuildContext context, UserModel model) {
    return Positioned(
      left: 0.0,
      bottom: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            " ${!model.isLoggedIn() ? "" : "Olá, " + model.sessionUser.displayName}",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            child: buildLoginButton(model, context),
            onTap: () {
              if (!model.isLoggedIn()) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignIn(model)));
              } else {
                model.signOut();
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildLoginButton(UserModel model, BuildContext context) {
    if (!model.isLoggedIn()) {
      return Row(
        children: <Widget>[
          Text(
            "Entrar ",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Icon(NiceTravelIcons.login, size: 16, color: Theme.of(context).primaryColor,)
        ],
      );
    }
    return Row(
      children: <Widget>[
        Text(
          "Sair ",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        Icon(NiceTravelIcons.logout, size: 16, color: Theme.of(context).primaryColor,)
      ],
    );
  }

  Widget createDrawerTiles(UserModel model) {
    return new FutureBuilder<List<TabModel>>(
      future: TabModel.getTabModels(model),
      builder: (context, elements) {
        if (elements.hasData) {
          List<Widget> drawerTiles = [];
          elements.data.forEach((tab) => {
                drawerTiles.add(DrawerTile(
                    tab.icon, tab.name, pageController, tab.pageId, tab.qtd))
              });
          return Column(
            children: drawerTiles,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
