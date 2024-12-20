import 'package:mathquiz_mobile/helpers/classroom_datetime_formatter.dart';

class UpdateHomeworkDto {
  final String id;
  final String title;
  final String content;
  final DateTime handinDate;
  final DateTime expiredDate;
  final int quizMatrixId;
  final int status;
  final int attempt;

  const UpdateHomeworkDto(
      {required this.id,
      required this.title,
      required this.content,
      required this.handinDate,
      required this.expiredDate,
      required this.quizMatrixId,
      required this.status,
      required this.attempt});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'handinDate': convertDateTime(handinDate),
        'expiredDate': convertDateTime(expiredDate),
        'quizMatrixId': quizMatrixId,
        'attempt': attempt,
        'status': status
      };
}
