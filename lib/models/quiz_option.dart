import 'package:equatable/equatable.dart';

class QuizOption extends Equatable {
  final int id;
  final int quizId;
  final String? option;
  final bool isCorrect;
  final String? quizOptionImage;

  const QuizOption(
      {required this.id,
      required this.quizId,
      this.option,
      required this.isCorrect,
      this.quizOptionImage});
  factory QuizOption.fromJson(Map<String, dynamic> json) => QuizOption(
      id: json['id'],
      quizId: json['quizId'],
      option: json['option'],
      isCorrect: json['isCorrect'],
      quizOptionImage: json['quizOptionImage']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, option, isCorrect, quizId, quizOptionImage];
}
