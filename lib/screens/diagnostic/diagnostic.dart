import 'package:flutter/material.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/shared/constants.dart';

class Diagnostic extends StatefulWidget {
  final String lessonID;
  Diagnostic({@required this.lessonID});
  @override
  _DiagnosticState createState() => _DiagnosticState();
}

class _DiagnosticState extends State<Diagnostic> {
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
                icon: Icon(Icons.close, color: Color(0xffE2E2E2), size: 30),
                splashColor: Color(0xff181818),
                splashRadius: 0.1,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          backgroundColor: Color(0xff181818),
                          child: Container(
                            height: 190,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Text('Leave the lesson?',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20)),
                                    ),
                                    Container(
                                      width: 190,
                                      child: Text(
                                          'Your progress will not be saved.',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: whiteOpacity,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.0)),
                                    ),
                                  ],
                                ),
                                buildButtons()
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 30,
              ),
              IconButton(
                icon: Icon(Icons.notifications,
                    color: Color(0xffE2E2E2), size: 30),
                splashColor: Color(0xff181818),
                splashRadius: 0.1,
                onPressed: () {},
              ),
            ],
          ),
        ),
        body:Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 12.5),
                child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Column(
                    children: [
                      Text('What is 2+2?',
                          style: GoogleFonts.poppins(
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15)),
                    ],
                  )
                ])))));
  }

  Widget buildButtons() {
    return Container(
      width: 210,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              returnHome(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Colors.redAccent),
              child: Text('Leave',
                  style: GoogleFonts.poppins(
                      color: Color(0xffEDF7F6), fontWeight: FontWeight.w500)),
            ),
          ),
          FlatButton(
              child: Text('Close',
                  style: GoogleFonts.poppins(
                      color: Color(0xffEDF7F6), fontWeight: FontWeight.w500)),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  Future returnHome(context) async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Base()), (route) => false);
  }
}

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  final bool isSelected;
  OptionTile({@required this.option, @required this.description, @required this.correctAnswer, @required this.optionSelected, @required this.isSelected});
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: white),
              borderRadius: BorderRadius.circular(110)
            ),
            child: Text('${widget.option}', style: GoogleFonts.poppins(color: white, fontSize: 12, fontWeight: widget.isSelected ? FontWeight.w500 : FontWeight.w400),
          ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(widget.description, style: GoogleFonts.poppins(color: white, fontSize: 12, fontWeight: widget.isSelected ? FontWeight.w500 : FontWeight.w400)),
          ), 
        ],
      )
    );
  }
}

class QuestionTile extends StatefulWidget {
  final Question question; 
  QuestionTile({this.question});
  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  String optionSelected = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.question.question),
          OptionTile(
            correctAnswer: widget.question.option1,
            description: widget.question.option1,
            option: 'A',
            optionSelected: optionSelected,
            isSelected: false,
            ),
            OptionTile(
            correctAnswer: widget.question.option1,
            description: widget.question.option2,
            option: 'B',
            optionSelected: optionSelected,
            isSelected: false,
            ),
            OptionTile(
            correctAnswer: widget.question.option1,
            description: widget.question.option3,
            option: 'C',
            optionSelected: optionSelected,
            isSelected: false,
            ),
            OptionTile(
            correctAnswer: widget.question.option1,
            description: widget.question.option4,
            option: 'D',
            optionSelected: optionSelected,
            isSelected: false,
            ),
        ],
      ),
    );
  }
}