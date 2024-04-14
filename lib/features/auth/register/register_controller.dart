import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/auth_repository.dart';

import '../../../result_type.dart';

class RegisterController extends GetxController {
  var isRegistering = false.obs;
  var isRegisterSuccess = false.obs;
  final authRepository = AuthRepository();
  Future<void> register(String email, String password) async {
    isRegistering.value = true;
    final result =
        await authRepository.register(email: email, password: password);
    switch (result) {
      case Success():
        isRegistering.value = false;
        isRegisterSuccess.value = true;
        Get.snackbar('Đăng ký thành công!', 'Chào mừng bạn đến với MathQuiz');

        break;
      case Failure():
        isRegistering.value = false;
        isRegisterSuccess.value = false;
        Get.snackbar('Đăng ký thất bại', result.message);
        break;
      default:
        // Xử lý trường hợp khác nếu cần
        break;
    }
  }

  void toLogin() {
    isRegisterSuccess = false.obs;
    Get.offAndToNamed(Routes.loginScreen);
  }

  Future<void> processRegisterSuccess() async {}
}
