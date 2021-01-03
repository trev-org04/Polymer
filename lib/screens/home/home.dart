import 'package:flutter/material.dart';
import 'package:project_polymer/screens/home/plan_progress/plan_progress.dart';
import 'package:project_polymer/screens/home/suggested_tiles/suggested_tile.dart';
import 'package:project_polymer/screens/home/resume_tiles/resume_tile.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/screens/home/adaptive_tiles/adaptive_tile_list.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:project_polymer/screens/home/modals.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

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
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  'Welcome,',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xffE2E2E2),
                                      fontFamily: 'popReg',
                                      fontSize: 25.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text(
                                  userData.firstName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xffE2E2E2),
                                      fontFamily: 'popSBold',
                                      fontSize: 25.0),
                                ),
                              ),
                            ]),
                        AdaptiveTileList(),
                                                Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Suggested Lessons',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'popSBold',
                                      color: white)),
                                                                    IconButton(
                                icon: Icon(Icons.keyboard_arrow_right,
                                    color: Color(0xffE2E2E2), size: 22),
                                splashRadius: 0.1,
                                splashColor: Color(0xff181818),
                                onPressed: () {
                                  suggestedLessonsModal(context);
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: SuggestedTile()),
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
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Plan Progress',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'popSBold',
                                        color: white)),
                                IconButton(
                                  icon: Icon(Icons.keyboard_arrow_right,
                                      color: Color(0xffE2E2E2), size: 22),
                                  splashRadius: 0.1,
                                  splashColor: Color(0xff181818),
                                  onPressed: () {
                                    planProgressModal(context);
                                  },
                                )
                              ],
                            )),
                        PlanProgress(),
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
