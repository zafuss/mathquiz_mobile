import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/classroom/data/classroom_repository.dart';
import 'package:mathquiz_mobile/helpers/data_loading.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';
import 'package:mathquiz_mobile/result_type.dart';

class ClassroomController extends GetxController {
  Rx<DataLoading> joinClassroomLoading = Rx<DataLoading>(DataLoading());
  var dialogLoading = false.obs;
  var dialogMessage = ''.obs;
  var isLoading = false.obs;
  var isJoiningClassroom = false.obs;
  Rx<Classroom?> chosenClassroom = Rx<Classroom?>(null);
  RxList<Classroom> myClassrooms = <Classroom>[].obs;
  RxList<Classroom> myJoinedClassrooms = <Classroom>[].obs;
  ClassroomRepository classroomRepository = ClassroomRepository();
  LocalDataController localDataController = LocalDataController();

  @override
  void onInit() async {
    super.onInit();
    await fetchMyClassrooms();
    await fetchMyJoinedClassrooms();
  }

  fetchMyClassrooms() async {
    isLoading.value = true;
    var result = await classroomRepository.getMyClassrooms();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          myClassrooms.value = result.data!,
          myClassrooms.sort((a, b) => b.createDate.compareTo(a.createDate))
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin lớp học.', result.message),
    });
  }

  Future<Object> joinClassroom(String classroomId, BuildContext context) async {
    joinClassroomLoading.value.isLoading = true;
    var clientId = await localDataController.getClientId();
    var result = await classroomRepository.joinClassroom(
        clientId: clientId!, classroomId: classroomId);
    joinClassroomLoading.value.isLoading = false;
    return (switch (result) {
      Success() => {
          Navigator.of(context).pop(),
          Get.snackbar('Thông báo', "Tham gia lớp học thành công!"),
        },
      Failure() => {
          joinClassroomLoading.update((data) {
            data?.resultMessage = result.message;
          })
        }
    });
  }

  Future<Object> createClassroom(
      String classroomName, BuildContext context) async {
    dialogLoading.value = true;
    var clientId = await localDataController.getClientId();
    var result = await classroomRepository.createClassroom(
        clientId: clientId!, classroomName: classroomName);
    return (switch (result) {
      Success() => {
          dialogLoading.value = false,
          dialogMessage.value = result.data,
          result,
          await fetchMyClassrooms(),
          await fetchMyJoinedClassrooms(),
        },
      Failure() => {dialogLoading.value = true, result}
    });
  }

  fetchMyJoinedClassrooms() async {
    isLoading.value = true;
    var result = await classroomRepository.getMyJoinedClassrooms();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          myJoinedClassrooms.value = result.data!,
          myJoinedClassrooms
              .sort((a, b) => b.createDate.compareTo(a.createDate))
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin lớp học.', result.message),
    });
  }
}
