import 'package:flutter/material.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

     Future navigate(context) async {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Base()), (route)=>false);
}

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Welcome Back!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22.0),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(44, 10, 44, 0),
                                child: Text(
                                  'Log into an existing account',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color:
                                          whiteOpacity,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                hintText: 'Email/Username'),
                            validator: (val) => val.isEmpty
                                ? 'Enter an email or username'
                                : null,
                            onChanged: (val) {
                              setState(() => email = val);
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
                                  fontSize: 15.0),
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Password'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter a password' : null,
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              }),
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
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      dynamic result =
                                          await _auth.signInEP(email, password);
                                      setState(() => loading = true);
                                      if (result == null) {
                                        loading = false;
                                        setState(() {
                                          error = 'Invalid credentials';
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0))),
                                                    backgroundColor:
                                                        canvasColor,
                                                    title: new Text("Error",
                                                        style: GoogleFonts.poppins(
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight.w600)),
                                                    content: new Text(error,
                                                        style: GoogleFonts.poppins(
                                                            color:
                                                                whiteOpacity,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.0)),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                          child: new Text(
                                                              "Close",
                                                              style: GoogleFonts.poppins(
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight.w500)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                    ]);
                                              });
                                        });
                                      }
                                     else {
                                      setState(() => loading = false);
                                      navigate(context);
                                    }
                                    }
                                  })))
                    ]),
              ),
            ));
  }
}
