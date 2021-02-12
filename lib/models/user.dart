class User {
  final String uid;

  User({this.uid});
}

class UserData {
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

  UserData({this.uid, this.firstName, this.lastName, this.email, this.username, this.points, this.lessonsToResume, this.subscriptionLevel, this.isLight, this.sendNotifications});
}
