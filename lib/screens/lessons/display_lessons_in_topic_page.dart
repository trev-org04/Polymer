import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/diagnostic/diagnostic.dart';
import 'package:project_polymer/screens/home/modals.dart';
import 'package:project_polymer/screens/lessons/subject_page.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';

class TopicPage extends StatefulWidget {
  final String subject;
  final String topic;
  const TopicPage(this.topic, this.subject);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  Future navigate(context) async {
    String subjectName = widget.subject;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SubjectPage(subjectName)));
  }

  Stream lessonStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    String topicName = widget.topic;
    databaseService.getLessonsInTopic().then((lData) {
      setState(() {
        lessonStream = lData.where('lessonTopic', isEqualTo: topicName).snapshots();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String topicName = widget.topic;
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
                      backgroundColor: canvasColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(MdiIcons.arrowLeft,
                                color: white, size: 25),
                            splashColor: canvasColor,
                            splashRadius: 0.1,
                            onPressed: () {
                              navigate(context);
                            },
                          ),
              isLightTheme ?
              Image.asset(
                'assets/logo_light.png',
                fit: BoxFit.contain,
                height: 30,
              ) :
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 30,
              ),
                          IconButton(
                            icon: Icon(Icons.notifications,
                                color: white, size: 30),
                            splashColor: canvasColor,
                            splashRadius: 0.1,
                            onPressed: () {
                              notificationsModal(context);
                            },
                          )
                        ],
                      ),
                    ),
                    backgroundColor: canvasColor,
                    body: Padding(
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
                                          topicName,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              color: white,
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
                                      Text('Lessons',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: white)),
                                    ],
                                  ),
                                ),
                                buildLessonList(),
                              ]),
                        ))));
          } else {
            return Loading();
          }
        });
  }

  Widget buildLessonList() {
    String subjectName = widget.subject;
    return StreamBuilder(
      stream: lessonStream,
      builder: (context, snapshot) {
        return snapshot.data == null
            ? Loading()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return LessonTile(
                    title:
                    snapshot.data.documents[index].data["lessonTitle"],
                    desc: snapshot.data.documents[index].data["lessonDesc"],
                    subject: subjectName,
                    lessonID: snapshot.data.documents[index].data["lessonID"],
                  );
                });
      },
    );
  }
}

        Future goToLesson(context, String lessonID, String subject, String lessonName) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Diagnostic(lessonID: lessonID, subject: subject, lessonName: lessonName)));
  }

class LessonTile extends StatelessWidget {
  final String title;
  final String desc;
  final String subject;
  final String lessonID;
  LessonTile({@required this.title, @required this.desc, @required this.subject, @required this.lessonID});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToLesson(context, lessonID, subject, title);
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
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    Text(desc,
                        style: GoogleFonts.poppins(
                            color: whiteOpacity,
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
