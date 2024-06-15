import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_repository.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';

import '../../../models/grade.dart';
import '../../../result_type.dart';

class GradeController extends GetxController {
  var isLoading = false.obs;
  RxList<Grade> gradeList = <Grade>[].obs;
  RxList<Grade> searchedGradeList = <Grade>[].obs;
  Rx<Grade?> chosenGrade = Rx<Grade?>(null);
  ChooseExamRepository chooseExamRepository = ChooseExamRepository();

  @override
  onInit() async {
    await fetchGrades();
    // await fetchInitGradesByLevelId();
    await fetchInitGrade();
    super.onInit();
  }

  fetchGrades() async {
    isLoading.value = true;
    var result = await chooseExamRepository.getGrades();

    isLoading.value = false;
    return (switch (result) {
      Success() => {
          gradeList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin lớp học.', result.message),
    });
  }

  fetchInitGrade() async {
    isLoading.value = true;
    var id = await chooseExamRepository.fetchClientGradeId();
    chosenGrade.value =
        gradeList.firstWhereOrNull((element) => element.id == id);
    isLoading.value = false;
  }

  fetchGradesByLevelId(int levelId) {
    searchedGradeList.value =
        gradeList.where((element) => element.levelId == levelId).toList();
    chosenGrade.value = searchedGradeList[0];
  }

  fetchInitGradesByLevelId() async {
    isLoading.value = true;
    var levelId = await chooseExamRepository.fetchClientLevelId();
    searchedGradeList.value =
        gradeList.where((element) => element.levelId == levelId).toList();
    chosenGrade.value = searchedGradeList[0];
    isLoading.value = false;
  }

  handleOnChangedGrade(Grade? newGrade, ChapterController chapterController) {
    chosenGrade.value = newGrade;
    chapterController.fetchChaptersByGradeId(newGrade!.id);
  }
}
