import 'package:mathquiz_mobile/models/classroom_models/homework.dart';
import 'package:mathquiz_mobile/models/client.dart';
import 'package:mathquiz_mobile/models/result.dart';

class ClassroomHomeworkResultsDto {
  final Homework homework;
  final Client student;
  final Result? result;
  final int? attemptCount;

  const ClassroomHomeworkResultsDto(
      {required this.homework,
      required this.student,
      this.result,
      this.attemptCount});

  factory ClassroomHomeworkResultsDto.fromJson(Map<String, dynamic> json) {
    return ClassroomHomeworkResultsDto(
        homework: Homework.fromJson(json['homework']),
        student: Client.fromJson(json['student']),
        result: json['result'] != null ? Result.fromJson(json['result']) : null,
        attemptCount: json['attemptCount']);
  }
}
