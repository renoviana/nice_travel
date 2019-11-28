import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nice_travel/model/UserModel.dart';
import 'package:nice_travel/widgets/showCircularProgress.dart';

class SignIn extends StatefulWidget {
  final UserModel _model;

  SignIn(this._model);

  @override
  _SignInState createState() => _SignInState(_model);
}

class _SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserModel _model;

  // Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _SignInState(this._model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            Container(
              height: 35,
            ),
            roundFlatButton(
                _model, MdiIcons.google, "Continuar com Google", Colors.red),
          ],
        ),
      ),
    );
  }

  Future<Null> _signIn() async {
    showCircularProgress(context);
    GoogleSignInAccount user = _googleSignIn.currentUser;

    final onError = (exception, stacktrace) {
      print("ERROR -> $exception");
      _showErrorSnackbar(
          "Não foi possível realizar o login. Tente novamente mais tarde!");
      user = null;
    };

    if (user == null) {
      user = await _googleSignIn
          .signIn()
          .catchError(onError)
          // ignore: missing_return
          .then((userAuthenticated) {
        signInWithCredentials(userAuthenticated, onError);
      });
    }
    return null;
  }

  Future signInWithCredentials(GoogleSignInAccount userAuthenticated,
      onError(dynamic exception, dynamic stacktrace)) async {
    if (userAuthenticated != null) {
      final GoogleSignInAuthentication googleAuth =
          await userAuthenticated.authentication;
      FirebaseUser _firebaseUser = await _auth
          .signInWithCredential(GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ))
          .catchError(onError);
      _model.signIn(_firebaseUser);
      Navigator.of(context).pop();
    }
  }

  _showErrorSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget roundFlatButton(
      UserModel usermodel, IconData icon, String text, Color cor) {
    return Container(
      width: 300,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: cor,
      ),
      child: FlatButton(
          textColor: Colors.white,
          onPressed: () => {_signIn()},
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
}
