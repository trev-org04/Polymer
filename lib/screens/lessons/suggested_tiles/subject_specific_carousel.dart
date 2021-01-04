import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectCarousel extends StatefulWidget {
  @override
  _SubjectCarouselState createState() => _SubjectCarouselState();
}

class _SubjectCarouselState extends State<SubjectCarousel> {
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
      height: 146,
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Center(
        child: buildCarousel(
          buildTile(englishLogoBig, 'Lesson Title', 'This is a lesson description. This is a lesson description. This is a lesson description.', '35', englishColor),
          buildTile(englishLogoBig, 'Lesson Title', 'This is a lesson description. This is a lesson description. This is a lesson description.', '35', englishColor),
          buildTile(englishLogoBig, 'Lesson Title', 'This is a lesson description. This is a lesson description. This is a lesson description.', '35', englishColor),
        ),
      ),
    );
  }

Container buildTile(Widget logo, String lessonTitle, String lessonDesc, String time, Color subjectColor) {
  return Container(
    width: 235,
    padding: EdgeInsets.all(10.0),
    margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      children: [
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(lessonTitle,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 20.0, color: white)),
            /*entire element from db eventually*/Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                    child: Icon(Icons.schedule, color: whiteOpacity, size: 15),
                  ),
                  /*content from database eventually*/ Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(time + ' mins',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 12.0, color: whiteOpacity)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
              ],
            ),
            logo,
          ],
        ),
      ),
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
        child: Text(lessonDesc,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400, fontSize: 12.0, color: whiteOpacity)),
      ),
    ]),
  );
}

  Widget buildCarousel(Widget card, Widget card2, Widget card3) {
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
