import 'package:mathquiz_mobile/features/do_exam/data/do_exam_api_client.dart';
import 'package:mathquiz_mobile/models/exam_detail.dart';
import 'package:mathquiz_mobile/models/quiz.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';
import 'package:mathquiz_mobile/models/result.dart';
import 'package:mathquiz_mobile/result_type.dart';

class DoExamRepository {
  final DoExamApiClient doExamApiClient = DoExamApiClient();

  Future<ResultType<List<ExamDetail>?>> getExamDetails() async {
    try {
      var examDetailList = await doExamApiClient.getExamDetails();
      return Success(examDetailList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<Quiz>?>> getQuizs() async {
    try {
      var quizList = await doExamApiClient.getQuizs();
      return Success(quizList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<QuizOption>?>> getQuizOptions() async {
    try {
      var quizOptionList = await doExamApiClient.getQuizOptions();
      return Success(quizOptionList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<Result>?>> getResults() async {
    try {
      var resultList = await doExamApiClient.getResults();
      return Success(resultList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>>? addExamDetail(String examId, int quizId) async {
    await doExamApiClient.addExamDetail(examId, quizId);
    try {
      return Success(true);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>>? addResult(Result result) async {
    await doExamApiClient.addResult(result);
    try {
      return Success(true);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>>? updateExamDetail(ExamDetail examDetail) async {
    await doExamApiClient.updateExamDetail(examDetail);
    try {
      return Success(true);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>>? updateResult(Result result) async {
    await doExamApiClient.updateResult(result);
    try {
      return Success(true);
    } catch (e) {
      return Failure('$e');
    }
  }
}
