import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/screens/home/modals.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';

class PointHistory extends StatefulWidget {
  @override
  _PointHistoryState createState() => _PointHistoryState();
}

class _PointHistoryState extends State<PointHistory> {
  Future navigate(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Base()));
  }

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
                                              'Point History',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Color(0xffE2E2E2),
                                                  fontFamily: 'popSBold',
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
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'popSBold',
                                                  color: white)),
                                        ],
                                      ),
                                    ),
                                    /*from da db soon yk*/buildPointHistoryTile(mathLogoBig, 'Topic', '46', mathColor),
                                    buildPointHistoryTile(mathLogoBig, 'Topic', '46', mathColor),
                                    buildPointHistoryTile(mathLogoBig, 'Topic', '46', mathColor),
                                    buildPointHistoryTile(mathLogoBig, 'Topic', '46', mathColor),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Tests',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: 'popSBold',
                                                  color: white)),
                                        ],
                                      ),
                                    ),
                                    /*from da db soon yk*/buildPointHistoryTile(mathLogoBig, 'Test', '46', mathColor),
                                    buildPointHistoryTile(mathLogoBig, 'Test', '46', mathColor),
                                    buildPointHistoryTile(mathLogoBig, 'Test', '46', mathColor),
                                    buildPointHistoryTile(mathLogoBig, 'Test', '46', mathColor),
                                  ]),
                            )))));
          } else {
            return Loading();
          }
        });
  }
  Widget buildPointHistoryTile(Widget icon, String title, String progress, Color color) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: elementColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: icon,
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
                      Text(progress + ' Points',
                          style: TextStyle(
                              color: Color.fromRGBO(226, 226, 226, 0.65),
                              fontFamily: 'popReg',
                              fontSize: 12)),
                    ],
                  ),
                )
              ]),
        ],
      ),
    );
  }
}