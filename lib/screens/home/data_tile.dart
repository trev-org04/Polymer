import 'package:flutter/material.dart';
import 'package:project_polymer/models/data.dart';

class DataTile extends StatelessWidget {
  final Data data;
  DataTile({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(7, 10, 7, 10),
      decoration: BoxDecoration(
        color: Color(0xff181818),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      child: Row(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: Image.asset(
            'assets/logo.jpeg',
            fit: BoxFit.contain,
            height: 25,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(data.firstName, style: TextStyle(color: Color(0xffEDF7F6), fontFamily: 'Nunito', fontSize: 17)),
            Text(data.lastName, style: TextStyle(color: Color(0xffEDF7F6), fontFamily: 'Nunito', fontSize: 14)),
          ],
        )
      ]),
    );
  }
}
