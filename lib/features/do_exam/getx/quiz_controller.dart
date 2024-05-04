import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/do_exam/data/do_exam_repository.dart';
import 'package:mathquiz_mobile/models/quiz.dart';

import '../../../result_type.dart';

class QuizController extends GetxController {
  var isLoading = false.obs;
  RxList<Quiz> quizList = <Quiz>[].obs;
  RxList<Quiz> searchedQuizList = <Quiz>[].obs;

  Rx<Quiz?> chosenQuiz = Rx<Quiz?>(null);
  DoExamRepository doExamRepository = DoExamRepository();

  @override
  onInit() async {
    await fetchQuizs();
    super.onInit();
  }

  fetchQuizs() async {
    isLoading.value = true;
    var result = await doExamRepository.getQuizs();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          quizList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin câu hỏi.', result.message),
    });
  }

  fetchQuizsByQuizMatrixId(int quizMatrixId) {
    isLoading.value = true;

    searchedQuizList.value =
        quizList.where((p0) => p0.quizMatrixId == quizMatrixId).toList();
    isLoading.value = false;
  }
}
