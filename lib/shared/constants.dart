import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
  fillColor: Color(0xff272727),
  border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0))),
  helperStyle: TextStyle(
      fontFamily: 'popMed', color: Color.fromRGBO(226, 226, 226, 0.65)),
  filled: true,
  errorStyle: TextStyle(fontFamily: 'popMed'),
  hintStyle: TextStyle(
      color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed'),
);

const searchbarDecoration = InputDecoration(
  fillColor: Colors.transparent,
  border: InputBorder.none,
  helperStyle: TextStyle(
      fontFamily: 'popMed', color: Color.fromRGBO(226, 226, 226, 0.65)),
  errorStyle: TextStyle(fontFamily: 'popMed'),
  hintStyle: TextStyle(
      color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed'),
);

const buttonBlue = Color(0xff0099FF);

const elementColor = Color(0xff232323);

const mathColor = Color(0xff8855FF);

const scienceColor = Color(0xffCCA000);

const englishColor = Color(0xffEA3160);

const readingColor = Color(0xff00CC88);

const white = Color(0xffE2E2E2);

const whiteOpacity = Color.fromRGBO(226, 226, 226, 0.65);

var index1 = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(110.0),
            color: Color(0xff0099FF)),
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
        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(110.0),
            color: Color(0xff272727)),
      ),
    ),
  ],
);

var index2 = Row(
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
        padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(110.0),
            color: Color(0xff0099FF)),
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
  ],
);

var index3 = Row(
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
);

var mathLogo = Container(
    height: 20.0,
    width: 20.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: mathColor,
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.division, size: 10, color: white),
      ],
    ));

var scienceLogo = Container(
    height: 20.0,
    width: 20.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: scienceColor,
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.beaker, size: 10, color: white),
      ],
    ));

var englishLogo = Container(
    height: 20.0,
    width: 20.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: englishColor,
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.pencil, size: 10, color: white),
      ],
    ));

var readingLogo = Container(
    height: 20.0,
    width: 20.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: readingColor,
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.book, size: 10, color: white),
      ],
    ));

var notiLogo = Container(
    height: 20.0,
    width: 20.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: buttonBlue,
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.account_circle, size: 10, color: white),
      ],
    ));

var mathLogoBig = Container(
    height: 36.0,
    width: 36.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: mathColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.division, size: 20, color: white),
      ],
    ));

var scienceLogoBig = Container(
    height: 36.0,
    width: 36.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: scienceColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.beaker, size: 20, color: white),
      ],
    ));

var englishLogoBig = Container(
    height: 36.0,
    width: 36.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: englishColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.pencil, size: 20, color: white),
      ],
    ));

var readingLogoBig = Container(
    height: 36.0,
    width: 36.0,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: readingColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(MdiIcons.book, size: 20, color: white),
      ],
    ));
