import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/data/choose_exam_repository.dart';
import 'package:mathquiz_mobile/features/choose_exam/dtos/ranking_dto.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/models/classroom_models/homework.dart';
import 'package:mathquiz_mobile/models/quiz_matrix.dart';
import 'package:mathquiz_mobile/result_type.dart';

import '../../../models/exam.dart';

class ExamController extends GetxController {
  var currentExamId = ''.obs;
  var isLoading = false.obs;
  var numOfUsed = 0.obs;
  RxInt tempDuration = 0.obs;
  RxInt tempNumOfQuiz = 0.obs;
  RxList<Exam> examList = <Exam>[].obs;
  Rx<Exam?> chosenExam = Rx<Exam?>(null);
  RxList<RankingDto?> ranking = <RankingDto>[].obs;
  final ChooseExamRepository chooseExamRepository = ChooseExamRepository();
  final LocalDataController localDataController = LocalDataController();
  final QuizMatrixController quizMatrixController =
      Get.put(QuizMatrixController());

  @override
  onInit() async {
    await fetchExams();
    super.onInit();
  }

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

  fetchRanking(int chapterId) async {
    isLoading.value = true;
    var result = await chooseExamRepository.getRanking(chapterId);
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          ranking.value = result.data!,
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
    numOfUsed.value = 0;
    for (var element in examList) {
      if (element.quizMatrixId == quizMatrixId) {
        numOfUsed++;
      }
    }
  }

  addExam(QuizMatrix currentQuizMatrix) async {
    isLoading.value = true;

    final clientId = await localDataController.getClientId();
    currentExamId.value =
        'exam${currentQuizMatrix.id}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().microsecond.toString().substring(0, 2)}';
    if (tempDuration.value != currentQuizMatrix.defaultDuration ||
        tempNumOfQuiz.value != currentQuizMatrix.numOfQuiz) {
      await chooseExamRepository.addCustomExam(currentQuizMatrix, clientId!,
          currentExamId.value, tempDuration.value, tempNumOfQuiz.value);
    } else {
      await chooseExamRepository.addNewDefaultExam(
          currentQuizMatrix, clientId!, currentExamId.value, null);
    }
    await fetchExams();
    chosenExam.value =
        examList.firstWhere((element) => element.id == currentExamId.value);
    isLoading.value = false;
  }

  addClassroomExam(Homework homework) async {
    isLoading.value = true;

    final clientId = await localDataController.getClientId();
    currentExamId.value =
        'exam${homework.quizMatrix!.id}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().microsecond.toString().substring(0, 2)}';
    if (tempDuration.value != homework.quizMatrix!.defaultDuration ||
        tempNumOfQuiz.value != homework.quizMatrix!.numOfQuiz) {
      await chooseExamRepository.addCustomExam(homework.quizMatrix!, clientId!,
          currentExamId.value, tempDuration.value, tempNumOfQuiz.value);
    } else {
      await chooseExamRepository.addNewDefaultExam(
          homework.quizMatrix!, clientId!, currentExamId.value, homework);
    }
    await fetchExams();
    chosenExam.value =
        examList.firstWhere((element) => element.id == currentExamId.value);
    isLoading.value = false;
  }

  Future<bool> isExamExist(String resultId) async {
    if (examList.isEmpty) {
      await fetchExams();
    }
    var exam = examList.firstWhereOrNull((exam) => exam.id == resultId);
    if (exam != null) {
      return true;
    }
    return false;
  }
}
