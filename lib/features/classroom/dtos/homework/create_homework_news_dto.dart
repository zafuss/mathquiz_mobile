import 'package:mathquiz_mobile/helpers/classroom_datetime_formatter.dart';

class CreateHomeworkDto {
  final String title;
  final String content;
  final DateTime handinDate;
  final DateTime expiredDate;
  final int quizMatrixId;
  final String classroomId;
  final int attempt;

  const CreateHomeworkDto({
    required this.title,
    required this.content,
    required this.handinDate,
    required this.expiredDate,
    required this.quizMatrixId,
    required this.classroomId,
    required this.attempt,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'handinDate': convertDateTime(handinDate),
        'expiredDate': convertDateTime(expiredDate),
        'quizMatrixId': quizMatrixId,
        'classroomId': classroomId,
        'attempt': attempt
      };
}
