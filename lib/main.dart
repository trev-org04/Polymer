import 'package:flutter/material.dart';
import 'package:project_polymer/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:project_polymer/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: new ThemeData(
       canvasColor: Color(0xff181818),),
        home: Wrapper(),
      ),
    );
  }
}