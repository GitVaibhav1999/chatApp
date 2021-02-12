import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  final _auth = FirebaseAuth.instance;
  UserCredential authresult;
  void _submitUserForm(String email, String username, String password,
      bool isLogin, BuildContext context) async {
    try {
      if (!isLogin) {
        FocusScope.of(context).unfocus();
        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (error) {
      var message = error.message;
      print(message);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      print(error.message);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(body: AuthForm(_submitUserForm));
  }
}
