import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:project_polymer/screens/home/adaptive_tiles/build_adaptive_tile.dart';

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
