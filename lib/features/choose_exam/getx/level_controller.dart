import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_repository.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/grade_controller.dart';
import 'package:mathquiz_mobile/models/level.dart';

import '../../../result_type.dart';

class LevelController extends GetxController {
  var isLoading = false.obs;
  RxList<Level> levelList = <Level>[].obs;
  Rx<Level?> chosenLevel = Rx<Level?>(null);
  ChooseExamRepository chooseExamRepository = ChooseExamRepository();

  @override
  onInit() async {
    await fetchLevels();

    chosenLevel.value = levelList[0];
    super.onInit();
  }

  fetchLevels() async {
    isLoading.value = true;
    var result = await chooseExamRepository.getLevels();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          levelList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin cấp học.', result.message),
    });
  }

  handleOnChangedLevel(Level? newLevel, GradeController gradeController,
      ChapterController chapterController) {
    chosenLevel.value = newLevel;
    gradeController.fetchGradesByLevelId(newLevel!.id);
    chapterController
        .fetchChaptersByGradeId(gradeController.searchedGradeList[0].id);
  }
}
