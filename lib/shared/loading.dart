import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width: (MediaQuery.of(context).size.width)-250,
        height: (MediaQuery.of(context).size.width)-250,
        child: CircularProgressIndicator(
                backgroundColor: elementColor,
                strokeWidth: 15,
              ),
      ),
    );
  }
}
