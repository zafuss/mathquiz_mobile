import 'package:equatable/equatable.dart';

class QuizMatrix extends Equatable {
  final int id;
  final String? name;
  final int? defaultDuration;
  final int? numOfQuiz;
  final int? chapterId;
  final DateTime? createDate;
  final DateTime? updateDate;
  // List<ExamDetail>? examDetails;

  const QuizMatrix({
    required this.id,
    this.name,
    this.numOfQuiz,
    this.defaultDuration,
    this.chapterId,
    this.createDate,
    this.updateDate,
    // this.examDetails,
  });
  factory QuizMatrix.fromJson(Map<String, dynamic> json) => QuizMatrix(
        id: json['id'],
        name: json['name'],
        numOfQuiz: json['numOfQuiz'],
        chapterId: json['chapterId'],
        defaultDuration: json['defaultDuration'],
        createDate: json['createDate'] != null
            ? DateTime.parse(json['createDate'])
            : null,
        updateDate: json['updateDate'] != null
            ? DateTime.parse(json['updateDate'])
            : null,
      );
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        numOfQuiz,
        chapterId,
        createDate,
        defaultDuration,
        updateDate,
        // examDetails
      ];
}
