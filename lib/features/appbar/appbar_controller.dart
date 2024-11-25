import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';

class AppBarController extends GetxController {
  var isLoading = false.obs;
  var clientName = ''.obs;
  final localDataController = Get.find<LocalDataController>();

  @override
  void onClose() {
    clientName = ''.obs;
    super.onClose();
  }
}
