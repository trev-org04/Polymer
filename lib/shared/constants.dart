import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(15.0)), borderSide: BorderSide(color: Color(0xff181818), width: 2.0, )),
  helperStyle: TextStyle(fontFamily: 'Nunito', color: Color(0xffEDF7F6)), 
  filled: true,
  errorStyle: TextStyle(fontFamily: 'Nunito'),
  hintStyle: TextStyle(color: Color(0xffEDF7F6), fontFamily: 'Nunito'),
);