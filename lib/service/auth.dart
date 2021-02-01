import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_polymer/service/database.dart';
import 'package:project_polymer/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future registerEP(String firstName, String lastName, String username,
      String email, String password) async {
    int points = 0;
    int lessonsToResume = 0;
    String subscriptionLevel = 'Basic';
    bool isLight = false;
    bool sendNotifications = false;
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData(firstName, lastName, username, points, lessonsToResume, subscriptionLevel, isLight, sendNotifications);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Future signInEP(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
