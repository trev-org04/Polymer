import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicCards extends StatefulWidget {
  @override
  _TopicCardsState createState() => _TopicCardsState();
}

class _TopicCardsState extends State<TopicCards> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: .5);

  int _selectedIndex = 0;

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
      height: 30,
      margin: EdgeInsets.only(bottom: 15),
      child: buildTopicCardList(
        buildCard('Recent', buttonBlue, 0, true),
        buildCard('Math', mathColor, 1, false),
        buildCard('Science', scienceColor, 2, false),
        buildCard('English', englishColor, 3, false),
        buildCard('Reading', readingColor, 4, false),
      ),
    );
  }

  Widget buildCard(String title, Color color, int index, bool isActive) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      splashColor: color,
      radius: 0.1,
      child: Opacity(
        opacity: _selectedIndex == index ? 1 : .4,
        child: Container(
          padding: EdgeInsets.all(7.0),
          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.poppins(color: isLightTheme ? canvasColor : white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget buildTopicCardList(
      Widget card, Widget card2, Widget card3, Widget card4, Widget card5) {
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
          SizedBox(
            child: card4,
          ),
          SizedBox(
            child: card5,
          ),
        ]);
  }
}
