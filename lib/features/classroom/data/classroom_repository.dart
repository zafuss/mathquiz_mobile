import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';

import '../../../result_type.dart';
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
}
