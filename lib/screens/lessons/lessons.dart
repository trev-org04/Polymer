import 'package:flutter/material.dart';
import 'package:project_polymer/screens/home/resume_tiles/resume_tile.dart';
import 'package:project_polymer/screens/lessons/subjects_grid/subjects_grid.dart';
import 'package:project_polymer/screens/lessons/suggested_tiles/suggested_lesson_tile.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';

class Lessons extends StatefulWidget {
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamProvider<List<Data>>.value(
              value: DatabaseService().data,
              child: Scaffold(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text(
                                  'Lessons',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xffE2E2E2),
                                      fontFamily: 'popSBold',
                                      fontSize: 25.0),
                                ),
                              ),
                            ]),
                        SubjectsGrid(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Suggested Lessons',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'popSBold',
                                      color: white)),
                            ],
                          ),
                        ),
                        SuggestedLessonCarousel(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Resume Lessons',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'popSBold',
                                      color: white)),
                            ],
                          ),
                        ),
                        ResumeTile(),
                      ],
                    ),
                  ),
                )),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
