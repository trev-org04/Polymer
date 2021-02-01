import 'package:flutter/material.dart';
import 'package:project_polymer/screens/auth/train.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/shared/constants.dart';

class Deadline extends StatefulWidget {
  @override
  _DeadlineState createState() => _DeadlineState();
}

class _DeadlineState extends State<Deadline> {
  Future navigate(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Train()));
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
            Padding(
              padding: const EdgeInsets.fromLTRB(44, 0, 44, 0),
              child: Text(
                'Never Miss A Deadline',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 10, 44, 30),
              child: Text(
                'With an integrated calendar and smart notifications, you’ll never forget to study for the SAT.',
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
                Icons.calendar_today,
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
                      padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: elementColor),
                    ),
                  ),
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
                      borderRadius: BorderRadius.circular(11.0),
                    ),
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
