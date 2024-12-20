import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/homework/classroom_homework_results_dto.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/homework/update_homework_news_dto.dart';

import '../../../../models/classroom_models/homework.dart';
import '../../../../result_type.dart';
import '../../dtos/homework/create_homework_news_dto.dart';
import 'homework_api_client.dart';

class HomeworkRepository {
  final homeworkApiClient = HomeworkApiClient();
  final localDataController = Get.put(LocalDataController(), permanent: true);

  Future<ResultType<List<Homework>?>> getByClassroomId(String newsId) async {
    try {
      var result = await homeworkApiClient.getByClassroomId(newsId);
      return Success(result);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<ClassroomHomeworkResultsDto>?>> getResults(
      String homeworkId) async {
    try {
      var result = await homeworkApiClient.getResults(homeworkId);
      return Success(result);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<ClassroomHomeworkResultsDto>?>> getBestResults(
      String homeworkId) async {
    try {
      var result = await homeworkApiClient.getBestResults(homeworkId);
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

  Future<ResultType<Homework>> createHomework(
      CreateHomeworkDto createHomeworkDto) async {
    try {
      final result = await homeworkApiClient.createHomework(createHomeworkDto);
      return result;
    } catch (e) {
      return Failure('Unknown error');
    }
  }

  Future<ResultType<Homework>> editHomework(
      UpdateHomeworkDto updateHomeworkDto) async {
    try {
      final result = await homeworkApiClient.editHomework(updateHomeworkDto);
      return result;
    } catch (e) {
      return Failure('Unknown error');
    }
  }

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
