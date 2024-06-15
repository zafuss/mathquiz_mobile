import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/features/auth/otp/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    final localDataController = Get.put(LocalDataController());
    final authController = Get.put(AuthController());
    final otpInputController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/bg_auth.png'),
            SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Obx(
              () => authController.isRegisterSuccess.value
                  ? SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 200,
                            ),
                            const Text(
                              'Đăng ký tài khoản thành công',
                              style: TextStyle(
                                color: ColorPalette.primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Image.asset(
                              'assets/images/checked.gif',
                              width: 115,
                            ),
                            const Text(
                                'Tự động chuyển về trang đăng nhập sau 3 giây'),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: kDefaultPadding * 2,
                          ),
                          const Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: "Xác minh ",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "OTP",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: ColorPalette.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: kMinPadding,
                          ),
                          Text(
                            'Nhập mã gồm 6 chữ số đã được gửi đến ${localDataController.clientEmail.value}',
                          ),
                          const SizedBox(height: kDefaultPadding / 2),
                          TextField(
                            controller: otpInputController,
                          ),
                          const SizedBox(height: kDefaultPadding / 2),
                          Obx(
                            () => Text(
                              'Bạn chưa nhận được mã? Nhận mã mới trong ${otpController.countdown} giây.',
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Obx(
                            () => ElevatedButton(
                              onPressed: () async {
                                var id = await localDataController
                                    .getRegisterClientId();
                                await authController.verifyOtp(
                                  id!,
                                  otpInputController.text,
                                );
                              },
                              child: authController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Tiếp tục'),
                            ),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
