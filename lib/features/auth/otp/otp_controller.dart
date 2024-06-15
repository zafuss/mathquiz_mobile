import 'dart:async';

import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';

class OtpController extends GetxController {
  var countdown = 120.obs;
  var isSuccess = false.obs;

  Timer? timer;

  @override
  void onInit() {
    // TODO: implement onInit
    startCountdown();
    super.onInit();
  }

  void startCountdown() {
    countdown.value = 30;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        stopCountdown();
      }
    });
  }

  void stopCountdown() {
    timer?.cancel();
  }

  void toLogin() {
    isSuccess = false.obs;
    Get.offAndToNamed(Routes.loginScreen);
  }

  @override
  void onClose() {
    super.onClose();
    stopCountdown();
    countdown.value = 30;
  }
}
