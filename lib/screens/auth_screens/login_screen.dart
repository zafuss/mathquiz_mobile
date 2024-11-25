import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/helpers/input_validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: "Math",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: ColorPalette.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "Quiz",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: ",",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: ColorPalette.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                          ),
                          const Text(
                            'Xin chào!',
                            style: TextStyle(
                                height: 1,
                                fontSize: 35,
                                color: ColorPalette.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          const Text(
                            'Đăng nhập để tiếp tục',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Semantics(
                                  label: 'Email Input Field',
                                  child: TextFormField(
                                    controller: emailController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0),
                                      prefixIcon: Icon(
                                        Icons.person_2_outlined,
                                      ),
                                      hintText: "Email",
                                    ),
                                    validator: (value) =>
                                        InputValidator.validateEmail(value),
                                  ),
                                ),
                                const SizedBox(
                                  height: kMinPadding / 2,
                                ),
                                Semantics(
                                  label: 'Password Input Field',
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0),
                                      prefixIcon: Icon(
                                        Icons.key_outlined,
                                      ),
                                      hintText: "Mật khẩu",
                                    ),
                                    validator: (value) =>
                                        InputValidator.validatePassword(value),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: kMinPadding / 2,
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // GestureDetector(
                                //   onTap: () =>
                                //       authController.isRememberMe.value =
                                //           !authController.isRememberMe.value,
                                //   child: Row(
                                //     children: [
                                //       Semantics(
                                //         label: authController.isRememberMe.value
                                //             ? 'Remember Me selected'
                                //             : 'Remember Me unselected',
                                //         child: authController.isRememberMe.value
                                //             ? const Icon(Icons
                                //                 .radio_button_checked_outlined)
                                //             : const Icon(Icons
                                //                 .radio_button_unchecked_outlined),
                                //       ),
                                //       const SizedBox(
                                //         width: 5,
                                //       ),
                                //       const Text('Lưu đăng nhập?'),
                                //     ],
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () =>
                                      Get.toNamed(Routes.forgotPasswordScreen),
                                  child: Semantics(
                                    label: 'Forgot Password Button',
                                    child: const Text('Quên mật khẩu?'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: kMinPadding / 2,
                          ),
                          Obx(
                            () => Semantics(
                              label: 'Login Button',
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await authController.login(
                                        emailController.text,
                                        passwordController.text);
                                  }
                                },
                                child: authController.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Đăng nhập'),
                              ),
                            ),
                          ),
                          Semantics(
                            label: 'Google Login Button',
                            child: TextButton(
                              onPressed: () async {
                                await authController.loginByGoogle();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Đăng nhập bằng Google',
                                    style: TextStyle(
                                        color: ColorPalette.primaryColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 25,
                                      child: Image.asset(
                                        'assets/images/google_logo.jpg',
                                        semanticLabel: 'Google Logo',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20), // Add some spacing here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: kMinPadding, left: kDefaultPadding, right: kDefaultPadding),
        child: Semantics(
          label: 'Register Button',
          child: TextButton(
            onPressed: () {
              authController.toRegister();
            },
            child: const Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: "Bạn chưa có tài khoản? ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: "Đăng ký",
                  style: TextStyle(
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
