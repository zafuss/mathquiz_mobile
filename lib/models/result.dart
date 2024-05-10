import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Result extends Equatable {
  final String? id;
  double? score;
  final int totalQuiz;
  int? correctAnswers;
  final DateTime startTime;
  DateTime? endTime;
  final String clientId;
  final String examId;

  Result(
      {this.id,
      this.score,
      required this.startTime,
      this.endTime,
      required this.totalQuiz,
      this.correctAnswers,
      required this.clientId,
      required this.examId});
  factory Result.fromJson(Map<String, dynamic> json) => Result(
      id: json['id'],
      score:
          json['score'] != null ? double.parse(json['score'].toString()) : null,
      totalQuiz: json['totalQuiz'],
      correctAnswers: json['correctAnswers'],
      startTime: DateTime.parse(json['startTime'].toString()),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'].toString())
          : null,
      clientId: json['clientId'],
      examId: json['examId']);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [totalQuiz, correctAnswers, clientId, examId, startTime, endTime, id];
}
