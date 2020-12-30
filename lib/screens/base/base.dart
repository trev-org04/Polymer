import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/calendar/calendar.dart';
import 'package:project_polymer/screens/home/home.dart';
import 'package:project_polymer/screens/home/modals.dart';
import 'package:project_polymer/shared/constants.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;

  final pageOptions = [
    Home(),
    Calendar(),
    Home(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff181818),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff181818),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.account_circle, color: Color(0xffE2E2E2), size: 30),
                splashColor: Color(0xff181818),
                splashRadius: 0.1,
                onPressed: () {accountModal(context);},
              ),
              Image.asset(
                'assets/logo.jpeg',
                fit: BoxFit.contain,
                height: 30,
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Color(0xffE2E2E2), size: 30),
                splashColor: Color(0xff181818),
                splashRadius: 0.1,
                onPressed: () {notificationsModal(context);},
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
                decoration:
                    BoxDecoration(color: Color.fromRGBO(24, 24, 24, 0.85)),
                child: Row(children: [
                  buildNavBarItem(Icons.dashboard, 0, true),
                  buildNavBarItem(Icons.calendar_today, 1, false),
                  buildNavBarItem(MdiIcons.tableLarge, 2, false),
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

//https://stackoverflow.com/questions/57509373/bottom-navigation-bar-transition-in-flutter
/*BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.viewModule),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer),
                label: '',
              )
            ],
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.black.withOpacity(0.1),
            currentIndex: _selectedIndex,
            selectedItemColor: buttonBlue,
            unselectedItemColor: whiteOpacity,
            onTap: navigate,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),*/
