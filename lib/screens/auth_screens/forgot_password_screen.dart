import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/helpers/input_validators.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final localDataController = Get.put(LocalDataController());
    final authController = Get.put(AuthController());
    return Scaffold(
      body: Stack(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Khôi phục',
                    style: TextStyle(
                        height: 1,
                        fontSize: 40,
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'mật khẩu',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  const Text(
                    'Nhập Email của bạn bên dưới và chúng tôi sẽ gửi cho bạn một thư kèm theo hướng dẫn về cách thay đổi mật khẩu của bạn.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextFormField(
                    validator: (value) => InputValidator.validateEmail(value),
                    controller: emailController,
                    decoration:
                        const InputDecoration(hintText: 'Email của bạn'),
                  ),
                  const SizedBox(
                    height: kMinPadding,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await localDataController
                              .saveClientEmail(emailController.text);
                          await authController
                              .sendForgotPasswordEmail(emailController.text);
                        }
                      },
                      child: Obx(() => authController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Tiếp tục')))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
