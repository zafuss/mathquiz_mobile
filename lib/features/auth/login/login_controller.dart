import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/auth_repository.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';

import '../../../result_type.dart';

class LoginController extends GetxController {
  var isLogging = false.obs;
  var isRememberMe = false.obs;
  final localDataController = LocalDataController();
  final authRepository = AuthRepository();
  // Future<void> login() async {
  //   try {
  //     localDataController.saveUID("Phú");

  //     Get.toNamed(Routes.homeScreen);
  //   } catch (e) {
  //     Get.snackbar('Đăng nhập thất bại', e.toString());
  //   }
  // }

  Future<void> login(String email, String password) async {
    isLogging.value = true;
    final result = await authRepository.login(email: email, password: password);
    isLogging.value = false;
    switch (result) {
      case Success():
        Get.offAndToNamed(Routes.homeScreen);
        break;
      case Failure():
        Get.snackbar('Đăng nhập thất bại', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  void toRegister() {
    Get.toNamed(Routes.registerScreen);
  }

  void toForgotPassword() {}

  void loginByGoogle() {}
}
