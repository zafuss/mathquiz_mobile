import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/models/chapter.dart';
import 'package:mathquiz_mobile/models/level.dart';

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
}
