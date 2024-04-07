import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_repository.dart';

import '../../../models/chapter.dart';
import '../../../result_type.dart';

class ChapterController extends GetxController {
  var isLoading = false.obs;
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
    chosenChapter.value = searchedChapterList[0];
  }
}
