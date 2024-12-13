import 'package:equatable/equatable.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';

class Homework extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createDate;
  final DateTime handinDate;
  final DateTime expiredDate;
  final QuizMatrix? quizMatrix;
  final Classroom? classroom;
  final int attempt;

  const Homework(
      {required this.id,
      required this.title,
      required this.content,
      required this.createDate,
      required this.handinDate,
      required this.expiredDate,
      this.quizMatrix,
      this.classroom,
      required this.attempt});

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
      id: json['id'],
      title: json['title'],
      content: json['content'] ?? '',
      createDate: DateTime.parse(json['createDate']),
      handinDate: DateTime.parse(json['handinDate']),
      expiredDate: DateTime.parse(json['expiredDate']),
      quizMatrix: json['quizMatrix'] != null
          ? QuizMatrix.fromJson(json['quizMatrix'])
          : null,
      classroom: json['classroom'] != null
          ? Classroom.fromJson(json['classroom'])
          : null,
      attempt: json['attempt']);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        content,
        title,
        createDate,
        handinDate,
        expiredDate,
        quizMatrix,
        classroom
      ];
}
