import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/screens/diagnostic/finish_diagnostic.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:provider/provider.dart';

class Diagnostic extends StatefulWidget {
  final String lessonID;
  final String subject;
  final String lessonName;
  Diagnostic({this.lessonID, this.subject, this.lessonName});
  @override
  _DiagnosticState createState() => _DiagnosticState();
}

int total = 0;
int attempted = 0;
int correctAnswers = 0;
int lessonsToResume = 0;
String lessonId = '';

class _DiagnosticState extends State<Diagnostic> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot lessonSnapshot;

  Question getLessonInfoFromSnapshot(DocumentSnapshot docSnap) {
    Question question = new Question();
    question.question = docSnap.data['question'];
    print(docSnap.data['answerChosen']);
    List<String> answers = [
      docSnap.data['option1'],
      docSnap.data['option2'],
      docSnap.data['option3'],
      docSnap.data['option4'],
    ];

    answers.shuffle();

    question.option1 = answers[0];
    question.option2 = answers[1];
    question.option3 = answers[2];
    question.option4 = answers[3];
    question.correctOption = docSnap.data['correctAnswer'];

    bool an = false;
    bool isA = false;
    bool isS1 = false;
    bool isS2 = false;
    bool isS3 = false;
    bool isS4 = false;

    databaseService.setProgress(lessonId).then((pSnapshot) async {
        var progressSnapshot = await pSnapshot.get();
        var data = Progress.fromSnapshot(progressSnapshot);
        print(docSnap.data['answerChosen']);
        if (data.inProgress == true) {
          print('inProgress == true');
          if (docSnap.data['answerChosen'] != '') {
            print('inProgress is not empty');
            if (docSnap.data['answerChosen'] == answers[0]) {
              print('answers[0]');
              an = true;
              isA = true;
              isS1 = true;
              isS2 = false;
              isS3 = false;
              isS4 = false;
            }
            else if (docSnap.data['answerChosen'] == answers[1]) {
              print('answers[1]');
              an = true;
              isA = true;
              isS2 = true;
              isS1 = false;
              isS3 = false;
              isS4 = false;
            }
            else if (docSnap.data['answerChosen'] == answers[2]) {
              print('answers[2]');
              an = true;
              isA = true;
              isS3 = true;
              isS1 = false;
              isS2 = false;
              isS4 = false;
            }
            else if (docSnap.data['answerChosen'] == answers[3]) {
              print('answers[3]');
              an = true;
              isA = true;
              isS4 = true;
              isS1 = false;
              isS2 = false;
              isS3 = false;
            }
            else {
              print('something isnt working');
              an = false;
              isA = false;
              isS4 = false;
              isS1 = false;
              isS2 = false;
              isS3 = false;
            }
          }
          else if (docSnap.data['answerChosen'] == '') {
            print('answerChosen is ""');
            an = false;
            isA = false;
            isS4 = false;
            isS1 = false;
            isS2 = false;
            isS3 = false;
          }
          else {
            print('answerChosen is not defined yet');
            an = false;
            isA = false;
            isS4 = false;
            isS1 = false;
            isS2 = false;
            isS3 = false;
          }
        }
        else {
          print('inProgress == false');
          an = false;
          isA = false;
          isS1 = false;
          isS2 = false;
          isS3 = false;
          isS4 = false;
        }
        question.answered = an;
        question.isAttempted = isA;
        question.isSelected1 = isS1;
        question.isSelected2 = isS2;
        question.isSelected3 = isS3;
        question.isSelected4 = isS4;
      });

    print(docSnap.data['answerChosen']);

    question.plus = false;
    question.questionID = docSnap.data['questionID'];

    return question;
  }

  @override
  void initState() {
    databaseService.getLessonData(widget.lessonID).then((lSnapshot) {
      lessonSnapshot = lSnapshot;
      total = lessonSnapshot.documents.length;
      attempted = total;
      correctAnswers = 0;
      lessonId = widget.lessonID;
      setState(() {});
    });
    super.initState();
  }

  lessonID() {
    setState(() {
      String lessonId = widget.lessonID;
      return lessonId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            updateUserData(String firstName, String lastName, String email, String username, int points, int lessonsToResume, String subscriptionLevel, bool isLightTheme, bool sendNotifications) async{ 
              await DatabaseService(uid: user.uid).updateUserData(firstName, lastName, email, username, points, lessonsToResume, subscriptionLevel, isLightTheme, sendNotifications);
            }

            updateLessonsToResume() async {
              databaseService.setProgress(lessonId).then((pSnapshot) async {
                  var progressSnapshot = await pSnapshot.get();
                  var data = Progress.fromSnapshot(progressSnapshot);
              if (data.inProgress == false) {
                String firstName = userData.firstName;
                String lastName = userData.lastName;
                String email = userData.email;
                String username = userData.username;
                int points = userData.points;
                int currentLessons = userData.lessonsToResume;
                int lessonsToResume = currentLessons + 1;
                String subscriptionLevel = userData.subscriptionLevel;
                bool isLight = userData.isLight;
                bool sendNotifications = userData.sendNotifications;

                updateUserData(firstName, lastName, email, username, points, lessonsToResume, subscriptionLevel, isLight, sendNotifications);
                databaseService.setProgress(widget.lessonID).then((val){
                  setState(() {
                    val.updateData({'inProgress': true});
                  });
                });
                //save answers
              }
              else {
                String firstName = userData.firstName;
                String lastName = userData.lastName;
                String email = userData.email;
                String username = userData.username;
                int points = userData.points;
                int lessonsToResume = userData.lessonsToResume;
                String subscriptionLevel = userData.subscriptionLevel;
                bool isLight = userData.isLight;
                bool sendNotifications = userData.sendNotifications;
                updateUserData(firstName, lastName, email, username, points, lessonsToResume, subscriptionLevel, isLight, sendNotifications);
                //save answers 
              }
                });
            }

            /*saveAnswers() {
              Firestore.instance.collection("Lessons").document(widget.lessonID).collection('Answers').document().setData({'option': optionSelected});
            }*/

          return StreamProvider<List<Data>>.value(
            value: DatabaseService().data,
            child: Scaffold(
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
                    icon: Icon(Icons.close, color: white, size: 30),
                    splashColor: canvasColor,
                    splashRadius: 0.1,
                    onPressed: () {
                      updateLessonsToResume();
                      returnHome(context);
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
                    icon: Icon(Icons.notifications,
                        color: white, size: 30),
                    splashColor: canvasColor,
                    splashRadius: 0.1,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 12.5),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        lessonSnapshot == null
                            ? Loading()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: lessonSnapshot.documents.length,
                                itemBuilder: (context, index) {
                                  return QuestionTile(
                                      index: index,
                                      question: getLessonInfoFromSnapshot(
                                          lessonSnapshot.documents[index]));
                                }),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: ButtonTheme(
                            splashColor: whiteOpacity,
                            minWidth: 225.0,
                            height: 40.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                                textColor: white,
                                color: buttonBlue,
                                child: Text(
                                  'Submit',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                ),
                                onPressed: () {
                                  if (attempted == 0) {
                                    finishLesson(
                                        context,
                                        widget.lessonID,
                                        correctAnswers.toString(),
                                        lessonSnapshot.documents.length.toString(), 
                                        widget.subject,
                                        widget.lessonName);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(13.0))),
                                            backgroundColor: canvasColor,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              width: 100,
                                              height: 134,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 15),
                                                        width: 400,
                                                        child: Text(
                                                            'Please answer all questions before submitting.',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style:
                                                                GoogleFonts.poppins(
                                                                    color: white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        17.0)),
                                                      ),
                                                    ],
                                                  ),
                                                  buildButtons(context)
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                }),
                          ),
                        )
                      ],
                    ))))));
        }
          else {
            return Loading();
          }
        }
      );
  }

  Future returnHome(context) async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Base()), (route) => false);
  }

  Future finishLesson(
      context, String lessonID, String correctAnswers, String answers, String subject, String lessonName) async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => FinishDiagnostic(
                lessonID: lessonID, correct: correctAnswers, total: answers, subject: subject, lessonName: lessonName)),
        (route) => false);
  }
}

Widget buildButtons(var context) {
  return FlatButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        child: Text('Close',
            style: GoogleFonts.poppins(
                color: white, fontWeight: FontWeight.w500)),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      });
}

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  final bool isSelected;
  OptionTile(
      {this.option,
      this.description,
      this.correctAnswer,
      this.optionSelected,
      this.isSelected});
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.isSelected ? buttonBlue : elementColor,
            borderRadius: BorderRadius.circular(13)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: white, width: widget.isSelected ? 2 : 1),
                      borderRadius: BorderRadius.circular(110)),
                  child: Center(
                    child: Text(
                      '${widget.option}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: white,
                          fontSize: 12,
                          fontWeight: widget.isSelected
                              ? FontWeight.w600
                              : FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(widget.description,
                    style: GoogleFonts.poppins(
                        color: white,
                        fontSize: 15,
                        fontWeight: widget.isSelected
                            ? FontWeight.w600
                            : FontWeight.w500)),
              ),
            ],
          ),
        ));
  }
}

class QuestionTile extends StatefulWidget {
  final Question question;
  final int index;
  QuestionTile({this.question, this.index});
  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  String optionSelected = '';

  /*setOptionSelected() {
    DatabaseService databaseService = new DatabaseService();
      databaseService.setProgress(lessonId).then((pSnapshot) async {
        var progressSnapshot = await pSnapshot.get();
        var data = Progress.fromSnapshot(progressSnapshot);
        if (data.inProgress == true) {
          databaseService.getLessonData(lessonId).then((lSnapshot) {
            optionSelected = lSnapshot.documents(lessonId).data['answerChosen'];
          });
        }
        else {
          optionSelected = '';
        }
        });
  }*/

  @override
  Widget build(BuildContext context) {
    //setOptionSelected();
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  '${widget.index + 1}' + '. ' + widget.question.question,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      optionSelected = widget.question.option1;
                      /*DatabaseService databaseService = new DatabaseService();
                      DocumentSnapshot progressSnapshot;
                      databaseService.progressSnapshot().where('lessonID', isEqualTo: lessonId).then((pSnapshot) {
                        progressSnapshot = pSnapshot;
                      });
                      if (progressSnapshot.data['inProgress'] == false) {
                        Firestore.instance.collection('Lessons').document(lessonId).collection('Questions').document(widget.question.questionID).updateData({'answerChosen': optionSelected});
                      }*/
                      Firestore.instance.collection('Lessons').document(lessonId).collection('Questions').document(widget.question.questionID).updateData({'answerChosen': optionSelected});
                      widget.question.isSelected1 =
                          !widget.question.isSelected1;
                      if (widget.question.isSelected1 == true ||
                          widget.question.isSelected2 == true ||
                          widget.question.isSelected3 == true ||
                          widget.question.isSelected4 == true) {
                        widget.question.answered = true;
                      } else if (widget.question.isSelected1 == false &&
                          widget.question.isSelected2 == false &&
                          widget.question.isSelected3 == false &&
                          widget.question.isSelected4 == false) {
                        widget.question.answered = false;
                      }
                      if (widget.question.answered == true) {
                        attempted--;
                        widget.question.isAttempted = true;
                      } else if (widget.question.answered == false) {
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isSelected2 == true ||
                          widget.question.isSelected3 == true ||
                          widget.question.isSelected4 == true) {
                        widget.question.isSelected2 = false;
                        widget.question.isSelected3 = false;
                        widget.question.isSelected4 = false;
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isAttempted == false &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      } else if (widget.question.isAttempted == false &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      }
                    });
                  },
                  child: OptionTile(
                    correctAnswer: widget.question.correctOption,
                    description: widget.question.option1,
                    option: 'A',
                    optionSelected: optionSelected,
                    isSelected: widget.question.isSelected1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      optionSelected = widget.question.option2;
                      widget.question.isSelected2 =
                          !widget.question.isSelected2;
                      Firestore.instance.collection('Lessons').document(lessonId).collection('Questions').document(widget.question.questionID).updateData({'answerChosen': optionSelected});
                      if (widget.question.isSelected1 == true ||
                          widget.question.isSelected2 == true ||
                          widget.question.isSelected3 == true ||
                          widget.question.isSelected4 == true) {
                        widget.question.answered = true;
                      } else if (widget.question.isSelected1 == false &&
                          widget.question.isSelected2 == false &&
                          widget.question.isSelected3 == false &&
                          widget.question.isSelected4 == false) {
                        widget.question.answered = false;
                      }
                      if (widget.question.answered == true) {
                        attempted--;
                        widget.question.isAttempted = true;
                      } else if (widget.question.answered == false) {
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isSelected1 == true ||
                          widget.question.isSelected3 == true ||
                          widget.question.isSelected4 == true) {
                        widget.question.isSelected1 = false;
                        widget.question.isSelected3 = false;
                        widget.question.isSelected4 = false;
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isAttempted == false &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      } else if (widget.question.isAttempted == false &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      }
                    });
                  },
                  child: OptionTile(
                    correctAnswer: widget.question.correctOption,
                    description: widget.question.option2,
                    option: 'B',
                    optionSelected: optionSelected,
                    isSelected: widget.question.isSelected2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      optionSelected = widget.question.option3;
                      widget.question.isSelected3 =
                          !widget.question.isSelected3;
                      Firestore.instance.collection('Lessons').document(lessonId).collection('Questions').document(widget.question.questionID).updateData({'answerChosen': optionSelected});
                      if (widget.question.isSelected1 == true ||
                          widget.question.isSelected2 == true ||
                          widget.question.isSelected3 == true ||
                          widget.question.isSelected4 == true) {
                        widget.question.answered = true;
                      } else if (widget.question.isSelected1 == false &&
                          widget.question.isSelected2 == false &&
                          widget.question.isSelected3 == false &&
                          widget.question.isSelected4 == false) {
                        widget.question.answered = false;
                      }
                      if (widget.question.answered == true) {
                        attempted--;
                        widget.question.isAttempted = true;
                      } else if (widget.question.answered == false) {
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isSelected1 == true ||
                          widget.question.isSelected2 == true ||
                          widget.question.isSelected4 == true) {
                        widget.question.isSelected1 = false;
                        widget.question.isSelected2 = false;
                        widget.question.isSelected4 = false;
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isAttempted == false &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      } else if (widget.question.isAttempted == false &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      }
                    });
                  },
                  child: OptionTile(
                    correctAnswer: widget.question.correctOption,
                    description: widget.question.option3,
                    option: 'C',
                    optionSelected: optionSelected,
                    isSelected: widget.question.isSelected3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      optionSelected = widget.question.option4;
                      widget.question.isSelected4 =
                          !widget.question.isSelected4;
                      Firestore.instance.collection('Lessons').document(lessonId).collection('Questions').document(widget.question.questionID).updateData({'answerChosen': optionSelected});
                      if (widget.question.isSelected1 == true ||
                          widget.question.isSelected2 == true ||
                          widget.question.isSelected3 == true ||
                          widget.question.isSelected4 == true) {
                        widget.question.answered = true;
                      } else if (widget.question.isSelected1 == false &&
                          widget.question.isSelected2 == false &&
                          widget.question.isSelected3 == false &&
                          widget.question.isSelected4 == false) {
                        widget.question.answered = false;
                      }
                      if (widget.question.answered == true) {
                        attempted--;
                        widget.question.isAttempted = true;
                      } else if (widget.question.answered == false) {
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isSelected1 == true ||
                          widget.question.isSelected2 == true ||
                          widget.question.isSelected3 == true) {
                        widget.question.isSelected1 = false;
                        widget.question.isSelected2 = false;
                        widget.question.isSelected3 = false;
                        attempted++;
                        widget.question.isAttempted = false;
                      }
                      if (widget.question.isAttempted == false &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected == widget.question.correctOption &&
                          widget.question.plus == false) {
                        correctAnswers++;
                        widget.question.plus = true;
                      } else if (widget.question.isAttempted == true &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      } else if (widget.question.isAttempted == false &&
                          optionSelected != widget.question.correctOption &&
                          widget.question.plus == true) {
                        correctAnswers--;
                        widget.question.plus = false;
                      }
                    });
                  },
                  child: OptionTile(
                    correctAnswer: widget.question.correctOption,
                    description: widget.question.option4,
                    option: 'D',
                    optionSelected: optionSelected,
                    isSelected: widget.question.isSelected4,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
