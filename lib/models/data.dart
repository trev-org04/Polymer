import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_polymer/shared/constants.dart';

var iconChosen;

  iconChooser(String subject) {
    if (subject == 'Math') {
      iconChosen = mathLogoBig;
    } else if (subject == 'Reading') {
      iconChosen = readingLogoBig;
    } else if (subject == 'English') {
      iconChosen = englishLogoBig;
    } else if (subject == 'Science') {
      iconChosen = scienceLogoBig;
    } else {
      iconChosen = notiLogoBig;
    }
    return iconChosen;
  }

class Data {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final int points;
  final int lessonsToResume;
  final String subscriptionLevel;
  final bool isLight;
  final bool sendNotifications;

  Data({this.uid, this.firstName, this.lastName, this.email, this.username, this.points, this.lessonsToResume, this.subscriptionLevel, this.isLight, this.sendNotifications});
}

class Question {
  String question;
  String questionID;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
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

class ForumQuestion {
  final String title;
  final String content;
  final bool isVoted;
  final int votes;

  ForumQuestion({this.title, this.content, this.isVoted, this.votes});
}

class UserTypedForumQuery {
  final String title;
  final icon;
  final String content;
  final int votes;
  final String time;
  final bool isVoted;

  UserTypedForumQuery({this.title, this.icon, this.content, this.votes, this.time, this.isVoted});

  UserTypedForumQuery.fromSnapshot(DocumentSnapshot snapshot) :
  
    title = snapshot['title'],
    icon = iconChooser(snapshot['subject']),
    content = snapshot['content'],
    votes = snapshot['votes'], 
    time = '3 mins',
    isVoted = snapshot['isVoted'];
}