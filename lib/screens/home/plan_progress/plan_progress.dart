import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanProgress extends StatefulWidget {
  @override
  _PlanProgressState createState() => _PlanProgressState();
}

class _PlanProgressState extends State<PlanProgress> {
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: buildPlanTile(buttonBlue, _key, 'Adaptive Plan', '57', (MediaQuery.of(context).size.width - 93)*.57)
    );
  }

  Widget buildPlanTile(
      Color color, Key key, String title, String percentage, double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: (MediaQuery.of(context).size.width) - 35,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          color: elementColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5.0),
        child: Column(children: [
          /*content from database eventually*/ Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(title,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                          color: white)),
                ],
              )),
          /*content from database eventually*/ Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(percentage + '% Completed',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: whiteOpacity)),
              ],
            ),
          ),
          Stack(children: [
            Container(
                decoration: BoxDecoration(
                  color: isLightTheme ? whiteOpacity : canvasColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                width: (MediaQuery.of(context).size.width) - 93,
                height: 4.0,
                key: key),
            Container(
              decoration: BoxDecoration(
                /*content from database eventually*/ color: color,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              width: width,
              height: 4.0,
            )
          ]),
        ]),
      ),
    );
  }
}
