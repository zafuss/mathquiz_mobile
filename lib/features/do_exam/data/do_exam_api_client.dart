import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/models/exam_detail.dart';
import 'package:mathquiz_mobile/models/quiz.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';

class DoExamApiClient {
  Future<List<ExamDetail>> getExamDetails() async {
    try {
      final response = await dio.get(
        'examDetails/',
      );
      final List<dynamic> responseData = response.data;

      return responseData.map((json) => ExamDetail.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<Quiz>> getQuizs() async {
    try {
      final response = await dio.get(
        'quizs/',
      );
      final List<dynamic> responseData = response.data;

      return responseData.map((json) => Quiz.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<QuizOption>> getQuizOptions() async {
    try {
      final response = await dio.get(
        'quizOptions/',
      );
      final List<dynamic> responseData = response.data;

      return responseData.map((json) => QuizOption.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> addExamDetail(String examId, int quizId) async {
    try {
      final body = {'examId': examId, 'quizId': quizId, 'selectedOption': -1};
      final response = await dio.post('examDetails/', data: body);
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> updateExamDetail(ExamDetail examDetail) async {
    try {
      final body = {
        'id': examDetail.id,
        'examId': examDetail.examId,
        'quizId': examDetail.quizId,
        'selectedOption': examDetail.selectedOption
      };
      final response =
          await dio.put('examDetails/${examDetail.id}', data: body);
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
