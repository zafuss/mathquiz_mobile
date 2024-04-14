import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_repository.dart';

import '../../../models/chapter.dart';
import '../../../result_type.dart';

class ChapterController extends GetxController {
  var isLoading = false.obs;
  var isHasMultiMathType = false.obs;
  var chosenMathType = 1.obs;
  RxList<Chapter> chapterList = <Chapter>[].obs;
  RxList<Chapter> searchedChapterList = <Chapter>[].obs;
  Rx<Chapter?> chosenChapter = Rx<Chapter?>(null);
  ChooseExamRepository chooseExamRepository = ChooseExamRepository();

  @override
  onInit() async {
    await fetchChapters();
    fetchChaptersByGradeId(1);
    chosenChapter.value = chapterList[0];
    super.onInit();
  }

  fetchChapters() async {
    isLoading.value = true;
    var result = await chooseExamRepository.getChapters();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          chapterList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin chương.', result.message),
    });
  }

  fetchChaptersByGradeId(int gradeId) {
    searchedChapterList.value =
        chapterList.where((element) => element.gradeId == gradeId).toList();
    if (searchedChapterList.isNotEmpty) {
      chosenChapter.value = searchedChapterList[0];
    } else {
      chosenChapter.value = null;
    }
    for (var element in searchedChapterList) {
      if (element.mathTypeId != null) {
        isHasMultiMathType.value = true;
        chosenMathType.value = 1;
        fetchChapterByMathType(null, gradeId);
        break;
      }
      isHasMultiMathType.value = false;
    }
  }

  fetchChapterByMathType(int? mathTypeId, int gradeId) {
    if (mathTypeId != null) {
      chosenMathType.value = mathTypeId;
    }
    searchedChapterList.value = chapterList
        .where((element) =>
            element.mathTypeId == chosenMathType.value &&
            element.gradeId == gradeId)
        .toList();
    if (searchedChapterList.isNotEmpty) {
      chosenChapter.value = searchedChapterList[0];
    } else {
      chosenChapter.value = null;
    }
  }
}
