import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/helpers/input_validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
        body: Stack(children: [
      Image.asset('assets/images/bg_auth.png'),
      SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => Column(
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
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
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
                                const SizedBox(
                                  height: kMinPadding / 2,
                                ),
                                TextFormField(
                                  controller: _passwordController,
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: kMinPadding / 2,
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      authController.isRememberMe.value =
                                          !authController.isRememberMe.value,
                                  child: Row(
                                    children: [
                                      authController.isRememberMe.value
                                          ? const Icon(Icons
                                              .radio_button_checked_outlined)
                                          : const Icon(Icons
                                              .radio_button_unchecked_outlined),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text('Lưu đăng nhập?'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Get.toNamed(Routes.forgotPasswordScreen),
                                  child: const Text('Quên mật khẩu?'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: kMinPadding / 2,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await authController.login(
                                    _emailController.text,
                                    _passwordController.text);
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
                          TextButton(
                            onPressed: () {},
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
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
                  )
                ],
              )))
    ]));
  }
}
