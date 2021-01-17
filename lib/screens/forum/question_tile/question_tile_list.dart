import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionTileList extends StatefulWidget {
  @override
  _QuestionTileListState createState() => _QuestionTileListState();
}

class _QuestionTileListState extends State<QuestionTileList> {

// bool vote = false; 
// bool vote1 = false; 
// bool vote2 = false; 
// bool vote3 = false; 
// bool vote4 = false; 
// bool vote5 = false; 

//  updateVoted(bool v) {
//    v = !v;
//    setState(() {});
//    return v;
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: Column(children: [
        buildQuestionTile(
            mathLogoBig,
            'Exponent Question',
            'I am not sure why this is incorrect...',
            elementColor,
            '283',
            '5 hours'),
        buildQuestionTile(
            readingLogoBig,
            'Science Passage',
            'A question on a science passage...',
            elementColor,
            '9.3k',
            '8 mins'),
        buildQuestionTile(
            scienceLogoBig,
            'HELP!!!!!',
            'This graph says the year the resear...',
            elementColor,
            '659',
            '3 days'),
        buildQuestionTile(
            englishLogoBig,
            'Comma Concerns',
            'Do I need a comma here? I though...',
            elementColor,
            '579',
            '1 week'),
        buildQuestionTile(
            readingLogoBig,
            'Tone',
            'For tone questions on literature pa...',
            elementColor,
            '1.9k',
            '1 min'),
        buildQuestionTile(
            scienceLogoBig,
            'ACT Science Section',
            'What does the science section con...',
            elementColor,
            '487',
            '9 hours'),
        Padding(
          padding: EdgeInsets.fromLTRB(44, 15, 44, 10),
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
                  'Ask A Question',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Color(0xffE2E2E2),
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                ),
                onPressed: () {}),
          ),
        ),
      ]),
    );
  }

          bool isVoted = false;

        updatedVoted() {
          setState(() {
            isVoted = !isVoted;
          });
        }

  Widget buildQuestionTile(Widget icon, String title, String desc, Color color,
      String votes, String time) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: icon,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style: GoogleFonts.poppins(
                              color: Color(0xffE2E2E2),
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      Text(desc,
                          style: GoogleFonts.poppins(
                              color: Color.fromRGBO(226, 226, 226, 0.65),
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    ],
                  ),
                )
              ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: isVoted ? buttonBlue : Colors.transparent,
                      borderRadius: BorderRadius.circular(6)),
                  child: GestureDetector(
                    onTap: () {
                      updatedVoted();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Icon(Icons.thumb_up,
                                size: 13,
                                color: isVoted ? white : whiteOpacity),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                            child: Text(votes,
                                style: GoogleFonts.poppins(
                                    color:
                                        isVoted ? white : whiteOpacity,
                                    fontWeight:
                                        isVoted ? FontWeight.w500 : FontWeight.w400,
                                    fontSize: 12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text('posted ' + time + ' ago',
                    style: GoogleFonts.poppins(
                        color: Color.fromRGBO(226, 226, 226, 0.65),
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
