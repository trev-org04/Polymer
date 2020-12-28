import 'package:flutter/material.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:project_polymer/models/user.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentFirstName;
  String _currentLastName;

  //@override
  //initState() {
  //super.initState();
  //getLevel();
  //}

  //getLevel() async {
  //final int batteryLevel = await _battery.batteryLevel;
  //bLevel = batteryLevel;
  //}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            String _currentUsername = userData.username;

            return SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Text('First Name',
                        style: TextStyle(color: Color(0xffEDF7F6))),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(
                          color: Color(0xffEDF7F6), fontFamily: 'Nunito'),
                      initialValue: userData.firstName,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'First Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your first name' : null,
                      onChanged: (val) => setState(() => _currentFirstName = val),
                    ),
                    SizedBox(height: 20),
                    Text('Last Name',
                        style: TextStyle(color: Color(0xffEDF7F6))),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(
                          color: Color(0xffEDF7F6), fontFamily: 'Nunito'),
                      initialValue: userData.lastName,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Last Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your last name' : null,
                      onChanged: (val) => setState(() => _currentLastName = val),
                    ),
                    SizedBox(height: 20),
                    RawMaterialButton(
                        fillColor: Color(0xffEDF7F6),
                        splashColor: Color(0xff181818),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                              _currentFirstName ?? userData.firstName,
                              _currentLastName ?? userData.lastName,
                              _currentUsername ?? userData.username,
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Save',
                                style: TextStyle(fontFamily: 'Nunito')))),
                  ])),
            );
          } else {
            return Loading();
          }
        });
  }
}
