import 'package:flutter/material.dart';

class AdaptiveTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;
  AdaptiveTile(
      {@required this.icon,
      @required this.title,
      @required this.desc,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return buildAdaptiveTile(icon, title, desc, color);
  }

  Widget buildAdaptiveTile(
      IconData icon, String title, String desc, Color color) {
    return Container(
      height: 110.0,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
              child: Icon(
                icon,
                size: 36,
                color: Color(0xffE2E2E2),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: Color(0xffE2E2E2),
                          fontFamily: 'popSBold',
                          fontSize: 15)),
                  Text(desc,
                      style: TextStyle(
                          color: Color.fromRGBO(226, 226, 226, 0.65),
                          fontFamily: 'popMed',
                          fontSize: 12)),
                ],
              ),
            )
          ]),
    );
  }
}
