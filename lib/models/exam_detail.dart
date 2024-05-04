import 'package:equatable/equatable.dart';

class ExamDetail extends Equatable {
  final int id;
  final int quizId;
  final String examId;
  final int selectedOption;

  const ExamDetail({
    required this.id,
    required this.quizId,
    required this.examId,
    required this.selectedOption,
  });

  factory ExamDetail.fromJson(Map<String, dynamic> json) => ExamDetail(
      id: json['id'],
      quizId: json['quizId'],
      examId: json['examId'],
      selectedOption: json['selectedOption']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, quizId, examId, selectedOption];
}
