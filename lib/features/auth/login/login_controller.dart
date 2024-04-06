import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/sf/sf_controller.dart';

class LoginController extends GetxController {
  var isLogging = false.obs;
  var isRememberMe = false.obs;
  final localDataController = LocalDataController();
  Future<void> login() async {
    try {
      localDataController.saveUID("Phú");
      Get.toNamed(Routes.homeScreen);
    } catch (e) {
      Get.snackbar('Đăng nhập thất bại', e.toString());
    }
  }

  void toRegister() {
    Get.toNamed(Routes.registerScreen);
  }

  void toForgotPassword() {}

  void loginByGoogle() {}
}
