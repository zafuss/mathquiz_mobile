import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/data/do_exam_repository.dart';
import 'package:mathquiz_mobile/models/exam_detail.dart';
import 'package:mathquiz_mobile/models/quiz.dart';

import '../../../helpers/list_shuffle.dart';
import '../../../result_type.dart';

class ExamDetailController extends GetxController {
  var isLoading = false.obs;
  final DoExamRepository doExamRepository = DoExamRepository();
  final ExamController examController = Get.put(ExamController());
  RxList<ExamDetail> examDetailList = <ExamDetail>[].obs;
  RxList<ExamDetail> searchedExamDetailList = <ExamDetail>[].obs;
  Rx<ExamDetail?> chosenExamDetail = Rx<ExamDetail?>(null);

  fetchExamDetails() async {
    isLoading.value = true;
    var result = await doExamRepository.getExamDetails();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          examDetailList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin đề thi.', result.message),
    });
  }

  fetchExamDetailsByExamId(String examId) async {
    isLoading.value = true;

    searchedExamDetailList.value =
        examDetailList.where((p0) => p0.examId == examId).toList();
    isLoading.value = false;
  }

  addExamDetails(String examId, List<Quiz> quizList) async {
    isLoading.value = true;
    await examController.fetchExams();
    shuffle(quizList);
    for (int i = 0; i < examController.tempNumOfQuiz.value; i++) {
      await doExamRepository.addExamDetail(examId, quizList[i].id);
    }
    await fetchExamDetails();
    await fetchExamDetailsByExamId(examId);
    isLoading.value = false;
  }

  updateExamDetails(List<ExamDetail> examDetailList) async {
    isLoading.value = true;
    for (var examDetail in examDetailList) {
      await doExamRepository.updateExamDetail(examDetail);
    }

    isLoading.value = false;
  }
}
