import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/features/choose_exam/dtos/ranking_dto.dart';
import 'package:mathquiz_mobile/models/chapter.dart';
import 'package:mathquiz_mobile/models/exam.dart';
import 'package:mathquiz_mobile/models/level.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';

import '../../../config/http_client.dart';
import '../../../models/grade.dart';

class ChooseExamApiClient {
  final DioClient dioClient = DioClient();

  Future<List<Level>> getLevels() async {
    try {
      final response = await dio.get(
        'levels/',
      );
      final List<dynamic> responseData = response.data;

      return responseData.map((json) => Level.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['statusMessage']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<RankingDto>> getRanking(int chapterId) async {
    try {
      final response = await dio.get(
        'chapters/ranking',
        queryParameters: {'chapterId': chapterId}, // Use queryParameters here
      );
      final List<dynamic> responseData = response.data;

      return responseData.map((json) => RankingDto.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['statusMessage']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<Grade>> getGrades() async {
    try {
      final response = await dioClient.dio.get(
        'grades/',
      );
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Grade.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<Chapter>> getChapters() async {
    try {
      final response = await dioClient.dio.get(
        'chapters/',
      );
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Chapter.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<QuizMatrix>> getQuizMatrices() async {
    try {
      final response = await dioClient.dio.get(
        'quizmatrices/',
      );
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => QuizMatrix.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<Exam>> getExams() async {
    try {
      final response = await dioClient.dio.get(
        'exams/',
      );
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Exam.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> addNewDefaultExam(
      QuizMatrix quizMatrix, String clientId, String examId) async {
    try {
      final body = {
        "id": examId,
        "name": quizMatrix.name,
        "quizMatrixId": quizMatrix.id,
        "clientId": clientId,
        "numberOfQuiz": quizMatrix.numOfQuiz,
        "numberOfCorrectAnswer": 0,
        "duration": quizMatrix.defaultDuration,
        "isCustomExam": false,
      };
      final response = await dioClient.dio.post('exams/', data: body);
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> addCustomExam(QuizMatrix quizMatrix, String clientId,
      String examId, int numOfQuiz, int duration) async {
    try {
      final body = {
        "id": examId,
        "name": quizMatrix.name,
        "quizMatrixId": quizMatrix.id,
        "clientId": clientId,
        "numberOfQuiz": numOfQuiz,
        "numberOfCorrectAnswer": 0,
        "duration": duration,
        "isCustomExam": true,
      };
      final response = await dioClient.dio.post('exams/', data: body);
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
