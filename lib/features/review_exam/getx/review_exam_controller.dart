import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/exam_detail_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/quiz_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/quiz_option_controller.dart';
import 'package:mathquiz_mobile/models/quiz_option.dart';

import '../../../models/exam_detail.dart';
import '../../../models/quiz.dart';

class ReviewExamController extends GetxController {
  var isLoading = false.obs;

  RxList<ExamDetail> examDetailList = <ExamDetail>[].obs;
  RxList<ExamDetail> chosenExamDetail = <ExamDetail>[].obs;
  late Rxn<Quiz> currentQuiz = Rxn<Quiz>();
  late Rxn<ExamDetail> currentExamDetail = Rxn<ExamDetail>();
  late Rxn<QuizOption> currentCorrectOption = Rxn<QuizOption>();
  late Rxn<QuizOption> chosenOption = Rxn<QuizOption>();
  var currentIndex = 0.obs;
  var isLastQuiz = false.obs;
  var currentExamId = ''.obs;
  final examController = Get.find<ExamController>();
  final quizOptionController = Get.put(QuizOptionController());
  final examDetailController = Get.put(ExamDetailController());
  final quizController = Get.put(QuizController());
  @override
  void onInit() async {
    // var currentExamId = 'exam231352024221493';
    currentExamId.value = examController.chosenExam.value!.id;
    await fetchExamDetailList();

    super.onInit();
  }

  fetchExamDetailList() async {
    isLoading.value = true;
    await examDetailController.fetchExamDetails();
    await quizOptionController.fetchQuizOptions();
    examDetailList.value = examDetailController.examDetailList
        .where((p0) => p0.examId == currentExamId.value)
        .toList();
    super.onInit();
    isLoading.value = false;
  }

  fetchCurrentQuiz() async {
    currentExamDetail.value = chosenExamDetail[currentIndex.value];
    currentQuiz.value = quizController.quizList
        .firstWhere((element) => element.id == currentExamDetail.value!.quizId);
    await fetchCurrentQuizOption();
    isLastQuiz.value = _checkIsLastQuiz();
  }

  fetchCurrentQuizOption() {
    isLoading.value = true;
    int currentSelectedOption = currentExamDetail.value!.selectedOption;
    currentCorrectOption.value = quizOptionController.quizOptionList
        .firstWhereOrNull((element) =>
            element.quizId == currentQuiz.value!.id && element.isCorrect);
    if (currentSelectedOption == -1) {
      chosenOption.value = null;
    } else {
      chosenOption.value = quizOptionController.quizOptionList
          .firstWhere((element) => element.id == currentSelectedOption);
    }
    isLoading.value = false;
  }

  handleNextQuiz() async {
    isLoading.value = true;
    currentIndex.value++;
    await fetchCurrentQuiz();
    isLoading.value = false;
  }

  handlePreviousQuiz() async {
    isLoading.value = true;
    currentIndex.value--;
    await fetchCurrentQuiz();
    isLoading.value = false;
  }

  _checkIsLastQuiz() {
    if (currentIndex.value + 1 == chosenExamDetail.length) {
      return true;
    }
    return false;
  }
}
