import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/events/events.dart';
import 'package:project_polymer/screens/forum/forum.dart';
import 'package:project_polymer/screens/home/home.dart';
import 'package:project_polymer/screens/home/modals.dart';
import 'package:project_polymer/screens/lessons/lessons.dart';
import 'package:project_polymer/shared/constants.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

final pageOptions = [
  Home(),
  Events(),
  Lessons(),
  Forum(),
];

int _selectedIndex = 0;

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: canvasColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: canvasColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.account_circle, color: white, size: 30),
                splashColor: canvasColor,
                splashRadius: 0.1,
                onPressed: () {
                  accountModal(context);
                },
              ),
              isLightTheme ?
              Image.asset(
                'assets/logo_light.png',
                fit: BoxFit.contain,
                height: 30,
              ) :
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 30,
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: white, size: 30),
                splashColor: canvasColor,
                splashRadius: 0.1,
                onPressed: () {
                  notificationsModal(context);
                },
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            pageOptions[_selectedIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55.0,
                decoration: BoxDecoration(color: navigationColor),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildNavBarItem(Icons.dashboard, 0, true),
                      buildNavBarItem(Icons.calendar_today, 1, false),
                      buildNavBarItem(MdiIcons.teach, 2, false),
                      buildNavBarItem(Icons.question_answer, 3, false),
                    ]),
              ),
            )
          ],
        ));
  }

  Widget buildNavBarItem(IconData icon, int index, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.all(0),
        height: 40,
        width: MediaQuery.of(context).size.width / 4,
        padding: const EdgeInsets.fromLTRB(27, 0, 27, 7.5),
        child: Icon(icon,
            color: index == _selectedIndex ? buttonBlue : whiteOpacity),
      ),
    );
  }
}
