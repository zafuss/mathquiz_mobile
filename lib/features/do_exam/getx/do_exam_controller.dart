import 'dart:async';

import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
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
  var isFirstQuiz = false.obs;
  var currentQuizIndex = 0.obs;
  var examDetailList = <ExamDetail>[].obs;
  var quizOptionList = <QuizOption>[].obs;
  var markedQuiz = <int>[].obs;
  var markedQuizIndex = 0.obs;
  var isInMarkedQuiz = false.obs;
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
  final localDataController = Get.put(LocalDataController());

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
    stopTimer();
    super.onClose();
  }

  startTimer() async {
    var clientId = await localDataController.getClientId();
    var id =
        'result${examController.currentExamId}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().microsecond.toString().substring(0, 2)}';
    result.value = Result(
        id: id,
        score: 0,
        startTime: DateTime.now(),
        totalQuiz: totalQuiz.value!,
        clientId: clientId!,
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
    isFirstQuiz.value = _checkIsFirstQuiz();
    await fetchQuizOptions();
  }

  _checkIsLastQuiz() {
    if (currentQuizIndex.value + 1 ==
            (examDetailList.length + markedQuiz.length) ||
        (markedQuizIndex.value == markedQuiz.length &&
            markedQuizIndex.value != 0)) {
      if (markedQuizIndex.value != 0) {
        markedQuizIndex.value--;
      }
      // isInMarkedQuiz.value = false;
      return true;
    }
    return false;
  }

  _checkIsFirstQuiz() {
    if (currentQuizIndex.value > 0 ||
        currentQuizIndex.value == 0 && isInMarkedQuiz.value) {
      return true;
    }
    return false;
  }

  handleNextQuiz() async {
    isLoading.value = true;
    if (currentQuizIndex.value + 1 == examDetailList.length) {
      currentQuizIndex.value = markedQuiz.first;
      markedQuizIndex.value++;
      isInMarkedQuiz.value = true;
    } else if (markedQuizIndex.value != 0 ||
        (markedQuizIndex.value == 0 && isInMarkedQuiz.value)) {
      currentQuizIndex.value = markedQuiz[markedQuizIndex.value];
      markedQuizIndex.value++;
    } else {
      currentQuizIndex.value++;
    }
    await fetchCurrentQuiz();
    print(markedQuizIndex.value);
    isLoading.value = false;
  }

  handlePreviousQuiz() async {
    isLoading.value = true;
    print(markedQuizIndex.value);
    if (markedQuizIndex.value != 0) {
      currentQuizIndex.value = markedQuiz[--markedQuizIndex.value];
    } else if (markedQuizIndex.value == 0 && isInMarkedQuiz.value) {
      currentQuizIndex.value = examDetailList.length - 1;
      isInMarkedQuiz.value = false;
    } else {
      currentQuizIndex.value--;
      isInMarkedQuiz.value = false;
    }
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

  handleMarkedQuiz() {
    if (markedQuiz.contains(currentQuizIndex.value)) {
      markedQuiz.removeWhere((element) => element == currentQuizIndex.value);
    } else {
      markedQuiz.add(currentQuizIndex.value);
    }
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
