import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/home/modals.dart';
import 'package:project_polymer/screens/settings/settings.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  Future navigate(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountSettings()));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamProvider<List<Data>>.value(
                value: DatabaseService().data,
                child: Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: canvasColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(MdiIcons.arrowLeft,
                                color: white, size: 25),
                            splashColor: canvasColor,
                            splashRadius: 0.1,
                            onPressed: () {
                              navigate(context);
                            },
                          ),
                          isLightTheme
                              ? Image.asset(
                                  'assets/logo_light.png',
                                  fit: BoxFit.contain,
                                  height: 30,
                                )
                              : Image.asset(
                                  'assets/logo.png',
                                  fit: BoxFit.contain,
                                  height: 30,
                                ),
                          IconButton(
                            icon: Icon(Icons.notifications,
                                color: white, size: 30),
                            splashColor: canvasColor,
                            splashRadius: 0.1,
                            onPressed: () {
                              notificationsModal(context);
                            },
                          )
                        ],
                      ),
                    ),
                    backgroundColor: canvasColor,
                    body: Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 12.5),
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Text(
                                              'Preferences',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  color: white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 25.0),
                                            ),
                                          ),
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Theme',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteOpacity)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: IsLight(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Notifications',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteOpacity)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('System Notifications',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  color: white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17.0)),
                                          SendNotifications(),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )))));
          } else {
            return Loading();
          }
        });
  }
}

class IsLight extends StatefulWidget {
  @override
  _IsLightState createState() => _IsLightState();
}

class _IsLightState extends State<IsLight> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService databaseService = new DatabaseService();
    bool isDark = false;
    bool isLight = false;

    databaseService.returnPreferences(user.uid).get().then((val) {
      setState(() {
        if(val.data['isLight'] == true) {
          isLight = true;
          isDark = false;
        }
        else {
          isLight = false;
          isDark = true;
        }
      });
      return isLight && isDark;
    });

    void setTheme() {
      if (isLight == true) {
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

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return StreamProvider<List<Data>>.value(
                value: DatabaseService().data,
                child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() async {
                                isLight = true;
                                isDark = false;
                                setTheme();
                                String firstName = userData.firstName;
                                String lastName = userData.lastName;
                                String username = userData.username;
                                int points = userData.points;
                                int lessonsToResume = userData.lessonsToResume;
                                String subscriptionLevel = userData.subscriptionLevel;
                                bool isLightT = isLight;
                                bool sendNotifications = userData.sendNotifications;
                                await DatabaseService(uid: user.uid).updateUserData(
                                    firstName,
                                    lastName,
                                    username,
                                    points,
                                    lessonsToResume,
                                    subscriptionLevel,
                                    isLightT,
                                    sendNotifications);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Light',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                        color: white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.0)),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: isDark ? white : Colors.transparent),
                                    shape: BoxShape.circle,
                                    color:
                                        isDark ? Colors.transparent : white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() async {
                                isLight = false;
                                isDark = true;
                                setTheme();
                              setTheme();
                              String firstName = userData.firstName;
                              String lastName = userData.lastName;
                              String username = userData.username;
                              int points = userData.points;
                              int lessonsToResume = userData.lessonsToResume;
                              String subscriptionLevel = userData.subscriptionLevel;
                              bool isLightT = isLight;
                              bool sendNotifications = userData.sendNotifications;
                              await DatabaseService(uid: user.uid).updateUserData(
                                  firstName,
                                  lastName,
                                  username,
                                  points,
                                  lessonsToResume,
                                  subscriptionLevel,
                                  isLightT,
                                  sendNotifications);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Dark',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      color: white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0)),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(color: isDark ? Colors.transparent : white),
                                  shape: BoxShape.circle,
                                  color:
                                      isDark ? white : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
          } else {
            return null;
          }
        });
  }
}

/*class IsLight extends StatefulWidget {
  @override
  _IsLightState createState() => _IsLightState();
}

class _IsLightState extends State<IsLight> with SingleTickerProviderStateMixin {
  Duration _duration = Duration(milliseconds: 170);
  Animation<Alignment> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService databaseService = new DatabaseService();
    bool isChecked = false;

    databaseService.returnPreferences(user.uid).get().then((val) {
      setState(() {
        isChecked = val.data['isLight'];
        var begin = isChecked ? Alignment.centerRight : Alignment.centerLeft;
        var end = isChecked ? Alignment.centerLeft : Alignment.centerRight;

        _animationController =
            AnimationController(vsync: this, duration: _duration);

        _animation = AlignmentTween(begin: begin, end: end).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut),
        );
      });
      return isChecked;
    });

    void setTheme() {
      if (isChecked == true) {
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

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return StreamProvider<List<Data>>.value(
                value: DatabaseService().data,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return GestureDetector(
                      onTap: () {
                        setState(() async {
                          if (_animationController.isCompleted) {
                            _animationController.reverse();
                          } else {
                            _animationController.forward();
                          }
                          isChecked = !isChecked;
                          setTheme();
                          String firstName = userData.firstName;
                          String lastName = userData.lastName;
                          String username = userData.username;
                          int points = userData.points;
                          int lessonsToResume = userData.lessonsToResume;
                          String subscriptionLevel = userData.subscriptionLevel;
                          bool isLight = isChecked;
                          bool sendNotifications = userData.sendNotifications;
                          await DatabaseService(uid: user.uid).updateUserData(
                              firstName,
                              lastName,
                              username,
                              points,
                              lessonsToResume,
                              subscriptionLevel,
                              isLight,
                              sendNotifications);
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 25,
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        decoration: BoxDecoration(
                            color: isChecked ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            )),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: _animation.value,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isChecked
                                      ? Colors.white
                                      : Color(0xffE2E2E2),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ));
          } else {
            return null;
          }
        });
  }
}*/

class SendNotifications extends StatefulWidget {
  @override
  _SendNotificationsState createState() => _SendNotificationsState();
}

class _SendNotificationsState extends State<SendNotifications>
    with SingleTickerProviderStateMixin {
  Duration _duration = Duration(milliseconds: 170);
  Animation<Alignment> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService databaseService = new DatabaseService();
    bool isChecked = false;

    databaseService.returnPreferences(user.uid).get().then((val) {
      setState(() {
        isChecked = val.data['sendNotifications'];
        var begin = isChecked ? Alignment.centerRight : Alignment.centerLeft;
        var end = isChecked ? Alignment.centerLeft : Alignment.centerRight;

        _animationController =
            AnimationController(vsync: this, duration: _duration);

        _animation = AlignmentTween(begin: begin, end: end).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut),
        );
      });
      return isChecked;
    });

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return StreamProvider<List<Data>>.value(
                value: DatabaseService().data,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return GestureDetector(
                      onTap: () {
                        setState(() async {
                          if (_animationController.isCompleted) {
                            _animationController.reverse();
                          } else {
                            _animationController.forward();
                          }
                          isChecked = !isChecked;
                          String firstName = userData.firstName;
                          String lastName = userData.lastName;
                          String username = userData.username;
                          int points = userData.points;
                          int lessonsToResume = userData.lessonsToResume;
                          String subscriptionLevel = userData.subscriptionLevel;
                          bool isLight = userData.isLight;
                          bool sendNotifications = isChecked;
                          await DatabaseService(uid: user.uid).updateUserData(
                              firstName,
                              lastName,
                              username,
                              points,
                              lessonsToResume,
                              subscriptionLevel,
                              isLight,
                              sendNotifications);
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 25,
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        decoration: BoxDecoration(
                            color: isChecked ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            )),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: _animation.value,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isChecked
                                      ? Colors.white
                                      : Color(0xffE2E2E2),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ));
          } else {
            return null;
          }
        });
  }
}
