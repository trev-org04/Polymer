import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
          decoration: BoxDecoration(
            color: Color(0xff232323),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: elementColor,
            ),
          )),
    );
  }
}
