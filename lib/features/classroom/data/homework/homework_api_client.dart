import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/homework/classroom_homework_results_dto.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/homework/create_homework_news_dto.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/homework/update_homework_news_dto.dart';
import 'package:mathquiz_mobile/models/classroom_models/homework.dart';
import 'package:mathquiz_mobile/result_type.dart';

class HomeworkApiClient {
  final DioClient dioClient = DioClient();

  Future<List<Homework>> getByClassroomId(String classroomId) async {
    try {
      final response = await dioClient.dio.get(
        'homework/byClassroomId/',
        queryParameters: {'classroomId': classroomId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Homework.fromJson(json)).toList();
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<List<ClassroomHomeworkResultsDto>> getResults(
      String homeworkId) async {
    try {
      final response = await dioClient.dio.get(
        'homework/getResults/',
        queryParameters: {'homeworkId': homeworkId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData
          .map((json) => ClassroomHomeworkResultsDto.fromJson(json))
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

  Future<List<ClassroomHomeworkResultsDto>> getBestResults(
      String homeworkId) async {
    try {
      final response = await dioClient.dio.get(
        'homework/getBestResults/',
        queryParameters: {'homeworkId': homeworkId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData
          .map((json) => ClassroomHomeworkResultsDto.fromJson(json))
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

  // Future<List<Classroom>> getMyJoinedClassrooms(String clientId) async {
  //   try {
  //     final response = await dio.get(
  //       'classrooms/myJoinedClassrooms/',
  //       queryParameters: {'clientId': clientId},
  //     );
  //     print(response);

  //     final List<dynamic> responseData = response.data;
  //     return responseData.map((json) => Classroom.fromJson(json)).toList();
  //   } on DioException catch (e) {
  //     print(e);
  //     if (e.response != null) {
  //       throw Exception(e.response!.data);
  //     } else {
  //       throw Exception(e.message);
  //     }
  //   }
  // }

  Future<ResultType<Homework>> createHomework(
      CreateHomeworkDto createHomeworkDto) async {
    try {
      final response = await dioClient.dio
          .post('homework/', data: createHomeworkDto.toJson());
      print(response);

      return Success(
          Homework.fromJson(response.data), response.statusCode ?? 200);
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

  Future<ResultType<Homework>> editHomework(
      UpdateHomeworkDto updateHomeworkDto) async {
    try {
      final json = updateHomeworkDto.toJson();
      final response = await dioClient.dio
          .put('homework/${updateHomeworkDto.id}', data: json);
      print(response);

      return Success(
          Homework.fromJson(response.data), response.statusCode ?? 200);
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

  // Future<ResultType<String>> createClassroom(
  //     String clientId, String classroomName) async {
  //   try {
  //     final response = await dio.post('classrooms/createClassroom/',
  //         data: {'clientId': clientId, 'classroomName': classroomName});
  //     print(response);

  //     return Success(response.data['classroomId'], 200);
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       int statusCode = e.response!.statusCode ?? 500; // Default status code
  //       if (statusCode == 400) {
  //         return Failure(e.response!.data, statusCode);
  //       } else if (statusCode == 401) {
  //         return Failure(e.response!.data['id'].toString(), statusCode);
  //       }
  //       return Failure('Server error', statusCode);
  //     } else {
  //       return Failure('Network error', 0);
  //     }
  //   } catch (e) {
  //     return Failure('Unknown error', 0);
  //   }
  // }
}
