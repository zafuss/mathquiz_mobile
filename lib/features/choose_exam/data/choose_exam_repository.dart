import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_api_client.dart';
import 'package:mathquiz_mobile/models/chapter.dart';
import 'package:mathquiz_mobile/models/exam.dart';
import 'package:mathquiz_mobile/models/grade.dart';
import 'package:mathquiz_mobile/models/level.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';
import 'package:mathquiz_mobile/result_type.dart';

class ChooseExamRepository {
  final ChooseExamApiClient chooseExamApiClient = ChooseExamApiClient();
  Future<ResultType<List<Level>?>> getLevels() async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      var levelList = await chooseExamApiClient.getLevels();
      return Success(levelList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<Grade>?>> getGrades() async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      var gradeList = await chooseExamApiClient.getGrades();
      return Success(gradeList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<Chapter>?>> getChapters() async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      var chapterList = await chooseExamApiClient.getChapters();
      return Success(chapterList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<QuizMatrix>?>> getQuizMatrices() async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      var quizMatrixList = await chooseExamApiClient.getQuizMatrices();
      return Success(quizMatrixList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<Exam>?>> getExams() async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      var examList = await chooseExamApiClient.getExams();
      return Success(examList);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>>? addNewDefaultExam(
      QuizMatrix quizMatrix, String clientId, String examId) async {
    await chooseExamApiClient.addNewDefaultExam(quizMatrix, clientId, examId);
    try {
      return Success(true);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>>? addCustomExam(QuizMatrix quizMatrix,
      String clientId, String examId, int duration, int numOfQuiz) async {
    await chooseExamApiClient.addCustomExam(
        quizMatrix, clientId, examId, numOfQuiz, duration);
    try {
      return Success(true);
    } catch (e) {
      return Failure('$e');
    }
  }
}
