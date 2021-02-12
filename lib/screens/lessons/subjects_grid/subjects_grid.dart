import 'package:cloud_firestore/cloud_firestore.dart';
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

  double sciTotal;
  double sciComplete;
  double engTotal;
  double engComplete;
  double mathTotal;
  double mathComplete;
  double readTotal;
  double readComplete;

  double sP = 0.0;
  double eP = 0.0;
  double mP = 0.0;
  double rP = 0.0;

  Future<double> sciencePer() async {
    QuerySnapshot sciDocsTotal = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'Science')
        .getDocuments();
    List<DocumentSnapshot> sciTotalList = sciDocsTotal.documents;
    sciTotal = sciTotalList.length.toDouble();
    QuerySnapshot sciDocsComplete = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'Science')
        .where('isCompleted', isEqualTo: true)
        .getDocuments();
    List<DocumentSnapshot> sciCompleteList = sciDocsComplete.documents;
    sciComplete = sciCompleteList.length.toDouble();
    sP = sciComplete / sciTotal;
    return sP;
  }

  Future<double> englishPer() async {
    QuerySnapshot engDocsTotal = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'English')
        .getDocuments();
    List<DocumentSnapshot> engTotalList = engDocsTotal.documents;
    engTotal = engTotalList.length.toDouble();
    QuerySnapshot engDocsComplete = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'English')
        .where('isCompleted', isEqualTo: true)
        .getDocuments();
    List<DocumentSnapshot> engCompleteList = engDocsComplete.documents;
    engComplete = engCompleteList.length.toDouble();
    eP = engComplete / engTotal;
    return eP;
  }

  Future<double> mathematicsPer() async {
    QuerySnapshot mathDocsTotal = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'Math')
        .getDocuments();
    List<DocumentSnapshot> mathTotalList = mathDocsTotal.documents;
    mathTotal = mathTotalList.length.toDouble();
    QuerySnapshot mathDocsComplete = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'Math')
        .where('isCompleted', isEqualTo: true)
        .getDocuments();
    List<DocumentSnapshot> mathCompleteList = mathDocsComplete.documents;
    mathComplete = mathCompleteList.length.toDouble();
    mP = mathComplete / mathTotal;
    return mP;
  }

  Future<double> readingPer() async {
    QuerySnapshot readDocsTotal = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'Reading')
        .getDocuments();
    List<DocumentSnapshot> readTotalList = readDocsTotal.documents;
    readTotal = readTotalList.length.toDouble();
    QuerySnapshot readDocsComplete = await Firestore.instance
        .collection('Lessons')
        .where('lessonSubject', isEqualTo: 'Reading')
        .where('isCompleted', isEqualTo: true)
        .getDocuments();
    List<DocumentSnapshot> readCompleteList = readDocsComplete.documents;
    readComplete = readCompleteList.length.toDouble();
    rP = readComplete / readTotal;
    return rP;
  }

  getPercentages() async {
    await readingPer();
    await mathematicsPer();
    await englishPer();
    await sciencePer();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPercentages();
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
          buildSubjectTile(MdiIcons.beaker, 'Science', _key, sP, scienceColor),
          buildSubjectTile(MdiIcons.book, 'Reading', _key1, rP, readingColor)
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSubjectTile(MdiIcons.division, 'Math', _key2, mP, mathColor),
              buildSubjectTile(
                  MdiIcons.pencil, 'English', _key3, eP, englishColor),
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
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                child: Icon(icon, color: isLightTheme ? canvasColor : white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
                child: Text(subject,
                    style: GoogleFonts.poppins(
                        color: isLightTheme ? canvasColor : white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                        color: isLightTheme ? elementColor : canvasColor,
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
                        percentageCompleted, //percentageCompleted.truncate(),
                    height: 4.0,
                  )
                ]),
              ),
            ],
          )),
    );
  }
}
