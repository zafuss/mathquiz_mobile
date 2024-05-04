import 'dart:async';

import 'package:get/get.dart';
import 'package:mathquiz_mobile/models/exam_detail.dart';
import 'package:mathquiz_mobile/models/quiz.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';

import '../../choose_exam/getx/exam_controller.dart';
import 'exam_detail_controller.dart';
import 'quiz_controller.dart';
import 'quiz_option_controller.dart';

class DoExamController extends GetxController {
  var isLoading = false.obs;
  var isLastQuiz = false.obs;
  var currentQuizIndex = 0.obs;
  var examDetailList = <ExamDetail>[].obs;
  var quizOptionList = <QuizOption>[].obs;
  var remainingTime = const Duration().obs;

  late Timer _timer;
  late Rxn<Quiz> currentQuiz = Rxn<Quiz>();
  late Rxn<ExamDetail> currentExamDetail = Rxn<ExamDetail>();
  late RxList<QuizOption> currentQuizOptions = <QuizOption>[].obs;

  final quizController = Get.find<QuizController>();
  final examController = Get.find<ExamController>();
  final examDetailController = Get.find<ExamDetailController>();
  final quizOptionController = Get.put(QuizOptionController());

  @override
  void onInit() async {
    super.onInit();
    if (quizController.isLoading.value ||
        examController.isLoading.value ||
        examDetailController.isLoading.value ||
        quizController.isLoading.value ||
        quizOptionController.isLoading.value) {
      isLoading.value = true;
    }
    // Populate examDetailList if necessary
    examDetailList.value = examDetailController.searchedExamDetailList;
    await fetchCurrentQuiz();
    startTimer();
    isLoading.value = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    stopTimer();
    super.onClose();
  }

  void startTimer() {
    int totalSeconds =
        examController.chosenExam.value!.duration! * 60; // Tổng số giây
    remainingTime.value = Duration(seconds: totalSeconds);
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (totalSeconds > 0) {
        totalSeconds--;
        remainingTime.value = Duration(seconds: totalSeconds);
        print(remainingTime.toString());
      } else {
        timer.cancel();
        Get.offNamed('/time_up');
      }
    });
  }

  void stopTimer() {
    _timer.cancel(); // Hủy bỏ timer
  }

  fetchCurrentQuiz() async {
    currentExamDetail.value = examDetailList[currentQuizIndex.value];

    currentQuiz.value = quizController.quizList
        .firstWhere((element) => element.id == currentExamDetail.value!.quizId);
    isLastQuiz.value = _checkIsLastQuiz();
    await fetchQuizOptions();
  }

  _checkIsLastQuiz() {
    if (currentQuizIndex.value + 1 == examDetailList.length) {
      return true;
    }
    return false;
  }

  handleNextQuiz() async {
    isLoading.value = true;
    currentQuizIndex.value++;
    await fetchCurrentQuiz();
    isLoading.value = false;
  }

  handlePreviousQuiz() async {
    isLoading.value = true;
    currentQuizIndex.value--;
    await fetchCurrentQuiz();
    isLoading.value = false;
  }

  fetchQuizOptions() async {
    if (quizOptionList.isEmpty) {
      await quizOptionController.fetchQuizOptions();
      quizOptionList.value = quizOptionController.quizOptionList;
    }
    currentQuizOptions.value = quizOptionList
        .where((p0) => p0.quizId == currentQuiz.value!.id)
        .toList();
  }

  handleChooseAnOption(int quizOptionId) {
    var newExamDetail = ExamDetail(
        id: currentExamDetail.value!.id,
        quizId: currentExamDetail.value!.quizId,
        examId: currentExamDetail.value!.examId,
        selectedOption: quizOptionId);
    examDetailList[currentQuizIndex.value] = newExamDetail;
    currentExamDetail.value = examDetailList[currentQuizIndex.value];
  }
}
