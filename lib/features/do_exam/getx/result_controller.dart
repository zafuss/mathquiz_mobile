import 'package:get/get.dart';
import 'package:mathquiz_mobile/models/result.dart';

import '../../../result_type.dart';
import '../data/do_exam_repository.dart';

class ResultController extends GetxController {
  var isLoading = false.obs;
  final DoExamRepository doExamRepository = DoExamRepository();

  @override
  onInit() async {
    await fetchResults();
    super.onInit();
  }

  RxList<Result> resultList = <Result>[].obs;
  RxList<Result> listByExam = <Result>[].obs;
  RxList<Result> listByClient = <Result>[].obs;
  Rx<Result?> chosenResult = Rx<Result?>(null);

  fetchResults() async {
    isLoading.value = true;
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

    listByClient.value = resultList
        .where((p0) => p0.clientId == clientId && p0.endTime != null)
        .toList();
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
}
