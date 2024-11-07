class ChapterInfoDto {
  final String chapterName;
  final String quizMatrixName;
  final int numOfQuiz;
  final int duration;
  final int mathType;
  final int grade;

  ChapterInfoDto(
      {required this.chapterName,
      required this.quizMatrixName,
      required this.numOfQuiz,
      required this.duration,
      required this.mathType,
      required this.grade});
}
