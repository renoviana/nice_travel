import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

import 'SessionUser.dart';

class UserModel extends Model {
  FirebaseUser _firebaseUser;
  SessionUser sessionUser;
  String tokenMessage;

  //  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  UserModel.newInstance();

  UserModel.mockLogin(){
    this.sessionUser = new SessionUser("Thiago","thiagobomfim1995@gmail.com", "ImEQrrQkeseYvPAwaqx0TFWj4CL2", null);
  }

  updateUserTokenMessage() async {
    if (tokenMessage == null) {
//      tokenMessage = await _firebaseMessaging.getToken();
    }
    return tokenMessage;
  }

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  void signIn(FirebaseUser firebaseUser) async {
    updateUserTokenMessage();
    sessionUser = new SessionUser(firebaseUser.displayName, firebaseUser.email,
        firebaseUser.uid, tokenMessage);
    this._firebaseUser = firebaseUser;
    notifyListeners();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    _firebaseUser = null;
    sessionUser = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return sessionUser != null;
  }

  void signInSilently() async {
    if (!isLoggedIn()) {
      await GoogleSignIn().signInSilently().then((userAuthenticated) async {
        if (userAuthenticated != null) {
          final GoogleSignInAuthentication googleAuth =
              await userAuthenticated.authentication;
          FirebaseUser _firebaseUser = await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ));
          signIn(_firebaseUser);
        }
      });
    }
  }

  SessionUser getSessionUser() {
    updateUserTokenMessage();
    sessionUser.tokenMessage = tokenMessage;
    return sessionUser;
  }

}


