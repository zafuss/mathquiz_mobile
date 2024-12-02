import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';

import '../../../../models/classroom_models/classroom_detail.dart';
import '../../../../result_type.dart';
import 'classroom_detail_api_client.dart';

class ClassroomDetailRepository {
  final classroomDetailApiClient = ClassroomDetailApiClient();
  final localDataController = Get.put(LocalDataController(), permanent: true);

  Future<ResultType<List<ClassroomDetail>?>> getMyClassroomDetailsByClassroomId(
      String classroomId) async {
    try {
      var ranking = await classroomDetailApiClient
          .getMyClassroomDetailsByClassroomId(classroomId);
      return Success(ranking);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<bool>> changeIsDeletedStatus(
      String classroomDetailId) async {
    try {
      var result = await classroomDetailApiClient
          .changeIsDeletedStatus(classroomDetailId);
      return Success(result);
    } catch (e) {
      return Failure('$e');
    }
  }

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

  // Future<ResultType<String>> joinClassroomDetail(
  //     {required String clientId, required String classroomDetailId}) async {
  //   try {
  //     final result = await classroomDetailApiClient.joinClassroomDetail(
  //         clientId, classroomDetailId);
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
