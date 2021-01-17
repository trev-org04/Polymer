import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/screens/home/modals.dart';
import 'package:project_polymer/screens/lessons/suggested_tiles/subject_specific_carousel.dart';
import 'package:project_polymer/screens/lessons/display_lessons_in_topic_page.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';

class SubjectPage extends StatefulWidget {
  final String subject;
  const SubjectPage(this.subject);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  Future navigate(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Base()));
  }

  Stream topicStream;
  DatabaseService databaseService = new DatabaseService();

    @override
  void initState() {
    String subjectName = widget.subject;
    databaseService.getTopicsInSubject().then((tData) {
      setState(() {
        topicStream = tData.where('subject', isEqualTo: subjectName).snapshots();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String subjectName = widget.subject;
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamProvider<List<Data>>.value(
                value: DatabaseService().data,
                child: Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Color(0xff181818),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(MdiIcons.arrowLeft,
                                color: Color(0xffE2E2E2), size: 25),
                            splashColor: Color(0xff181818),
                            splashRadius: 0.1,
                            onPressed: () {
                              navigate(context);
                            },
                          ),
                          Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            height: 30,
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications,
                                color: Color(0xffE2E2E2), size: 30),
                            splashColor: Color(0xff181818),
                            splashRadius: 0.1,
                            onPressed: () {
                              notificationsModal(context);
                            },
                          )
                        ],
                      ),
                    ),
                    backgroundColor: Color(0xff181818),
                    body: Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 12.5),
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Text(
                                              subjectName,
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  color: Color(0xffE2E2E2),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 25.0),
                                            ),
                                          ),
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Suggested Lessons',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: white)),
                                        ],
                                      ),
                                    ),
                                    SubjectCarousel(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Topics',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: white)),
                                        ],
                                      ),
                                    ),
                                    buildTopicList(),
                                  ]),
                            )))));
          } else {
            return Loading();
          }
        });
  }

  Widget buildTopicList() {
    String subjectName = widget.subject;
    return StreamBuilder(
      stream: topicStream,
      builder: (context, snapshot) {
        return snapshot.data == null
            ? Loading()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return TopicTile(
                    title:
                    snapshot.data.documents[index].data["topicName"],
                    percentage: snapshot.data.documents[index].data["percentage"],
                    subject: subjectName,
                  );
                });
      },
    );
  }
}

class TopicTile extends StatelessWidget {
  final String title;
  final String percentage;
  final String subject;
  TopicTile({@required this.title, @required this.percentage, @required this.subject});

icon (String subject) {
  Widget icon;
  if (subject == 'Science') {
    icon = scienceLogoBig;
  }
    else if (subject == 'Reading') {
    icon = readingLogoBig;
  }
    if (subject == 'Math') {
    icon = mathLogoBig;
  }
    if (subject == 'English') {
    icon = englishLogoBig;
  }
  return icon;
}

      Future goToTopicPage(context, String topic, String subject) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TopicPage(topic, subject)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToTopicPage(context, title, subject);
        },
          child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: elementColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        margin: EdgeInsets.only(bottom: 15.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                child: icon(subject),
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
                    Text(percentage + '% Completed',
                        style: GoogleFonts.poppins(
                            color: Color.fromRGBO(226, 226, 226, 0.65),
                            fontWeight: FontWeight.w400,
                            fontSize: 12)),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

