class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String firstName;
  final String lastName;
  final String username;
  final int points;
  final int lessonsToResume;
  final String subscriptionLevel;

  UserData({this.uid, this.firstName, this.lastName, this.username, this.points, this.lessonsToResume, this.subscriptionLevel});
}
