class Data {
  final String uid;
  final String firstName;
  final String lastName;
  final String username;

  Data({this.uid, this.firstName, this.lastName, this.username});
}

class Question {
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
  bool answered;
}