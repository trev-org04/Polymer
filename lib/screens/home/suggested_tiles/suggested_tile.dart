import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';

class SuggestedTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildSuggestedLesson(mathLogo, 'Exponents', 'Learn how to properly add, subtract, divide, and multiply terms with exponents.'),
        buildSuggestedLesson(scienceLogo, 'Interpret Data', 'Learn how to interpret the data presented in various types of graphs.'),
      ],
    );
  }

  Container buildSuggestedLesson(logo, String title, String lessonDesc) {
    return Container(
    padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*content from database eventually*/ Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Row(
            children: [
              logo, 
              /*content from database eventually*/ Text(title, style: TextStyle(fontFamily: 'popSBold', fontSize: 15.0, color: white))
            ],
          ),
        ),
        /*content from database eventually*/ Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
          child: Text(lessonDesc, style: TextStyle(fontFamily: 'popReg', fontSize: 12.0, color: whiteOpacity)),
        ),
      ]
    ),
  );
  }
}