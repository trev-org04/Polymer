import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/screens/auth/intro.dart';
import 'package:project_polymer/models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

    void setTheme() {
      if (isLightTheme == true) {
        setState(() {
          navigationColor = Color.fromRGBO(214, 214, 214, 0.75);
          canvasColor = Color(0xffFFFFFF);
          buttonBlue = Color(0xff0099FF);
          adaptiveTile = Color(0xff181818);
          elementColor = Color(0xffE0E0E0);
          mathColor = Color(0xff8855FF);
          scienceColor = Color(0xffCCA000);
          englishColor = Color(0xffEA3160);
          readingColor = Color(0xff00CC88);
          white = Color(0xff3D3D3D);
          whiteOpacity = Color.fromRGBO(61, 61, 61, 0.65);
          isLightTheme = true;
        });
      } else {
        setState(() {
          navigationColor = Color.fromRGBO(24, 24, 24, 0.85);
          canvasColor = Color(0xff181818);
          buttonBlue = Color(0xff0099FF);
          adaptiveTile = Color(0xff272727);
          elementColor = Color(0xff232323);
          mathColor = Color(0xff8855FF);
          scienceColor = Color(0xffCCA000);
          englishColor = Color(0xffEA3160);
          readingColor = Color(0xff00CC88);
          white = Color(0xffE2E2E2);
          whiteOpacity = Color.fromRGBO(226, 226, 226, 0.65);
          isLightTheme = false;
        });
      }
    }

    Future<dynamic> setThemeBasedOnPref(String uid) async {
  final DocumentReference document = Firestore.instance.collection('Data').document(uid);

  await document.get().then((val) async {
    isLightTheme = val['isLight'];
    setTheme();
  });
}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Intro();
    } else {
      setThemeBasedOnPref(user.uid);
      return Base();
    }
  }
}
