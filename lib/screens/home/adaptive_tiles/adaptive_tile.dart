import 'package:flutter/material.dart';
import 'package:project_polymer/screens/diagnostic/diagnostic.dart';
import 'package:project_polymer/screens/forum/forum.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return buildAdaptiveTile(icon, title, desc, color, context);
  }

  Future diagnostic(context) async {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Forum()));
}

  Widget buildAdaptiveTile(
      IconData icon, String title, String desc, Color color, dynamic _context) {
    return GestureDetector(
      onTap: () {diagnostic(_context);},
          child: Container(
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
                        style: GoogleFonts.poppins(
                            color: Color(0xffE2E2E2),
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    Text(desc,
                        style: GoogleFonts.poppins(
                            color: Color.fromRGBO(226, 226, 226, 0.65),
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

class AdaptiveTileList extends StatefulWidget {
  @override
  _AdaptiveTileListState createState() => _AdaptiveTileListState();
}

class _AdaptiveTileListState extends State<AdaptiveTileList> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1);

  var indicator = index1;

  void updateIndicator(int index) {
    index = _controller.page.round();
    if (index == 0) {
      setState(() {
        indicator = index1;
      });
    }
    if (index == 1) {
      setState(() {
        indicator = index2;
      });
    }
    if (index == 2) {
      setState(() {
        indicator = index3;
      });
    }
  }

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
    return SizedBox(
      height: 110.0,
      child: Column(
        children: [
          Flexible(
            child: buildAdaptiveTileList(
                AdaptiveTile(
                    icon: Icons.calendar_today,
                    title: 'Calendar',
                    desc: 'Jelo calendar is on the way',
                    color: buttonBlue),
                AdaptiveTile(
                    icon: Icons.mail_outline_sharp,
                    title: 'Mail Time',
                    desc: 'Welcome to Mail Time',
                    color: buttonBlue),
                AdaptiveTile(
                    icon: Icons.settings,
                    title: 'Settings',
                    desc: 'Update your settings right now',
                    color: buttonBlue)),
          ),
          indicator,
        ],
      ),
    );
  }

Widget buildAdaptiveTileList(Widget tile, Widget tile2, Widget tile3) {
    return PageView(
        controller: _controller,
        onPageChanged: updateIndicator,
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            child: tile,
          ),
          SizedBox(
            child: tile2,
          ),
          SizedBox(
            child: tile3,
          ),
        ]);
  }
}
