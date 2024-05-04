import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/do_exam/data/do_exam_repository.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';

import '../../../result_type.dart';

class QuizOptionController extends GetxController {
  var isLoading = false.obs;
  RxList<QuizOption> quizOptionList = <QuizOption>[].obs;
  RxList<QuizOption> searchedQuizOptionList = <QuizOption>[].obs;

  Rx<QuizOption?> chosenQuizOption = Rx<QuizOption?>(null);
  DoExamRepository doExamRepository = DoExamRepository();

  @override
  onInit() async {
    await fetchQuizOptions();
    super.onInit();
  }

  fetchQuizOptions() async {
    isLoading.value = true;
    var result = await doExamRepository.getQuizOptions();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          quizOptionList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin câu hỏi.', result.message),
    });
  }

  fetchQuizOptionsByQuizId(int quizId) {
    isLoading.value = true;

    searchedQuizOptionList.value =
        quizOptionList.where((p0) => p0.quizId == quizId).toList();
    isLoading.value = false;
  }
}
