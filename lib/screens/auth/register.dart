import 'package:flutter/material.dart';
import 'package:project_polymer/service/auth.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:project_polymer/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xff181818),
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(icon: Icon(Icons.keyboard_arrow_left), onPressed: () {widget.toggleView();}),
              backgroundColor: Color(0xff181818),
              title: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('sonder',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Nunito',
                        )),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'New User?',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xffEDF7F6),
                                  fontFamily: 'Nunito',
                                  fontSize: 42),
                            ),
                            Text(
                              'Create an account here',
                              style: TextStyle(
                                  color: Color(0xffEDF7F6),
                                  fontFamily: 'Nunito',
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(
                          color: Color(0xffEDF7F6),
                        ),
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xffEDF7F6)),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(
                            color: Color(0xffEDF7F6),
                          ),
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xffEDF7F6)),
                          ),
                          validator: (val) => val.length < 8
                              ? 'Enter a password at least 8 characters long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 35,
                        width: 70,
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: Color(0xffEDF7F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.keyboard_arrow_right,
                                  color: Color(0xff181818)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.registerEP(email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Unable to create user';
                                      loading = false;
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
                                                    color: Color(0xffEDF7F6),
                                                    fontFamily: 'Nunito')),
                                            content: new Text(error,
                                                style: TextStyle(
                                                    color: Color(0xffEDF7F6),
                                                    fontFamily: 'Nunito')),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("Close",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffEDF7F6),
                                                        fontFamily: 'Nunito')),
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
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
