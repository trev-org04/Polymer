import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/auth/start.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_polymer/shared/constants.dart';

class Train extends StatefulWidget {
  @override
  _TrainState createState() => _TrainState();
}

class _TrainState extends State<Train> {
  Future navigate(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Start()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff181818),
        title: Container(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 45,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Train Your Brain',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: Color(0xffE2E2E2),
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 10, 44, 30),
              child: Text(
                'Our strategy courses help you quickly identify the right answers and avoid the traps of the SAT.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Color.fromRGBO(226, 226, 226, 0.65),
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(110.0),
                  color: Color(0xff232323)),
              child: Icon(
                MdiIcons.brain,
                color: Color(0xffE2E2E2),
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
                          color: Color(0xff272727)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: Color(0xff272727)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: Color(0xff0099FF)),
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
                    textColor: Color(0xffE2E2E2),
                    color: Color(0xff0099FF),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Color(0xffE2E2E2),
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
