import 'package:equatable/equatable.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';

class Quiz extends Equatable {
  final int id;
  final String? statement;
  final String? solution;
  final String? image;
  final String? imageSolution;
  // Difficulty? difficulty;
  final QuizMatrix? quizMatrix;

  const Quiz({
    required this.id,
    this.statement,
    this.solution,
    this.image,
    this.imageSolution,
    this.quizMatrix,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
      id: json['id'],
      statement: json['statement'],
      solution: json['solution'],
      image: json['image'],
      imageSolution: json['imageSolution'],
      quizMatrix: json['quizMatrix']);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, statement, solution, image, imageSolution, quizMatrix, quizMatrix];
}
