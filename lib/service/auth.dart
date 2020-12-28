import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_polymer/models/user.dart';
import 'package:project_polymer/service/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

Future registerEP(String email, String password) async  {
  try {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    await DatabaseService(uid: user.uid).updateUserData('2CNFLNE5XB6255666', 'Vision', 'New User');
    return _userFromFirebaseUser(user); 
  }
  catch (e) {
    return null;
  }
}

Future signInEP(String email, String password) async  {
  try {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user); 
  }
  catch (e) {
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
