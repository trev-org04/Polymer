import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference dataCollection = Firestore.instance.collection('Data');

  Future updateUserData (String firstName, String lastName, String username) async {
    return await dataCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
    });
  }

  List<Data> _dataListFromSnapshot (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
        return Data(
          firstName: doc.data['firstName'] ?? '',
          lastName: doc.data['lastName'] ?? '',
          username: doc.data['username'] ?? '',
        );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      username: snapshot.data['username'],
    );
  }

  Stream<List<Data>> get data {
    return dataCollection.snapshots()
    .map(_dataListFromSnapshot);
  }

  Stream<UserData> get userData {
    return dataCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}