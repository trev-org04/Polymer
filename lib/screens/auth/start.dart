import 'package:flutter/material.dart';
import 'package:project_polymer/screens/auth/register.dart';
import 'package:project_polymer/screens/auth/signin.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  Future signIn(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  Future signUp(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
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
              "Let's Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffE2E2E2),
                  fontFamily: 'popSBold',
                  fontSize: 22.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 10, 44, 30),
              child: Text(
                'Select an option below to continue',
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
                Icons.flag,
                color: Color(0xffE2E2E2),
                size: 145.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
              child: ButtonTheme(
                minWidth: 225.0,
                height: 40.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    textColor: Color(0xffE2E2E2),
                    color: Color(0xff0099FF),
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffE2E2E2),
                          fontFamily: 'popSBold',
                          fontSize: 15.0),
                    ),
                    onPressed: () {
                      signUp(context);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                  onTap: () {
                    signIn(context);
                  },
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(226, 226, 226, 0.65),
                        fontFamily: 'popSBold',
                        fontSize: 15.0),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
