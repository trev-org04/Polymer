import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:project_polymer/shared/loading.dart';
import 'package:project_polymer/screens/auth/password.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String error = '';

   Future navigate(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Password(firstName, lastName, username, email)));
}

  Widget build(BuildContext context) {
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
                        'assets/logo.jpeg',
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
                Text("Welcome!", textAlign: TextAlign.center, style: TextStyle(color: Color(0xffE2E2E2), fontFamily: 'popSBold', fontSize: 22.0),),
                Padding(
                        padding: EdgeInsets.fromLTRB(44, 10, 44, 0),
                        child: Text("Let's get some basic information", textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed', fontSize: 15.0),),
                      ),
                               ],
                              ),
                            ),
                            Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child:
                                  Column (
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
                                hintText: 'First Name'
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your first name' : null,
                              onChanged: (val) {
                                setState(() => firstName = val);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(44, 0, 44, 20),
                          child: Container(
                              alignment: Alignment.center,
                            child: TextFormField(
                              style: TextStyle(
                                color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed', fontSize: 15.0,
                              ),
                              decoration: textInputDecoration.copyWith(
                                hintText: 'Last Name'
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your last name' : null,
                              onChanged: (val) {
                                setState(() => lastName = val);
                              },
                            ),
                          ),
                        ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 0, 44, 20),
                          child: Container(
                              alignment: Alignment.center,
                            child: TextFormField(
                              style: TextStyle(
                                color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed', fontSize: 15.0,
                              ),
                              decoration: textInputDecoration.copyWith(
                                hintText: 'Username'
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter a username' : null,
                              onChanged: (val) {
                                setState(() => username = val);
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
                                  hintText: 'Email',
                                ),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                                ),
                          ),
                        ),
                        Padding(
                  padding: EdgeInsets.fromLTRB(44, 30, 44, 10),
                  child: ButtonTheme(
                    minWidth: 225.0,
                    height: 40.0,
                    child: RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0),), textColor: Color(0xffE2E2E2), color: Color(0xff0099FF), child: Text('Sign Up', textAlign: TextAlign.center, style: TextStyle(color: Color(0xffE2E2E2), fontFamily: 'popSBold', fontSize: 15.0),), onPressed: () {if (_formKey.currentState.validate()) {navigate(context);}}),
                          ),
                        )]),
                        )]),
                      ]))));
  }
}