import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/result_type.dart';

import '../../../../models/classroom_models/classroom_detail.dart';

class ClassroomDetailApiClient {
  final DioClient dioClient = DioClient();

  Future<List<ClassroomDetail>> getMyClassroomDetailsByClassroomId(
      String classroomId) async {
    try {
      final response = await dioClient.dio.get(
        'classroomDetails/byClassroomId/',
        queryParameters: {'classroomId': classroomId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData
          .map((json) => ClassroomDetail.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<ClassroomDetail>> getMyJoinedClassroomDetails(
      String clientId) async {
    try {
      final response = await dioClient.dio.get(
        'classroomDetails/myJoinedClassroomDetails/',
        queryParameters: {'clientId': clientId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData
          .map((json) => ClassroomDetail.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<bool> changeIsDeletedStatus(String classroomDetailId) async {
    try {
      await dioClient.dio.put(
        'classroomDetails/changeIsDeletedStatus/',
        queryParameters: {'id': classroomDetailId},
      );
      return true;
    } on DioException catch (e) {
      print(e);
      // if (e.response != null) {

      //   throw Exception(e.response!.data);
      // } else {
      //   throw Exception(e.message);
      // }
      return false;
    }
  }

  Future<ResultType<String>> joinClassroomDetail(
      String clientId, String classroomDetailId) async {
    try {
      final response = await dioClient.dio.post(
          'classroomDetails/joinClassroomDetail/',
          data: {'clientId': clientId, 'classroomDetailId': classroomDetailId});
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

  Future<ResultType<String>> createClassroomDetail(
      String clientId, String classroomDetailName) async {
    try {
      final response = await dioClient.dio
          .post('classroomDetails/createClassroomDetail/', data: {
        'clientId': clientId,
        'classroomDetailName': classroomDetailName
      });
      print(response);

      return Success(response.data['classroomDetailId'], 200);
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
