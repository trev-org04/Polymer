import 'package:flutter/material.dart';
import 'package:project_polymer/screens/auth/register.dart';
import 'package:project_polymer/screens/auth/signin.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

bool showSignUp = false;

void toggleView () {
  setState(() => showSignUp = !showSignUp);
}

  @override
  Widget build(BuildContext context) {
    if (showSignUp)  {
      return Register(toggleView: toggleView);
    }
    else {
      return SignIn(toggleView: toggleView);
    }
  }
}