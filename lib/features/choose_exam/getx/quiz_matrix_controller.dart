import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_repository.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';

import '../../../result_type.dart';

class QuizMatrixController extends GetxController {
  var isLoading = false.obs;
  RxList<QuizMatrix> quizMatrixList = <QuizMatrix>[].obs;
  Rx<QuizMatrix?> chosenQuizMatrix = Rx<QuizMatrix?>(null);
  ChooseExamRepository chooseExamRepository = ChooseExamRepository();

  @override
  onInit() async {
    await fetchQuizMatrices();
    super.onInit();
  }

  fetchQuizMatrices() async {
    isLoading.value = true;
    var result = await chooseExamRepository.getQuizMatrices();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          quizMatrixList.value = result.data!,
        },
      Failure() =>
        Get.snackbar('Lỗi lấy thông tin ma trận đề thi.', result.message),
    });
  }

  fetchQuizMatricesByChapterId(int chapterId) {
    isLoading.value = true;

    chosenQuizMatrix.value = quizMatrixList
        .firstWhereOrNull((element) => element.chapterId == chapterId);
    isLoading.value = false;
  }
}
