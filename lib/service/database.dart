import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference dataCollection =
      Firestore.instance.collection('Data');

  Future updateUserData(
      String firstName,
      String lastName,
      String email,
      String username,
      int points,
      int lessonsToResume,
      String subscriptionLevel,
      bool isLight,
      bool sendNotifications) async {
    return await dataCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'email' : email,
      'username': username,
      'points': points,
      'lessonsToResume': lessonsToResume,
      'subscriptionLevel': subscriptionLevel,
      'isLight': isLight,
      'sendNotifications': sendNotifications,
    });
  }

  List<Data> _dataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Data(
        firstName: doc.data['firstName'] ?? '',
        lastName: doc.data['lastName'] ?? '',
        email: doc.data['email'] ?? '',
        username: doc.data['username'] ?? '',
        points: doc.data['points'] ?? '',
        lessonsToResume: doc.data['lessonsToResume'] ?? '',
        subscriptionLevel: doc.data['subscriptionLevel'] ?? '',
        isLight: doc.data['isLight'] ?? '',
        sendNotifications: doc.data['sendNotifications'] ?? '',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      email: snapshot.data['email'],
      username: snapshot.data['username'],
      points: snapshot.data['points'],
      lessonsToResume: snapshot.data['lessonsToResume'],
      subscriptionLevel: snapshot.data['subscriptionLevel'],
      isLight: snapshot.data['isLight'],
      sendNotifications: snapshot.data['sendNotifications'],
    );
  }

  List<Event> _eventDatatoList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
        uid: uid,
        title: doc.data['title'] ?? '',
        date: doc.data['date'] ?? '',
        subject: doc.data['subject'] ?? '',
      );
    }).toList();
  }

  List<ForumQuestion> _questionDatatoList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ForumQuestion(
        title: doc.data['title'] ?? '',
        content: doc.data['subject'] ?? '',
        isVoted: doc.data['isVoted'] ?? '',
        votes: doc.data['votes'] ?? '',
      );
    }).toList();
  }

  Stream<List<Data>> get data {
    return dataCollection.snapshots().map(_dataListFromSnapshot);
  }

  Stream<UserData> get userData {
    return dataCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<Event>> get events {
    return dataCollection
        .document(uid)
        .collection('Events')
        .snapshots()
        .map(_eventDatatoList);
  }

  createEvent(String uid, String title, String subject, DateTime date) {
    dataCollection.document(uid).collection('Events').document().setData({
      'title': title,
      'subject': subject,
      'date': date,
    });
  }

  askQuestion(String uid, String title, String subject, String question) {
    Firestore.instance.collection('Questions').document().setData({
      'uid': uid,
      'content': question,
      'title': title, 
      'votes': 1,
      'isVoted': false,
      'subject': subject,
    });
  }

  usernameFinder(String uname) {
    Future<QuerySnapshot> userSnap = Firestore.instance.collection('Data').where('username', isEqualTo: uname).getDocuments();
    return userSnap;
  }

  get getEvents {
    return dataCollection.document(uid).collection('Events');
  }

  Stream<List<ForumQuestion>> get forums {
    return Firestore.instance.collection('Questions').snapshots().map(_questionDatatoList);
  }

  get getForums {
    return Firestore.instance.collection('Questions');
  }

  returnPreferences(String uid) {
    return Firestore.instance.collection("Data").document(uid);
  }

  getLessonsInTopic() async {
    return Firestore.instance.collection("Lessons");
  }

  getTopicsInSubject() async {
    return Firestore.instance.collection("Topics");
  }

  getQuestions() async {
    return Firestore.instance.collection("Questions");
  }

  getLessonData(String lessonID) async {
    return Firestore.instance
        .collection("Lessons")
        .document(lessonID)
        .collection('Questions')
        .getDocuments();
  }

  setProgress(String lessonID) async {
    return Firestore.instance.collection("Lessons").document(lessonID);
  }

  createLessonCollection(String uid) {
    return Firestore.instance.collection('Data').document(uid).collection('Lessons').add({
      'title': 'Lesson for Initialization',
    });
  }

  createEventCollection(String uid) {
    return Firestore.instance.collection('Data').document(uid).collection('Events').add({
      'date': DateTime.now().subtract(Duration(days: 500)),
      'subject': 'Initial Event',
      'title': 'Event for Initialization',
    });
  }

  /*createLessonDoc(String uid, String lessonID) {
      return Firestore.instance.collection('Data').document(uid).collection('Lessons').add({
        'lessonId': lessonID,
        'inProgress': false,
        'isCompleted': false,
    });
  }

  createUserDataCollectionInLesson(String uid, String lessonID) {
    return Firestore.instance.collection('Data').document(uid).collection('Lessons').document(lessonID).collection('Answers').add({
      'selectedAnswer': lessonID,
    });
  }*/

}
