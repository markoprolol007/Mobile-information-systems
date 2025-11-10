class Exam {
  final String examName;
  final DateTime dateTime;
  final List<String> rooms;
  final bool isPassed;

  Exam({
    required this.examName,
    required this.dateTime,
    required this.rooms,
    this.isPassed = true,
  });
}