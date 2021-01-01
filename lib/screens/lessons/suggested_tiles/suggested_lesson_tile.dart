import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';

class SuggestedLessonCarousel extends StatefulWidget {
  @override
  _SuggestedLessonCarouselState createState() => _SuggestedLessonCarouselState();
}

class _SuggestedLessonCarouselState extends State<SuggestedLessonCarousel> {
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
      height: 275,
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Center(
        child: buildSuggestedLessonList(
          buildSLTile(
              mathLogo,
              'Exponents',
              'Learn how to add, subtract, multiply, and divide terms with exponents the correct way.',
              '10',
              '5',
              'This was recommended to you based on your last diagnostic test.',
              mathColor),
          buildSLTile(
              readingLogo,
              'Literature Passage',
              'Learn the most effective way to read a literature passage and answer the questions that come with it.',
              '13',
              '11',
              'This was recommended to you based on your last practice test.',
              readingColor),
          buildSLTile(
              englishLogo,
              'Semicolons',
              'Learn when, where, and how to use semicolons effectively and how you will be tested on them.',
              '5',
              '5',
              'This was recommended to you because you missed similar questions.',
              englishColor),
        ),
      ),
    );
  }

Container buildSLTile(
    Widget logo,
    String lessonTitle,
    String lessonDesc,
    String time,
    String questions,
    String recommendText,
    Color subjectColor) {
  return Container(
    width: 265,
    padding: EdgeInsets.all(10.0),
    margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(children: [
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            logo,
            /*content from database eventually*/ Text(lessonTitle,
                style: TextStyle(
                    fontFamily: 'popSBold', fontSize: 15.0, color: white))
          ],
        ),
      ),
      /*content from database eventually*/ Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
        child: Text(lessonDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'popReg', fontSize: 12.0, color: whiteOpacity)),
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                    child: Icon(Icons.schedule, color: white, size: 15),
                  ),
                  /*content from database eventually*/ Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(time + ' mins',
                        style: TextStyle(
                            fontFamily: 'popMed', fontSize: 12.0, color: white)),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                    child: Icon(Icons.help, color: white, size: 15),
                  ),
                  /*content from database eventually*/ Text(
                      questions + ' questions',
                      style: TextStyle(
                          fontFamily: 'popMed', fontSize: 12.0, color: white))
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
        child: Text(recommendText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'popReg', fontSize: 12.0, color: whiteOpacity)),
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
                style: TextStyle(
                    color: Color(0xffE2E2E2),
                    fontFamily: 'popSBold',
                    fontSize: 15.0),
              ),
              onPressed: () {}),
        ),
      )
    ]),
  );
}

  Widget buildSuggestedLessonList(Widget card, Widget card2, Widget card3) {
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
