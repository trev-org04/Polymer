import 'package:flutter/material.dart';
import 'package:project_polymer/screens/home/suggested_tiles/suggested_tile.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/screens/home/adaptive_tiles/adaptive_tile_list.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';

class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
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
                                  'Subjects',
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
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Suggested Lessons',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'popSBold',
                                      color: white)),
                              Icon(Icons.keyboard_arrow_right,
                                  color: white, size: 22)
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: SuggestedTile()),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: SuggestedTile()),
                        Padding(
                          padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
                          child: ButtonTheme(
                            minWidth: 250.0,
                            height: 40.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                                textColor: Color(0xffE2E2E2),
                                color: Color(0xff0099FF),
                                child: Text(
                                  'See How',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffE2E2E2),
                                      fontFamily: 'popSBold',
                                      fontSize: 15.0),
                                ),
                                onPressed: () {}),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
                          child: ButtonTheme(
                            minWidth: 250.0,
                            height: 40.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                                textColor: Color(0xffE2E2E2),
                                color: Color(0xff0099FF),
                                child: Text(
                                  'See How',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffE2E2E2),
                                      fontFamily: 'popSBold',
                                      fontSize: 15.0),
                                ),
                                onPressed: () {}),
                          ),
                        ),
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
