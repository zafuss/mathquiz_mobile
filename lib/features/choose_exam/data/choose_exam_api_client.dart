import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/models/chapter.dart';
import 'package:mathquiz_mobile/models/exam.dart';
import 'package:mathquiz_mobile/models/level.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';

import '../../../config/http_client.dart';
import '../../../models/grade.dart';

class ChooseExamApiClient {
  Future<List<Level>> getLevels() async {
    try {
      final response = await dio.get(
        'levels/',
      );
      final List<dynamic> responseData = response.data;

      return responseData.map((json) => Level.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<Grade>> getGrades() async {
    try {
      final response = await dio.get(
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
      final response = await dio.get(
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
      final response = await dio.get(
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
      final response = await dio.get(
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
        "timeStart": null,
        "timeEnd": null,
        "quizMatrixId": quizMatrix.id,
        "clientId": clientId,
        "numberOfQuiz": quizMatrix.numOfQuiz,
        "numberOfCorrectAnswer": 0,
        "duration": quizMatrix.defaultDuration,
        "isCustomExam": false,
      };
      final response = await dio.post('exams/', data: body);
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
