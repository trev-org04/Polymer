import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
  fillColor: Color(0xff272727), 
  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(15.0))),
  helperStyle: TextStyle(fontFamily: 'popMed', color: Color.fromRGBO(226, 226, 226, 0.65)), 
  filled: true,
  errorStyle: TextStyle(fontFamily: 'popMed'),
  hintStyle: TextStyle(color: Color.fromRGBO(226, 226, 226, 0.65), fontFamily: 'popMed'),
);