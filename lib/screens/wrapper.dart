import 'package:flutter/material.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/screens/auth/intro.dart';
import 'package:project_polymer/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Intro();
    } else {
      return Base();
    }
  }
}
