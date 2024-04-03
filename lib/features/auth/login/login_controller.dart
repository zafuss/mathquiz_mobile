import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';

class LoginController extends GetxController {
  var isLogging = false.obs;
  var isRememberMe = false.obs;

  Future<void> login() async {
    try {} catch (e) {
      Get.snackbar('Đăng nhập thất bại', e.toString());
    }
  }

  void toRegister() {
    Get.toNamed(Routes.registerScreen);
  }

  void toForgotPassword() {}

  void loginByGoogle() {}
}
