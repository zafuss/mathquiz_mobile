import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/models/exam_detail.dart';
import 'package:mathquiz_mobile/models/quiz.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';
import 'package:mathquiz_mobile/models/result.dart';

class DoExamApiClient {
  final DioClient dioClient = DioClient();

  Future<List<ExamDetail>> getExamDetails() async {
    try {
      final response = await dioClient.dio.get(
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
      final response = await dioClient.dio.get(
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
      final response = await dioClient.dio.get(
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

  Future<List<Result>> getResults() async {
    try {
      final response = await dioClient.dio.get(
        'results/',
      );
      final List<dynamic> responseData = response.data;

      return responseData.map((json) => Result.fromJson(json)).toList();
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
      final response = await dioClient.dio.post('examDetails/', data: body);
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> addResult(Result result) async {
    try {
      final body = {
        'id': result.id,
        'score': result.score,
        'totalQuiz': result.totalQuiz,
        'correctAnswers': result.correctAnswers,
        'startTime': convertDateTimeFormat(result.startTime.toString()),
        'endTime': result.endTime,
        'clientId': result.clientId,
        'examId': result.examId,
        'exam': null,
        'client': null
      };

      final response = await dioClient.dio.post('results/', data: body);
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
          await dioClient.dio.put('examDetails/${examDetail.id}', data: body);
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> updateResult(Result result) async {
    try {
      final body = {
        'id': result.id,
        'score': result.score,
        'totalQuiz': result.totalQuiz,
        'correctAnswers': result.correctAnswers,
        'startTime': convertDateTimeFormat(result.startTime.toString()),
        'endTime': convertDateTimeFormat(result.endTime.toString()),
        'clientId': result.clientId,
        'examId': result.examId
      };
      final response =
          await dioClient.dio.put('results/${result.id}', data: body);
      print(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['statusMessage']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  String convertDateTimeFormat(String inputDateString) {
    // Định dạng chuỗi ngày giờ đầu vào
    String inputFormatString = "yyyy-MM-dd HH:mm:ss.SSSSSS";
    String outputFormatString = "yyyy-MM-ddTHH:mm:ss";
    DateFormat inputFormat = DateFormat(inputFormatString);

    // Định dạng chuỗi ngày giờ đầu ra
    DateFormat outputFormat = DateFormat(outputFormatString);

    // Chuyển đổi chuỗi ngày giờ
    DateTime inputDate = inputFormat.parse(inputDateString);
    String outputDateString = outputFormat.format(inputDate);

    return outputDateString;
  }
}
