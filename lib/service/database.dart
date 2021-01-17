import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference dataCollection =
      Firestore.instance.collection('Data');

  Future updateUserData(
      String firstName, String lastName, String username, int points, int lessonsToResume, String subscriptionLevel) async {
    return await dataCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'points': points,
      'lessonsToResume': lessonsToResume,
      'subscriptionLevel': subscriptionLevel,
    });
  }

  List<Data> _dataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Data(
        firstName: doc.data['firstName'] ?? '',
        lastName: doc.data['lastName'] ?? '',
        username: doc.data['username'] ?? '',
        points: doc.data['points'] ?? '',
        lessonsToResume: doc.data['lessonsToResume'] ?? '',
        subscriptionLevel: doc.data['subscriptionLevel'] ?? '',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      username: snapshot.data['username'],
      points: snapshot.data['points'],
      lessonsToResume: snapshot.data['lessonsToResume'],
      subscriptionLevel: snapshot.data['subscriptionLevel'],
    );
  }

  Stream<List<Data>> get data {
    return dataCollection.snapshots().map(_dataListFromSnapshot);
  }

  Stream<UserData> get userData {
    return dataCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  getLessonsInTopic() async {
    return Firestore.instance.collection("Lessons");
  }
  
  getTopicsInSubject() async {
    return Firestore.instance.collection("Topics");
  }

    getLessonData(String lessonID) async {
    return Firestore.instance.collection("Lessons").document(lessonID).collection('Questions').getDocuments();
  }

    setProgress(String lessonID) async {
    return Firestore.instance.collection("Lessons").document(lessonID);
  }

    progressSnapshot() async {
    return Firestore.instance.collection("Lessons").getDocuments();
  }

    trial(String lessonID) async {
    return Firestore.instance.collection("Lessons").document(lessonID);
  }

}
