import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';

class ResumeTile extends StatefulWidget {
  @override
  _ResumeTileState createState() => _ResumeTileState();
}

class _ResumeTileState extends State<ResumeTile> {
  GlobalKey _key = GlobalKey();
  GlobalKey _key2 = GlobalKey();
  String wid = '10';
  double wid2;
  double wid3;

@override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSize(_);
  }

  _getSize(String size) {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    size = renderBox.size.toString();
    size = wid;
    wid2 = double.parse(wid);
    wid3 = wid2/2.0;
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        buildResumeLessons(readingColor, _key, 'Tone', '40', ((MediaQuery.of(context).size.width / 2) - 65)*.4),
        buildResumeLessons(englishColor, _key2, 'Commas', '26', ((MediaQuery.of(context).size.width / 2) - 65)*.26),
      ],
    );
  }

  Widget buildResumeLessons(Color color, Key key, String title, String percentage, double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Container(
          height: 98.0,
          width: (MediaQuery.of(context).size.width / 2) - 35,
          padding: EdgeInsets.all(10.0),
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
                    Text(title, textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'popSBold', fontSize: 15.0, color: white)),
                  ],
                )),
            /*content from database eventually*/ Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(percentage + '% Completed', textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'popReg',
                            fontSize: 12.0,
                            color: whiteOpacity)),
                  ],
                ),
            ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff181818),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  width: (MediaQuery.of(context).size.width / 2) - 65,
                  height: 4.0,
                  key: key),
                Container(
                    decoration: BoxDecoration(
                      /*content from database eventually*/ color: color,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    width: width,
                    height: 4.0,
                  )]),
          ]),
        ),
    );
  }
}
