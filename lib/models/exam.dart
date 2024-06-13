import 'package:equatable/equatable.dart';

import 'exam_detail.dart';

class Exam extends Equatable {
  final String id;
  final String? name;
  final int? numberOfQuiz;
  final int? numberOfCorrectAnswer;
  final int? duration;
  final List<ExamDetail>? examDetails;
  final bool isCustomExam;
  // List<Result>? results;
  final String? clientId;
  final int? quizMatrixId;

  const Exam(
      {required this.id,
      this.name,
      required this.numberOfQuiz,
      required this.numberOfCorrectAnswer,
      required this.duration,
      this.examDetails,
      required this.isCustomExam,
      // this.results,
      required this.clientId,
      required this.quizMatrixId});
  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
      id: json['id'],
      name: json['name'],
      numberOfQuiz: json['numberOfQuiz'],
      numberOfCorrectAnswer: json['numberOfCorrectAnswer'],
      duration: json['duration'],
      clientId: json['clientId'],
      isCustomExam: json['isCustomExam'],
      quizMatrixId: json['quizMatrixId']);
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        numberOfQuiz,
        numberOfCorrectAnswer,
        duration,
        clientId,
        examDetails,
        isCustomExam,
        quizMatrixId
      ];
}
