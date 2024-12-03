import 'package:dio/dio.dart';
import 'package:mathquiz_mobile/config/http_client.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/comment/create_comment_dto.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/news/update_news_dto.dart';
import 'package:mathquiz_mobile/models/classroom_models/comments.dart';
import 'package:mathquiz_mobile/models/classroom_models/news.dart';
import 'package:mathquiz_mobile/result_type.dart';

class CommentApiClient {
  final DioClient dioClient = DioClient();

  Future<List<Comment>> getByNews(String newsId) async {
    try {
      final response = await dio.get(
        'comments/byNews/',
        queryParameters: {'newsId': newsId},
      );
      print(response);

      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Comment.fromJson(json)).toList();
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

  Future<ResultType<Comment>> createNewsComment(
      CreateCommentDto createCommentDto) async {
    try {
      final response =
          await dio.post('comments/byNews', data: createCommentDto.toJson());
      print(response);

      return Success(
          Comment.fromJson(response.data), response.statusCode ?? 200);
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

  Future<ResultType<News>> editNews(UpdateNewsDto updateNewsDto) async {
    try {
      final response = await dio.put('news/${updateNewsDto.id}',
          data: updateNewsDto.toJson());
      print(response);

      return Success(News.fromJson(response.data), response.statusCode ?? 200);
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
