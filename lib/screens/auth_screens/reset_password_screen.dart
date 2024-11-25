import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/helpers/input_validators.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localDataController = Get.put(LocalDataController());
    final authController = Get.put(AuthController());
    final otpInputController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmNewPasswordController = TextEditingController();

    // Khai báo GlobalKey<FormState>
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: authController.isRegisterSuccess.value
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    )
                  : Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Form(
                        // Sử dụng Form và đặt key là _formKey
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: kDefaultPadding * 2,
                            ),
                            const Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: "Đổi ",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: "mật khẩu",
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
                            TextFormField(
                              controller: otpInputController,
                              validator: (value) =>
                                  InputValidator.validateOTP(value),
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            const Text(
                              'Mật khẩu mới',
                            ),
                            TextFormField(
                              controller: newPasswordController,
                              obscureText: true,
                              validator: (value) =>
                                  InputValidator.validatePassword(value),
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            const Text(
                              'Xác nhận mật khẩu mới',
                            ),
                            TextFormField(
                              controller: confirmNewPasswordController,
                              obscureText: true,
                              validator: (value) {
                                if (value != newPasswordController.text) {
                                  return 'Mật khẩu không khớp';
                                }
                                return InputValidator.validatePassword(value);
                              },
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            // Obx(
                            //   () => Text(
                            //     'Bạn chưa nhận được mã? Nhận mã mới trong ${otpController.countdown} giây.',
                            //   ),
                            // ),
                            // const SizedBox(height: kDefaultPadding),
                            Obx(
                              () => ElevatedButton(
                                onPressed: () async {
                                  // Kiểm tra tính hợp lệ của form trước khi tiếp tục
                                  if (formKey.currentState!.validate()) {
                                    await authController.resetPasswordWithOtp(
                                        otpInputController.text,
                                        newPasswordController.text);
                                  }
                                },
                                child: authController.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Đổi mật khẩu'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
