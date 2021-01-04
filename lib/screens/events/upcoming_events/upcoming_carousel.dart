import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/shared/constants.dart';

class UpcomingCarousel extends StatefulWidget {
  @override
  _UpcomingCarouselState createState() => _UpcomingCarouselState();
}

class _UpcomingCarouselState extends State<UpcomingCarousel> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: .5);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: Center(
        child: buildUpcomingList(
          buildQuestionTile(scienceLogoBig, 'Science Diagnostic', 'January 1, 2021'),
          buildQuestionTile(readingLogoBig, 'Practice Section', 'January 1, 2021'),
          buildQuestionTile(englishLogoBig, 'Appositives Diagnostic', 'January 1, 2021')
        ),
      ),
    );
  }

 Widget buildQuestionTile(Widget icon, String event, String date) {
    return Container(
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
      decoration: BoxDecoration(
        color: elementColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                  child: icon,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(event,
                          style: GoogleFonts.poppins(
                              color: Color(0xffE2E2E2),
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      Text(date,
                          style: GoogleFonts.poppins(
                              color: Color.fromRGBO(226, 226, 226, 0.65),
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    ],
                  ),
                )
              ]
            ),
        ],
      ),
    );
  }

  Widget buildUpcomingList(Widget card, Widget card2, Widget card3) {
    return ListView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            child: card,
          ),
          SizedBox(
            child: card2,
          ),
          SizedBox(
            child: card3,
          ),
        ]);
  }
}
