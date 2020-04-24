class Grade {
  final String courseName;
  final String date;
  final int score;
  final double credit;
  final String courseProperty;
  final String testProperty;
  bool selected;

  Grade({this.courseName, this.date, this.score, this.credit, this.courseProperty, this.testProperty, this.selected = false});
}