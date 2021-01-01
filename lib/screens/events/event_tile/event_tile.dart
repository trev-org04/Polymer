import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';

class EventTile extends StatefulWidget {
  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    return buildEventTile(mathLogo, 'Math Diagnostic', 'Take a math diagnostic to see what you know and where you still need practice.');
  }

 Container buildEventTile(Widget logo, String title, String desc) {
  return Container(
    margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
    padding: EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            /*content from database eventually*/ Text(title,
                style: TextStyle(
                    fontFamily: 'popSBold', fontSize: 15.0, color: white))
          ],
        ),
      ),
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
        child: Text(desc,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'popReg', fontSize: 12.0, color: whiteOpacity)),
      ),
    ]),
  );
}
}