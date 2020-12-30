import 'package:flutter/material.dart';
import 'package:project_polymer/shared/constants.dart';

void notificationsModal(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
            child: Column(
              children: [
                Container(
                  height: 6.5,
                  width: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                      color: Color.fromRGBO(226, 226, 226, 0.65)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: Text(
                        'Notifications',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: white, fontFamily: 'popSBold', fontSize: 25.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

void suggestedLessonsModal(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
            child: Column(
              children: [
                Container(
                  height: 6.5,
                  width: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                      color: Color.fromRGBO(226, 226, 226, 0.65)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: Text(
                        'Suggested Lessons',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: white, fontFamily: 'popSBold', fontSize: 25.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

void accountModal(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
            child: Column(
              children: [
                Container(
                  height: 6.5,
                  width: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                      color: Color.fromRGBO(226, 226, 226, 0.65)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: Text(
                        'Account',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: white, fontFamily: 'popSBold', fontSize: 25.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
