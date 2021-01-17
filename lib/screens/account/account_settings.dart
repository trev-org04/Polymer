import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/screens/auth/start.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/screens/home/modals.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:provider/provider.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

    final AuthService _auth = AuthService();

    Future returnToBase(context) async {
          Navigator.pushAndRemoveUntil(
              context,
      MaterialPageRoute(builder: (context) => Base()),
      (route) => false);
  }

    Future navigate(context) async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Start()),
              (route) => false);
        }

    trial() async {
      await _auth.signOut();
      navigate(context);
    }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Data>>.value(
        value: DatabaseService().data,
        child: Scaffold(
            backgroundColor: Color(0xff181818),
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color(0xff181818),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(MdiIcons.arrowLeft, color: Color(0xffE2E2E2), size: 30),
                    splashColor: Color(0xff181818),
                    splashRadius: 0.1,
                    onPressed: () {
                      returnToBase(context);
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
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.5),
                      child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text(
                                  'Settings',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xffE2E2E2),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25.0),
                                ),
                              ),
                              buildAccountTile(Icons.account_circle),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                                child: Divider(
                                    color: whiteOpacity
                                  ),
                              ),
                              Column(
                                children: [
                                  buildSettingsOption(Icons.account_circle, 'Account', navigate(context)),
                                  buildSettingsOption(Icons.credit_card, 'Subscription', navigate(context)),
                                  buildSettingsOption(MdiIcons.themeLightDark, 'Appearance', navigate(context)),
                                  buildSettingsOption(Icons.notifications, 'Notifications', navigate(context)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                                child: Divider(
                                    color: whiteOpacity
                                  ),
                              ),
                                  buildSettingsOption(MdiIcons.faceAgent, 'Support', navigate(context)),
                                  buildSettingsOption(MdiIcons.gavel, 'Legal', navigate(context)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                                child: Divider(
                                    color: whiteOpacity
                                  ),
                              ),
                                  buildSettingsOption(MdiIcons.logoutVariant, 'Sign Out', trial()),
                                ]
                              )
                            ]),
                      ])))
                      ),
            )));
  }

  Widget buildSettingsOption(IconData icon, String option, dynamic test) {
    return GestureDetector(
      onTap: () {
        test; //does not work pls fix
      },
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, color: white, size: 25.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(option, style: GoogleFonts.poppins(color: white, fontWeight: FontWeight.w500, fontSize: 17.0)),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildAccountTile(IconData icon) {
  return Container(
    //height: 140.0,
    padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 0.0),
    decoration: BoxDecoration(
      color: elementColor,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 0.0),
    child: Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Icon(
                  icon,
                  size: 40,
                  color: Color(0xffE2E2E2),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AccountName(),
                    SubscriptionLevel(),
                  ],
                ),
              )
            ]),
      ],
    ),
  );
}
}

class AccountName extends StatefulWidget {
  @override
  _AccountNameState createState() => _AccountNameState();
}

class _AccountNameState extends State<AccountName> {
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
                child: Text(
                  userData.firstName + ' ' + userData.lastName,
                  style: GoogleFonts.poppins(
                      color: white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                ));
          } else {
            return null;
          }
        });
  }
}

class SubscriptionLevel extends StatefulWidget {
  @override
  _SubscriptionLevelState createState() => _SubscriptionLevelState();
}

class _SubscriptionLevelState extends State<SubscriptionLevel> {
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
                child: Text(
                  userData.subscriptionLevel + ' Plan',
                        style: GoogleFonts.poppins(
                            color: whiteOpacity,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                ));
          } else {
            return null;
          }
        });
  }
}
