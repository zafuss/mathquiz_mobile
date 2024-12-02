import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';

import '../../../../result_type.dart';
import 'classroom_api_client.dart';

class ClassroomRepository {
  final classroomApiClient = ClassroomApiClient();
  final localDataController = Get.put(LocalDataController(), permanent: true);

  Future<ResultType<List<Classroom>?>> getMyClassrooms() async {
    try {
      String clientId = await localDataController.getClientId() ?? '';
      var ranking = await classroomApiClient.getMyClassrooms(clientId);
      return Success(ranking);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<List<Classroom>?>> getMyJoinedClassrooms() async {
    try {
      String clientId = await localDataController.getClientId() ?? '';
      var ranking = await classroomApiClient.getMyJoinedClassrooms(clientId);
      return Success(ranking);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<ResultType<String>> joinClassroom(
      {required String clientId, required String classroomId}) async {
    try {
      final result =
          await classroomApiClient.joinClassroom(clientId, classroomId);
      if (result is Success<String>) {
        return Success(result.data);
      } else if (result is Failure<String>) {
        // Handle failure
        return result; // Return the Failure result
      } else {
        // Handle other cases
        return Failure('Unknown error');
      }
    } catch (e) {
      return Failure('Unknown error');
    }
  }

  Future<ResultType<String>> createClassroom(
      {required String clientId, required String classroomName}) async {
    try {
      final result =
          await classroomApiClient.createClassroom(clientId, classroomName);
      if (result is Success<String>) {
        return Success(result.data);
      } else if (result is Failure<String>) {
        // Handle failure
        return result; // Return the Failure result
      } else {
        // Handle other cases
        return Failure('Unknown error');
      }
    } catch (e) {
      return Failure('Unknown error');
    }
  }
}
