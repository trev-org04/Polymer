import 'package:flutter/material.dart';
import 'package:project_polymer/screens/base/base.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:project_polymer/shared/constants.dart';

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
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Base()), (route)=>false);
}

    return loading
        ? Loading()
        : Scaffold(
      backgroundColor: Color(0xff181818),
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
                Text("Secure Your Account", textAlign: TextAlign.center, style: TextStyle(color: Color(0xffE2E2E2), fontFamily: 'popSBold', fontSize: 22.0),),
                Padding(
                        padding: EdgeInsets.fromLTRB(44, 10, 44, 0),
                        child: Text("Create your account by setting a password", textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed', fontSize: 15.0),),
                      ),
                               ],
                              ),
                            ),
                      Column(
                        children: [ 
                        Form(
                          key: _formKey,
                          child: 
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(44, 0, 44, 20),
                              child: Container(
                                  alignment: Alignment.center,
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed', fontSize: 15.0,
                                  ),
                                  decoration: textInputDecoration.copyWith(
                                    hintText: 'Password'
                                  ),
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
                              style: TextStyle(
                                color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed', fontSize: 15.0,
                              ),
                              decoration: textInputDecoration.copyWith(
                                hintText: 'Confirm Password'
                              ),
                              obscureText: true,
                              validator: (val) =>
                                  val != password ? "Password doesn't match" : null,
                              onChanged: (val) {
                                setState(() => confirmPassword = val);
                              },
                            ),
                          ),
                        ),
                          ]
                          ),
                        ),
                        Padding(
                  padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
                  child: ButtonTheme(
                    minWidth: 225.0,
                    height: 40.0,
                    child: RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0),), textColor: Color(0xffE2E2E2), color: Color(0xff0099FF), child: Text('Sign Up', textAlign: TextAlign.center, style: TextStyle(color: Color(0xffE2E2E2), fontFamily: 'popSBold', fontSize: 15.0),), onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.registerEP(firstName, lastName, username, email, password);
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
                                              backgroundColor: Color(0xff181818),
                                              title: new Text("Error",
                                                  style: TextStyle(
                                                      color: Color(0xffE2E2E2),
                                                      fontFamily: 'popSBold')),
                                              content: new Text(error,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(226, 226, 226, 0.65),
                                                      fontFamily: 'popMed')),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text("Close",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffE2E2E2),
                                                          fontFamily: 'popMed')),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    }
                                    else {
                                      setState(() => loading = false);
                                      navigate(context);
                                    }
                                  }
                                }),
                          ),
                        )]),
                      ])),
            ));
  }
}