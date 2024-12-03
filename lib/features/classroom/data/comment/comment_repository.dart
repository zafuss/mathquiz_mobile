import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/classroom/data/comment/comment_api_client.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/comment/create_comment_dto.dart';
import 'package:mathquiz_mobile/models/classroom_models/comments.dart';

import '../../../../result_type.dart';

class CommentRepository {
  final commentApiClient = CommentApiClient();
  final localDataController = Get.put(LocalDataController(), permanent: true);

  Future<ResultType<List<Comment>?>> getByNews(String newsId) async {
    try {
      var result = await commentApiClient.getByNews(newsId);
      return Success(result);
    } catch (e) {
      return Failure('$e');
    }
  }

  // Future<ResultType<bool>> changeIsDeletedStatus(
  //     String classroomDetailId) async {
  //   try {
  //     var result = await classroomDetailApiClient
  //         .changeIsDeletedStatus(classroomDetailId);
  //     return Success(result);
  //   } catch (e) {
  //     return Failure('$e');
  //   }
  // }

  // Future<ResultType<List<ClassroomDetail>?>>
  //     getMyJoinedClassroomDetails() async {
  //   try {
  //     String clientId = await localDataController.getClientId() ?? '';
  //     var ranking =
  //         await classroomDetailApiClient.getMyJoinedClassroomDetails(clientId);
  //     return Success(ranking);
  //   } catch (e) {
  //     return Failure('$e');
  //   }
  // }

  Future<ResultType<Comment>> createNewsComment(
      CreateCommentDto createCommentDto) async {
    try {
      final result = await commentApiClient.createNewsComment(createCommentDto);
      return result;
    } catch (e) {
      return Failure('Unknown error');
    }
  }

  // Future<ResultType<News>> editNews(UpdateNewsDto updateNewsDto) async {
  //   try {
  //     final result = await newsApiClient.editNews(updateNewsDto);
  //     return result;
  //   } catch (e) {
  //     return Failure('Unknown error');
  //   }
  // }

  // Future<ResultType<String>> createClassroomDetail(
  //     {required String clientId, required String classroomDetailName}) async {
  //   try {
  //     final result = await classroomDetailApiClient.createClassroomDetail(
  //         clientId, classroomDetailName);
  //     if (result is Success<String>) {
  //       return Success(result.data);
  //     } else if (result is Failure<String>) {
  //       // Handle failure
  //       return result; // Return the Failure result
  //     } else {
  //       // Handle other cases
  //       return Failure('Unknown error');
  //     }
  //   } catch (e) {
  //     return Failure('Unknown error');
  //   }
  // }
}
