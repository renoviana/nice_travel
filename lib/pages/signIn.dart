import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:nice_travel/controller/authController.dart';

import 'package:nice_travel/pages/HomeWidget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email, _password;

  GoogleSignIn googleAuth = new GoogleSignIn();
  FacebookLogin facebookLogin = new FacebookLogin();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget emailInput() {
    return TextFormField(
      validator: (input) {
        if (input.isEmpty) return 'Por favor digite um email';
      },
      onSaved: (input) => _email = input,
      decoration: InputDecoration(labelText: 'Email'),
    );
  }

  Widget passwordInput() {
    return TextFormField(
      validator: (input) {
        if (input.length < 8)
          return 'Sua senha precisa de no mínimo 8 dígitos.';
      },
      onSaved: (input) => _password = input,
      decoration: InputDecoration(labelText: 'Senha'),
      obscureText: true,
    );
  }

  Widget googleSignInButton() {
    return Container(
      width: 300,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.red,
      ),
      child: FlatButton(
          textColor: Colors.white,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                MdiIcons.google,
                color: Colors.white,
              ),
              Container(
                width: 10,
              ),
              Text(
                'Continuar com Google',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          )),
    );
    // );Container(
    //   color: Colors.red,
    //   child: IconButton(
    //     icon: Icon(MdiIcons.google),
    //     color: Colors.white,
    //     onPressed: initiateGoogleLogin,
    //   ),
    // );
  }

  void initiateGoogleLogin() {
    final AuthController bloc = authController;
    googleAuth.signIn().then((result) {
      result.authentication.then((googleKey) {
        AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleKey.idToken, accessToken: googleKey.accessToken);
        FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((FirebaseUser signedUser) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Home(
                    user: signedUser,
                  )));
        }).catchError((e) {
          bloc.setMsg(e.toString());
        });
      }).catchError((e) {
        bloc.setMsg(e.toString());
      });
    }).catchError((e) {
      bloc.setMsg(e.toString());
    });
  }

  void initiateFacebookLogin() async {
    final AuthController bloc = authController;
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        //Todo mosrtar exception para o usuário
        bloc.setMsg(facebookLoginResult.errorMessage);
        break;
      case FacebookLoginStatus.cancelledByUser:
        //Todo mosrtar exception para o usuário
        bloc.setMsg('Cancelado pelo usuário');
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: facebookLoginResult.accessToken.token);
        FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((FirebaseUser user) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Home(
                    user: user,
                  )));
        });
        break;
    }
  }

  Widget roundFlatButton(IconData icon, String text, Function f, Color cor) {
    return Container(
      width: 300,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: cor,
      ),
      child: FlatButton(
          textColor: Colors.white,
          onPressed: () {
            f();
          },
          child: Row(
            children: <Widget>[
              Icon(icon),
              Container(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/boipeba.png"),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "NICE TRAVEL",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            Container(
              height: 70,
            ),
            roundFlatButton(MdiIcons.facebookBox, "Continuar com Facebook",
                initiateFacebookLogin, Colors.blue),
            Container(
              height: 35,
            ),
            roundFlatButton(MdiIcons.google, "Continuar com Google",
                initiateGoogleLogin, Colors.red),
          ],
        ),
      ),
    );
  }

  // Widget form(context) {
  //   final AuthController bloc = BlocProvider.of<AuthController>(context);
  //   return Container(
  //     padding: EdgeInsets.all(16.0),
  //     child: Form(
  //       key: _formKey,
  //       child: Column(
  //         children: <Widget>[
  //           emailInput(),
  //           passwordInput(),
  //           RaisedButton(
  //             onPressed: signIn,
  //             child: Text('Entrar'),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[googleSignInButton(), facebookSignInButton()],
  //           ),
  //           StreamBuilder(
  //             stream: bloc.outMsg,
  //             builder: (BuildContext context, AsyncSnapshot snapshot) {
  //               if (snapshot.hasData) {
  //                 return Container(
  //                   padding: EdgeInsets.all(16.0),
  //                   child: Text(
  //                     snapshot.data,
  //                     style: TextStyle(color: Colors.red),
  //                   ),
  //                 );
  //               }
  //               return Text('');
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
