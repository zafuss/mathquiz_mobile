import 'dart:async';

import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/result_controller.dart';
import 'package:mathquiz_mobile/models/exam_detail.dart';
import 'package:mathquiz_mobile/models/quiz.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';

import '../../../models/result.dart';
import '../../choose_exam/getx/exam_controller.dart';
import 'exam_detail_controller.dart';
import 'quiz_controller.dart';
import 'quiz_option_controller.dart';

class DoExamController extends GetxController {
  var isLoading = false.obs;
  var isGettingResult = false.obs;
  var isLastQuiz = false.obs;
  var currentQuizIndex = 0.obs;
  var examDetailList = <ExamDetail>[].obs;
  var quizOptionList = <QuizOption>[].obs;
  var remainingTime = const Duration().obs;

  late Timer _timer;
  late Rxn<Quiz> currentQuiz = Rxn<Quiz>();
  late Rxn<Result> result = Rxn<Result>();
  late Rxn<ExamDetail> currentExamDetail = Rxn<ExamDetail>();
  late RxList<QuizOption> currentQuizOptions = <QuizOption>[].obs;
  late Rxn<int> totalQuiz = Rxn<int>();

  final quizController = Get.find<QuizController>();
  final examController = Get.find<ExamController>();
  final examDetailController = Get.find<ExamDetailController>();
  final quizOptionController = Get.put(QuizOptionController());
  final resultController = Get.put(ResultController());

  @override
  void onInit() async {
    super.onInit();
    if (quizController.isLoading.value ||
        examController.isLoading.value ||
        examDetailController.isLoading.value ||
        quizController.isLoading.value ||
        quizOptionController.isLoading.value ||
        resultController.isLoading.value) {
      isLoading.value = true;
    }
    // Populate examDetailList if necessary
    examDetailList.value = examDetailController.searchedExamDetailList;
    totalQuiz.value = examController.chosenExam.value!.numberOfQuiz!;
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

  startTimer() async {
    var id =
        'result${examController.chosenExam.value!.clientId!}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().microsecond.toString().substring(0, 2)}';
    result.value = Result(
        id: id,
        score: 0,
        startTime: DateTime.now(),
        totalQuiz: totalQuiz.value!,
        clientId: examController.chosenExam.value!.clientId!,
        examId: currentExamDetail.value!.examId);
    await resultController.addResults(result.value!);
    int totalSeconds =
        examController.chosenExam.value!.duration! * 60; // Tổng số giây
    remainingTime.value = Duration(seconds: totalSeconds);
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      if (totalSeconds > 0) {
        totalSeconds--;
        remainingTime.value = Duration(seconds: totalSeconds);
        print(remainingTime.toString());
      } else {
        timer.cancel();
        await calculateScore();
        Get.offNamed(Routes.resultScreen);
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

  saveNewExamDetailList() async {
    isGettingResult.value = true;
    await examDetailController.updateExamDetails(examDetailList);
    await calculateScore();
    isGettingResult.value = false;
  }

  calculateScore() async {
    int correctAnswers = 0;
    for (var examDetail in examDetailList) {
      var quizOption = quizOptionList.firstWhereOrNull(
          (element) => element.id == examDetail.selectedOption);

      if (quizOption != null && quizOption.isCorrect) {
        correctAnswers++;
      }
    }
    double score = correctAnswers / totalQuiz.value! * 10;
    result.value!.endTime = DateTime.now();
    result.value!.score = score;
    result.value!.correctAnswers = correctAnswers;
    await resultController.updateResult(result.value!);
  }
}
