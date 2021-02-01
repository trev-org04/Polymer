import 'package:flutter/material.dart';
import 'package:project_polymer/screens/auth/impact.dart';
import 'package:project_polymer/screens/auth/start.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/shared/constants.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  Future navigate(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Impact()));
  }

  Future skip(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Start()));
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
              'Take Control',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 10, 44, 30),
              child: Text(
                'With Polymer, you can take control of your SAT score and increase it in a smarter way.',
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
                Icons.score,
                color: white,
                size: 145.0,
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
                      'See How',
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
            GestureDetector(
                onTap: () {
                  skip(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Skip',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: whiteOpacity,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
