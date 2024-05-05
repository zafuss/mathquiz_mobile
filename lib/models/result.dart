import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final double score;
  final int totalQuiz;
  final int correctAnswers;
  final String clientId;
  final String examId;

  const Result(
      {required this.score,
      required this.totalQuiz,
      required this.correctAnswers,
      required this.clientId,
      required this.examId});

  @override
  // TODO: implement props
  List<Object?> get props => [totalQuiz, correctAnswers, clientId, examId];
}
