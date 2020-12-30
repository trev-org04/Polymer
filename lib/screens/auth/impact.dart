import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/screens/auth/deadline.dart';

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
        backgroundColor: Color(0xff181818),
        title: Container(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/logo.jpeg',
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
              'Small Lessons, Big Impacts',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffE2E2E2),
                  fontFamily: 'popSBold',
                  fontSize: 22.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 10, 44, 30),
              child: Text(
                'Complete a few short lessons each day to drastically improve your understanding of topics on the SAT.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(226, 226, 226, 0.65),
                    fontFamily: 'popMed',
                    fontSize: 15.0),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(110.0),
                  color: Color(0xff232323)),
              child: Icon(
                MdiIcons.lightbulb,
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
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: Color(0xff0099FF)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: Color(0xff272727)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: Color(0xff272727)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
              child: ButtonTheme(
                minWidth: 225.0,
                height: 40.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0)),
                    textColor: Color(0xffE2E2E2),
                    color: Color(0xff0099FF),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffE2E2E2),
                          fontFamily: 'popSBold',
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
