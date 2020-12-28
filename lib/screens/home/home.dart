import 'package:flutter/material.dart';
import 'package:project_polymer/screens/home/settings_form.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/screens/home/data_list.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:project_polymer/screens/home/analytics.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettings() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: SettingsForm(),
            );
          });
    }

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
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Color(0xff181818),
                  title: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('sonder',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Nunito',
                            )),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 0, 5),
                    child: Text('Welcome, ' + userData.firstName + '!', style: TextStyle(color: Color(0xffEDF7F6), fontFamily: 'Nunito', fontSize: 30)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 5, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Your Vehicles', style: TextStyle(color: Color(0xffEDF7F6), fontFamily: 'Nunito', fontSize: 15)),
                      ],
                      ),
                  ),
                  DataList(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 5, 5),
                    child: Text('Analytics', style: TextStyle(color: Color(0xffEDF7F6), fontFamily: 'Nunito', fontSize: 15)),
                  ),
                  Analytics(),
                ]),
                endDrawer: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.all(5),
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DrawerHeader(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'assets/rohan.jpg',
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Welcome, ' + userData.firstName + '!',
                                      style: TextStyle(
                                          color: Color(0xffEDF7F6),
                                          fontFamily: 'Nunito',
                                          fontSize: 20)),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff181818),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xffEDF7F6),
                          indent: 25,
                          endIndent: 25,
                        ),
                        ListTile(
                            leading:
                                Icon(Icons.settings, color: Color(0xffA29F90)),
                            title: Text('Update Settings',
                                style: TextStyle(color: Color(0xffEDF7F6))),
                            onTap: () => {
                                  _showSettings(),
                                }),
                        ListTile(
                          leading:
                              Icon(Icons.pie_chart, color: Color(0xff5F4BB6)),
                          title: Text('Analytics',
                              style: TextStyle(color: Color(0xffEDF7F6))),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.clear, color: Color(0xffDE1A1A)),
                          title: Text('Sign Out',
                              style: TextStyle(color: Color(0xffEDF7F6))),
                          onTap: () async {
                            await _auth.signOut();
                          },
                        ),
                        Divider(
                          color: Color(0xffEDF7F6),
                          indent: 25,
                          endIndent: 25,
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.help_outline, color: Color(0xffAF7A6D)),
                          title: Text('Help and Feedback',
                              style: TextStyle(color: Color(0xffEDF7F6))),
                          onTap: () {},
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.person_add, color: Color(0xff2176FF)),
                          title: Text('Refer a Friend',
                              style: TextStyle(color: Color(0xffEDF7F6))),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}