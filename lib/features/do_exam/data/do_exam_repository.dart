import 'package:mathquiz_mobile/features/do_exam/data/do_exam_api_client.dart';
import 'package:mathquiz_mobile/models/exam_detail.dart';
import 'package:mathquiz_mobile/models/quiz.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';
import 'package:mathquiz_mobile/result_type.dart';

class DoExamRepository {
  final DoExamApiClient doExamApiClient = DoExamApiClient();

  Future<Result<List<ExamDetail>?>> getExamDetails() async {
    try {
      var examDetailList = await doExamApiClient.getExamDetails();
      return Success(examDetailList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<Result<List<Quiz>?>> getQuizs() async {
    try {
      var quizList = await doExamApiClient.getQuizs();
      return Success(quizList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<Result<List<QuizOption>?>> getQuizOptions() async {
    try {
      var quizOptionList = await doExamApiClient.getQuizOptions();
      return Success(quizOptionList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<Result<bool>>? addExamDetail(String examId, int quizId) async {
    await doExamApiClient.addExamDetail(examId, quizId);
    try {
      return Success(true);
    } catch (e) {
      return Failure('$e');
    }
  }
}
