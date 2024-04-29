import 'package:equatable/equatable.dart';
import 'package:mathquiz_mobile/models/quiz.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';

class ExamDetail extends Equatable {
  final int id;
  final int quizId;
  final int examId;

  final int selectedOption;
  final Quiz? quiz;
  final QuizMatrix? quizMatrix;

  const ExamDetail({
    required this.id,
    required this.quizId,
    required this.examId,
    required this.selectedOption,
    this.quiz,
    this.quizMatrix,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, quizId, examId, selectedOption, quiz, quizMatrix];
}
