import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_api_client.dart';
import 'package:mathquiz_mobile/features/choose_exam/dtos/ranking_dto.dart';
import 'package:mathquiz_mobile/models/chapter.dart';
import 'package:mathquiz_mobile/models/classroom_models/homework.dart';
import 'package:mathquiz_mobile/models/exam.dart';
import 'package:mathquiz_mobile/models/grade.dart';
import 'package:mathquiz_mobile/models/level.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';
import 'package:mathquiz_mobile/result_type.dart';

class ChooseExamRepository {
  final ChooseExamApiClient chooseExamApiClient = ChooseExamApiClient();
  final LocalDataController localDataController =
      Get.put(LocalDataController());

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

  Future<ResultType<Level>?> fetchClientLevel(List<Level> levelList) async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);

      var gradeList = await chooseExamApiClient.getGrades();
      var clientGradeId = await localDataController.getClientGradeId();
      var currentGrade =
          gradeList.firstWhere((element) => element.id == clientGradeId);
      var level = levelList.firstWhere((l) => l.id == currentGrade.levelId);
      await localDataController.saveClientLevelId(level.id);
      return Success(level);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<int?> fetchClientLevelId() async {
    var levelId = await localDataController.getClientLevelId();
    if (levelId == null) {
      var levelList = await chooseExamApiClient.getLevels();
      await fetchClientLevel(levelList);
    }
    levelId = await localDataController.getClientLevelId();
    return levelId;
  }

  fetchClientGradeId() async {
    final gradeId = await localDataController.getClientGradeId();
    return gradeId;
  }

  Future<ResultType<Grade>?> fetchClientGrade() async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      var gradeList = await chooseExamApiClient.getGrades();
      var clientGradeId = await localDataController.getClientGradeId();
      var currentGrade =
          gradeList.firstWhere((element) => element.id == clientGradeId);

      return Success(currentGrade);
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

  Future<ResultType<List<RankingDto>?>> getRanking(int chapterId) async {
    try {
      // final loginSuccessDto = await authApiClient.login(
      //   LoginDto(username: username, password: password),
      // );
      // await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      var ranking = await chooseExamApiClient.getRanking(chapterId);
      return Success(ranking);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>>? addNewDefaultExam(QuizMatrix quizMatrix,
      String clientId, String examId, Homework? homework) async {
    await chooseExamApiClient.addNewDefaultExam(
        quizMatrix, clientId, examId, homework);
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
