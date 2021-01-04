import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/lessons/subject_page.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsGrid extends StatefulWidget {
  @override
  _SubjectsGridState createState() => _SubjectsGridState();
}

class _SubjectsGridState extends State<SubjectsGrid> {
  Future navigate(context, String subject) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SubjectPage(subject)));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    GlobalKey _key1 = GlobalKey();
    GlobalKey _key2 = GlobalKey();
    GlobalKey _key3 = GlobalKey();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          buildSubjectTile(MdiIcons.beaker, 'Science', _key, .87, scienceColor),
          buildSubjectTile(MdiIcons.book, 'Reading', _key1, .19, readingColor)
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSubjectTile(
                  MdiIcons.division, 'Math', _key2, .23, mathColor),
              buildSubjectTile(
                  MdiIcons.pencil, 'English', _key3, .72, englishColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSubjectTile(IconData icon, String subject, Key key,
      double percentageCompleted, Color color) {
    return GestureDetector(
      onTap: () => navigate(context, subject),
          child: Container(
          width: (MediaQuery.of(context).size.width / 2) - 40,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                child: Icon(icon, color: white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
                child: Text(subject,
                    style: GoogleFonts.poppins(
                        color: white, fontWeight: FontWeight.w600, fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: Stack(children: [
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
                      /*content from database eventually*/ color: white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    width: ((MediaQuery.of(context).size.width / 2) - 65) *
                        percentageCompleted,
                    height: 4.0,
                  )
                ]),
              ),
            ],
          )),
    );
  }
}
