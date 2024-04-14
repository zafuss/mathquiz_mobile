import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';

class AppBarController extends GetxController {
  var isLoading = false.obs;
  var clientName = ''.obs;
  final localDataController = LocalDataController();
  @override
  void onInit() async {
    // TODO: implement onInit
    await getClientName();
    super.onInit();
  }

  Future<void> getClientName() async {
    isLoading.value = true;
    clientName.value =
        await localDataController.getUID(LocalDataController.NAME_KEY) ??
            'null';
    isLoading.value = false;
  }
}
