import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_repository.dart';
import 'package:mathquiz_mobile/result_type.dart';

import '../../../models/exam.dart';

class ExamController extends GetxController {
  var isLoading = false.obs;
  var numOfUsed = 0.obs;
  RxList<Exam> examList = <Exam>[].obs;
  Rx<Exam?> chosenExam = Rx<Exam?>(null);
  ChooseExamRepository chooseExamRepository = ChooseExamRepository();

  fetchExams() async {
    isLoading.value = true;
    var result = await chooseExamRepository.getExams();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          examList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin đề thi.', result.message),
    });
  }

  fetchExamByQuizMatrixId(int quizMatrixId) {
    isLoading.value = true;
    numOfUsed.value = 0;
    chosenExam.value = examList.firstWhereOrNull((element) =>
        element.isCustomExam == false && element.quizMatrixId == quizMatrixId);
    fetchNumOfUsed(quizMatrixId);
    isLoading.value = false;
  }

  fetchNumOfUsed(int quizMatrixId) {
    for (var element in examList) {
      if (element.quizMatrixId == quizMatrixId) {
        numOfUsed++;
      }
    }
  }
}
