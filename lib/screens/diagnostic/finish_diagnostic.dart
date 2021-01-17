import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:provider/provider.dart';

class FinishDiagnostic extends StatefulWidget {
  final String lessonID;
  final String correct;
  final String total;
  final String subject;
  final String lessonName;
  FinishDiagnostic(
      {@required this.lessonID,
      @required this.correct,
      @required this.total,
      @required this.subject,
      @required this.lessonName});
  @override
  _FinishDiagnosticState createState() => _FinishDiagnosticState();
}

class _FinishDiagnosticState extends State<FinishDiagnostic> {
  Future returnHome(context) async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Base()), (route) => false);
  }

  Text message = new Text('');
  Widget icon;
  var databaseService = new DatabaseService();

  messageToUser() {
    setState(() {
      if (int.parse(widget.correct) == int.parse(widget.total)) {
        message = Text('Well done! Keep up the good work!',
            style: GoogleFonts.poppins(
                color: whiteOpacity,
                fontSize: 15,
                fontWeight: FontWeight.w400));
      } else if (int.parse(widget.correct) == int.parse(widget.correct) - 1) {
        message = Text('Almost there! Keep it up!',
            style: GoogleFonts.poppins(
                color: whiteOpacity,
                fontSize: 15,
                fontWeight: FontWeight.w400));
      } else {
        message = Text('Stay with it!',
            style: GoogleFonts.poppins(
                color: whiteOpacity,
                fontSize: 15,
                fontWeight: FontWeight.w400));
      }
    });
  }

  fetchIcon(String subject) {
    if (subject == 'Science') {
      icon = scienceLogoDiagnostic;
    } else if (subject == 'Reading') {
      icon = readingLogoDiagnostic;
    }
    if (subject == 'Math') {
      icon = mathLogoDiagnostic;
    }
    if (subject == 'English') {
      icon = englishLogoDiagnostic;
    }
    if (subject == 'Placement') {
      icon = englishLogoDiagnostic;
    }
    return icon;
  }

  updateLessonsToResume() async {
    databaseService.setProgress(widget.lessonID).then((val) {
      setState(() {
        val.updateData({'inProgress': false});
      });
    });
  }

  @override
  void initState() {
    messageToUser();
    fetchIcon(widget.subject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int points = int.parse(widget.correct) * 100;
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            updatePoints() async {
              UserData userData = snapshot.data;
              int currentPoints = userData.points;
              int updatedPoints = currentPoints + points;
              String firstName = userData.firstName;
              String lastName = userData.lastName;
              String username = userData.username;
              int lessonsToResume = userData.lessonsToResume;
              String subscriptionLevel = userData.subscriptionLevel;

              await DatabaseService(uid: user.uid).updateUserData(firstName,
                  lastName, username, updatedPoints, lessonsToResume, subscriptionLevel);
            }

            return StreamProvider<List<Data>>.value(
                value: DatabaseService().data,
                child: Scaffold(
                    backgroundColor: Color(0xff181818),
                    appBar: AppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Color(0xff181818),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: icon,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(widget.lessonName,
                                      style: GoogleFonts.poppins(
                                          color: white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                                '${widget.correct}' + '/' + '${widget.total}',
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: Text('+' + '$points' + ' Points',
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: message,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
                            child: ButtonTheme(
                              splashColor: whiteOpacity,
                              minWidth: 225.0,
                              height: 40.0,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11.0),
                                  ),
                                  textColor: Color(0xffE2E2E2),
                                  color: Color(0xff0099FF),
                                  child: Text(
                                    'Continue',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffE2E2E2),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0),
                                  ),
                                  onPressed: () {
                                    updateLessonsToResume();
                                    updatePoints();
                                    returnHome(context);
                                  }),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Review Answers',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color:
                                          Color.fromRGBO(226, 226, 226, 0.65),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                ),
                              )),
                        ],
                      ),
                    )));
          } else {
            return Loading();
          }
        });
  }
}
