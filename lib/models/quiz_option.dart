import 'package:equatable/equatable.dart';

class QuizOption extends Equatable {
  final int id;
  final int quizId;
  final String? option;
  final bool isCorrect;

  const QuizOption({
    required this.id,
    required this.quizId,
    this.option,
    required this.isCorrect,
  });
  factory QuizOption.fromJson(Map<String, dynamic> json) => QuizOption(
      id: json['id'],
      quizId: json['quizId'],
      option: json['option'],
      isCorrect: json['isCorrect']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, option, isCorrect, quizId];
}
