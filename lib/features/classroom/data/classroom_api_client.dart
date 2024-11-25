import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';

class ClassroomApiClient {
  final DioClient dioClient = DioClient();

  Future<List<Classroom>> getMyClassrooms(String clientId) async {
    try {
      final response = await dioClient.dio.get(
        'classrooms/myClassrooms/',
        queryParameters: {'clientId': clientId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Classroom.fromJson(json)).toList();
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<Classroom>> getMyJoinedClassrooms(String clientId) async {
    try {
      final response = await dio.get(
        'classrooms/myJoinedClassrooms/',
        queryParameters: {'clientId': clientId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Classroom.fromJson(json)).toList();
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
