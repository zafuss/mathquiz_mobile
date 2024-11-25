import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/classroom/data/classroom_repository.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';
import 'package:mathquiz_mobile/result_type.dart';

class ClassroomController extends GetxController {
  var isLoading = false.obs;
  Rx<Classroom?> chosenClassroom = Rx<Classroom?>(null);
  RxList<Classroom> myClassrooms = <Classroom>[].obs;
  RxList<Classroom> myJoinedClassrooms = <Classroom>[].obs;
  ClassroomRepository classroomRepository = ClassroomRepository();

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
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin lớp học.', result.message),
    });
  }

  fetchMyJoinedClassrooms() async {
    isLoading.value = true;
    var result = await classroomRepository.getMyJoinedClassrooms();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          myJoinedClassrooms.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin lớp học.', result.message),
    });
  }
}
