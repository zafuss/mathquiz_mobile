import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';
import 'package:mathquiz_mobile/result_type.dart';

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
      final response = await dioClient.dio.get(
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

  Future<ResultType<String>> joinClassroom(
      String clientId, String classroomId) async {
    try {
      final response = await dioClient.dio.post('classrooms/joinClassroom/',
          data: {'clientId': clientId, 'classroomId': classroomId});
      print(response);

      return Success(response.data, response.statusCode ?? 200);
    } on DioException catch (e) {
      if (e.response != null) {
        int statusCode = e.response!.statusCode ?? 500; // Default status code
        if (statusCode == 400) {
          return Failure(e.response!.data, statusCode);
        } else if (statusCode == 401) {
          return Failure(e.response!.data['id'].toString(), statusCode);
        }
        return Failure('Server error', statusCode);
      } else {
        return Failure('Network error', 0);
      }
    } catch (e) {
      return Failure('Unknown error', 0);
    }
  }

  Future<ResultType<String>> createClassroom(
      String clientId, String classroomName) async {
    try {
      final response = await dioClient.dio.post('classrooms/createClassroom/',
          data: {'clientId': clientId, 'classroomName': classroomName});
      print(response);

      return Success(response.data['classroomId'], 200);
    } on DioException catch (e) {
      if (e.response != null) {
        int statusCode = e.response!.statusCode ?? 500; // Default status code
        if (statusCode == 400) {
          return Failure(e.response!.data, statusCode);
        } else if (statusCode == 401) {
          return Failure(e.response!.data['id'].toString(), statusCode);
        }
        return Failure('Server error', statusCode);
      } else {
        return Failure('Network error', 0);
      }
    } catch (e) {
      return Failure('Unknown error', 0);
    }
  }

  Future<ResultType<String>> putClassroom(
      String classroomId, String classroomName) async {
    try {
      final response = await dioClient.dio.put('classrooms/',
          queryParameters: {'id': classroomId, 'newName': classroomName});
      print(response);

      return Success(response.data['classroomId'], 200);
    } on DioException catch (e) {
      if (e.response != null) {
        int statusCode = e.response!.statusCode ?? 500; // Default status code
        if (statusCode == 400) {
          return Failure(e.response!.data, statusCode);
        } else if (statusCode == 401) {
          return Failure(e.response!.data['id'].toString(), statusCode);
        }
        return Failure('Server error', statusCode);
      } else {
        return Failure('Network error', 0);
      }
    } catch (e) {
      return Failure('Unknown error', 0);
    }
  }
}
