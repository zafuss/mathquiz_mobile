import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/models/classroom_models/homework.dart';
import 'package:mathquiz_mobile/models/result.dart';

import '../../../result_type.dart';
import '../data/do_exam_repository.dart';

class ResultController extends GetxController {
  var isLoading = false.obs;
  var clientId = ''.obs;
  final DoExamRepository doExamRepository = DoExamRepository();
  final ExamController examController = Get.put(ExamController());
  final LocalDataController localDataController = LocalDataController();
  @override
  onInit() async {
    await fetchResults();
    clientId.value = await localDataController.getClientId() ?? "";
    super.onInit();
  }

  RxList<Result> resultList = <Result>[].obs;
  RxList<Result> listByExam = <Result>[].obs;
  RxList<Result> listByClient = <Result>[].obs;
  Rx<Result?> chosenResult = Rx<Result?>(null);

  fetchResults() async {
    isLoading.value = true;
    await examController.fetchExams();
    var result = await doExamRepository.getResults();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          resultList.value = result.data!,
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin kết quả.', result.message),
    });
  }

  fetchResultsByExamId(String examId) async {
    isLoading.value = true;

    listByExam.value = resultList.where((p0) => p0.examId == examId).toList();
    isLoading.value = false;
  }

  fetchResultsByClientId(String clientId) async {
    isLoading.value = true;

    List<Result> filteredList = [];
    for (var result in resultList) {
      if (result.clientId == clientId && result.endTime != null) {
        if (await examController.isExamExist(result.examId)) {
          filteredList.add(result);
        }
      }
    }

    listByClient.value = filteredList;
    isLoading.value = false;
    return listByClient;
  }

  addResults(Result result) async {
    isLoading.value = true;

    await doExamRepository.addResult(result);

    await fetchResults();

    isLoading.value = false;
  }

  updateResult(Result result) async {
    isLoading.value = true;

    await doExamRepository.updateResult(result);
    isLoading.value = false;
  }

  int homeworkRemainingAttempt(Homework homework) {
    int count = 0;
    for (var exam in examController.examList) {
      if (exam.homework != null &&
          exam.quizMatrixId == homework.quizMatrix.id &&
          exam.clientId! == clientId.value) {
        if (resultList.firstWhere((r) => r.examId == exam.id).endTime != null) {
          count++;
        }
      }
    }
    return homework.attempt - count;
  }
}
