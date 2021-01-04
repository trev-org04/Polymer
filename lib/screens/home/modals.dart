import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/auth/start.dart';
import 'package:project_polymer/screens/home/point_history.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';

void notificationsModal(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
            child: Column(
              children: [
                Container(
                  height: 6.5,
                  width: 60.0,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                      color: Color.fromRGBO(226, 226, 226, 0.65)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Notifications',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                buildNotificationTile(
                    notiLogo, 'Notification', 'Content for notification'),
                buildNotificationTile(
                    notiLogo, 'Notification', 'Content for notification')
              ],
            ),
          ),
        );
      });
}

Container buildNotificationTile(Widget logo, String title, String desc) {
  return Container(
    padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            logo,
            /*content from database eventually*/ Text(title,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 15.0, color: white))
          ],
        ),
      ),
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
        child: Text(desc,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400, fontSize: 12.0, color: whiteOpacity)),
      ),
    ]),
  );
}

void suggestedLessonsModal(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
              child: Column(
                children: [
                  Container(
                    height: 6.5,
                    width: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(110.0),
                        color: Color.fromRGBO(226, 226, 226, 0.65)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                        child: Text(
                          'Suggested Lessons',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0),
                        ),
                      ),
                    ],
                  ),
                  buildSuggestedLessonsTile(
                      readingLogo,
                      'Science Passage',
                      'Learn how to interpret science passages and quickly identify the correct answers.',
                      '13',
                      '11',
                      'This lesson was recommended to you based on your placement test.',
                      readingColor)
                ],
              ),
            ),
          ),
        );
      });
}

Container buildSuggestedLessonsTile(
    Widget logo,
    String lessonTitle,
    String lessonDesc,
    String time,
    String questions,
    String recommendText,
    Color subjectColor) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.all(10),
    child: Column(children: [
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            logo,
            /*content from database eventually*/ Text(lessonTitle,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 15.0, color: white))
          ],
        ),
      ),
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Text(lessonDesc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400, fontSize: 12.0, color: whiteOpacity)),
      ),
      /*entire element from db eventually*/ Padding(
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.schedule, color: white, size: 15),
                  ),
                  /*content from database eventually*/ Text(time + ' mins',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12.0, color: white))
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                    child: Icon(MdiIcons.help, color: white, size: 15),
                  ),
                  /*content from database eventually*/ Text(
                      questions + ' questions',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 12.0, color: white))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Text(recommendText,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400, fontSize: 12.0, color: whiteOpacity)),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
        child: ButtonTheme(
          minWidth: 200.0,
          height: 40.0,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              textColor: white,
              color: subjectColor,
              child: Text(
                'Start Lesson',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Color(0xffE2E2E2),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0),
              ),
              onPressed: () {}),
        ),
      )
    ]),
  );
}

class AccountName extends StatefulWidget {
  @override
  _AccountNameState createState() => _AccountNameState();
}

class _AccountNameState extends State<AccountName> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return StreamProvider<List<Data>>.value(
                value: DatabaseService().data,
                child: Text(
                  userData.firstName + ' ' + userData.lastName,
                  style: GoogleFonts.poppins(
                      color: white, fontWeight: FontWeight.w600, fontSize: 15.0),
                ));
          } else {
            return null;
          }
        });
  }
}

void accountModal(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        final AuthService _auth = AuthService();
        Future navigate(context) async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Start()));
        }
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
            child: Column(
              children: [
                Container(
                  height: 6.5,
                  width: 60.0,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                      color: Color.fromRGBO(226, 226, 226, 0.65)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Account',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                /*icon and desc from db soon*/ buildAccountTile(
                    Icons.account_circle, 'Premium Plan'),
                /*icon and desc from db soon*/ buildPointTile(
                    MdiIcons.currencyUsdCircle, '10,315', context),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ButtonTheme(
                    minWidth: 250.0,
                    height: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      textColor: Color(0xffE2E2E2),
                      color: Color(0xff0099FF),
                      child: Text(
                        'Sign Out',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Color(0xffE2E2E2),
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0),
                      ),
                      onPressed: () async {
                        await _auth.signOut();
                        navigate(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget buildAccountTile(IconData icon, String desc) {
  return Container(
    height: 140.0,
    padding: EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5.0),
    child: Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: Icon(
                  icon,
                  size: 40,
                  color: Color(0xffE2E2E2),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AccountName(),
                    Text(desc,
                        style: GoogleFonts.poppins(
                            color: whiteOpacity,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ],
                ),
              )
            ]),
        ButtonTheme(
          minWidth: 250.0,
          height: 40.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.0),
            ),
            textColor: Color(0xffE2E2E2),
            color: Color(0xff0099FF),
            child: Text(
              'Account Settings',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: Color(0xffE2E2E2),
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
            ),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

  Future viewPointHistory(context) async {
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PointHistory()), (route)=>false);
  }

Widget buildPointTile(IconData icon, String points, dynamic _context) {
  return Container(
    height: 140.0,
    padding: EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5.0),
    child: Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: Icon(
                  icon,
                  size: 40,
                  color: Color(0xffE2E2E2),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Points',
                        style: GoogleFonts.poppins(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0),
                      ),
                      Text(points + ' Points',
                          style: GoogleFonts.poppins(
                              color: whiteOpacity,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ],
                  )),
            ]),
        ButtonTheme(
          minWidth: 250.0,
          height: 40.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.0),
            ),
            textColor: Color(0xffE2E2E2),
            color: Color(0xff0099FF),
            child: Text(
              'View Point History',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: Color(0xffE2E2E2),
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
            ),
            onPressed: () {
              viewPointHistory(_context);
              },
          ),
        ),
      ],
    ),
  );
}

void planProgressModal(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
              child: Column(
                children: [
                  Container(
                    height: 6.5,
                    width: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(110.0),
                        color: Color.fromRGBO(226, 226, 226, 0.65)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                        child: Text(
                          'Plan Progress',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 125,
                          width: 125,
                          child: CircularProgressIndicator(
                            value: 1 * .88, //from db soon
                            backgroundColor: elementColor,
                            strokeWidth: 10,
                          ),
                        ),
                        Column(
                          children: [
                            Text('88%',
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20)),
                            Text('completed',
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
