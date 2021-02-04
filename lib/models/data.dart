import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final String uid;
  final String firstName;
  final String lastName;
  final String username;
  final int points;
  final int lessonsToResume;
  final String subscriptionLevel;
  final bool isLight;
  final bool sendNotifications;

  Data({this.uid, this.firstName, this.lastName, this.username, this.points, this.lessonsToResume, this.subscriptionLevel, this.isLight, this.sendNotifications});
}

class Question {
  String question;
  String questionID;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
  //String savedAnswer;
  bool isSelected1;
  bool isSelected2;
  bool isSelected3;
  bool isSelected4;
  bool answered;
  bool isAttempted;
  bool plus;
}

class Progress {
  bool inProgress;
  Progress.fromSnapshot(DocumentSnapshot snapshot)
      : inProgress = snapshot['inProgress'];
}

class Event {
  final String uid;
  final String title;
  final DateTime date;
  final String subject;
  final int index;

  Event({this.uid, this.title, this.date, this.subject, this.index});
}

class EData {
  final String title;
  final DateTime date;
  final String subject;
  final int index;

  EData({this.title, this.date, this.subject, this.index});
}