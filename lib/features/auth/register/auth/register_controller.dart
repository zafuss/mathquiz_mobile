import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';

class RegisterController extends GetxController {
  var isRegistering = false.obs;
  var isRegisterSuccess = false.obs;
  Future<void> register() async {
    try {} catch (e) {
      Get.snackbar('Đăng ký thất bại', e.toString());
    }
  }

  void toLogin() {
    isRegisterSuccess = false.obs;
    Get.offAndToNamed(Routes.loginScreen);
  }

  Future<void> processRegisterSuccess() async {}
}
