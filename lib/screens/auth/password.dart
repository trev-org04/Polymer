import 'package:flutter/material.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Password extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  const Password(this.firstName, this.lastName, this.username, this.email);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    String firstName = widget.firstName;
    String lastName = widget.lastName;
    String username = widget.username;
    String email = widget.email;

    Future navigate(context) async {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Base()), (route) => false);
    }

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: canvasColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: canvasColor,
              title: Container(
                padding: const EdgeInsets.all(10.0),
                child: isLightTheme
                    ? Image.asset(
                        'assets/logo_light.png',
                        fit: BoxFit.contain,
                        height: 30,
                      )
                    : Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                        height: 30,
                      ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Secure Your Account",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: white,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(44, 10, 44, 0),
                            child: Text(
                              "Create your account by setting a password",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: whiteOpacity,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(children: [
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(44, 0, 44, 20),
                            child: Container(
                              alignment: Alignment.center,
                              child: TextFormField(
                                style: GoogleFonts.poppins(
                                  color: whiteOpacity,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password'),
                                obscureText: true,
                                validator: (val) => val.length < 8
                                    ? 'Password must be at least 8 characters'
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(44, 0, 44, 0),
                            child: Container(
                              alignment: Alignment.center,
                              child: TextFormField(
                                style: GoogleFonts.poppins(
                                  color: whiteOpacity,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                ),
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Confirm Password'),
                                obscureText: true,
                                validator: (val) => val != password
                                    ? "Password doesn't match"
                                    : null,
                                onChanged: (val) {
                                  setState(() => confirmPassword = val);
                                },
                              ),
                            ),
                          ),
                        ]),
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
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await _auth.registerEP(
                                      firstName,
                                      lastName,
                                      username,
                                      email,
                                      password);
                                  if (result == null) {
                                    loading = false;
                                    setState(() {
                                      error = 'Unable to create user';
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            backgroundColor: canvasColor,
                                            title: new Text("Error",
                                                style: GoogleFonts.poppins(
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            content: new Text(error,
                                                style: GoogleFonts.poppins(
                                                    color: whiteOpacity,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Close",
                                                    style: GoogleFonts.poppins(
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  } else {
                                    setState(() => loading = false);
                                    navigate(context);
                                  }
                                }
                              }),
                        ),
                      )
                    ]),
                  ])),
            ));
  }
}
