import 'package:flutter/material.dart';
import 'package:nice_travel/ui/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String _email, _password;

  GoogleSignIn googleAuth = new GoogleSignIn();
  FacebookLogin facebookLogin = new FacebookLogin();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget emailInput(){
    return TextFormField(
      validator: (input) {
        if (input.isEmpty) return 'Por favor digite um email';
      },
      onSaved: (input) => _email = input,
      decoration: InputDecoration(labelText: 'Email'),
    );
  }

  Widget passwordInput(){
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

  Widget googleSignInButton(){
    return RaisedButton(
      child: Text("Login with Google"),
      onPressed: (){
        googleAuth.signIn().then((result){
          result.authentication.then((googleKey){
            AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleKey.idToken, accessToken: googleKey.accessToken);
            FirebaseAuth.instance.signInWithCredential(credential).then((FirebaseUser signedUser){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home(user:signedUser)));
            }).catchError((e){
              print(e);
            });
          }).catchError((e){
            print(e);
          });
        }).catchError((e){
          print(e);
        });
      },

    );
  }


  Widget facebookSignInButton(){
    return RaisedButton(
      child: Text("Login with Facebook"),
      onPressed: (){
        final facebookLogin = FacebookLogin().logInWithReadPermissions(['email','public_profile']).then((result){
          switch (result.status) {
            case FacebookLoginStatus.loggedIn:
              AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
              FirebaseAuth.instance.signInWithCredential(credential).then((FirebaseUser user){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user,)));
              });
              break;
            case FacebookLoginStatus.cancelledByUser:
              break;
            case FacebookLoginStatus.error:
              break;
          }
        });



      },
    );
  }



  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          emailInput(),
          passwordInput(),
          RaisedButton(
            onPressed: signIn,
            child: Text('Entrar'),
          ),
          googleSignInButton(),
          facebookSignInButton()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nive Travel"),
      ),
      body: form(),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user:user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
