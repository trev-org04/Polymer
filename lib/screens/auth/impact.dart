import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/auth/deadline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/shared/constants.dart';

class Impact extends StatefulWidget {
  @override
  _ImpactState createState() => _ImpactState();
}

class _ImpactState extends State<Impact> {
  Future navigate(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Deadline()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: canvasColor,
        title: Container(
          padding: const EdgeInsets.all(10.0),
          child:               isLightTheme ?
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
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Small Lessons, Big Impacts',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 10, 44, 30),
              child: Text(
                'Complete a few short lessons each day to drastically improve your understanding of topics on the SAT.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: whiteOpacity,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(110.0),
                  color: elementColor),
              child: Icon(
                MdiIcons.lightbulb,
                color: white,
                size: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(44, 20, 44, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: buttonBlue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: elementColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: elementColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
              child: ButtonTheme(
                splashColor: whiteOpacity,
                minWidth: 225.0,
                height: 40.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0)),
                    textColor: white,
                    color: buttonBlue,
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    onPressed: () {
                      navigate(context);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
