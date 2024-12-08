import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/result_controller.dart';

import 'package:mathquiz_mobile/models/quiz_matrix.dart';
import 'package:mathquiz_mobile/models/result.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  RxList<Result> recentResults = <Result>[].obs;
  var newExams = <QuizMatrix>[].obs;

  final resultController = Get.put(ResultController());
  final localDataControler = Get.put(LocalDataController());
  final quizMatrixController = Get.find<QuizMatrixController>();

  @override
  onInit() async {
    isLoading.value = true;
    await resultController.fetchResults();
    if (!resultController.isLoading.value) {
      await fetchRecentExam();
    }
    isLoading.value = false;
    super.onInit();
  }

  fetchRecentExam() async {
    isLoading.value = true;
    var clientId = await localDataControler.getClientId();
    recentResults = await resultController.fetchResultsByClientId(clientId!);
    recentResults.sort((a, b) => b.endTime!.compareTo(a.endTime!));
    isLoading.value = false;
  }
}
