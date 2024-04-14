import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/register/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    // final _fullNameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: Obx(
              () => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: registerController.isRegisterSuccess.value
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Đăng ký tài khoản thành công',
                              style: TextStyle(
                                  color: ColorPalette.primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            // Icon(
                            //   Icons.check_circle_outline_outlined,
                            //   color: ColorPalette.primaryColor,
                            //   size: 56,
                            // ),
                            Image.asset(
                              'assets/images/checked.gif',
                              width: 115,
                            ),
                            const Text(
                                'Tự động chuyển về trang đăng nhập sau 3 giây')
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                              child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 40,
                                      color: ColorPalette.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'tài khoản',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
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
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(top: 0),
                                                prefixIcon: Icon(
                                                  Icons.email_outlined,
                                                ),
                                                hintText: "Email")),
                                        const SizedBox(
                                          height: kMinPadding / 2,
                                        ),
                                        // TextFormField(
                                        //     controller: _fullNameController,
                                        //     textAlignVertical:
                                        //         TextAlignVertical.center,
                                        //     decoration: const InputDecoration(
                                        //         contentPadding:
                                        //             EdgeInsets.only(top: 0),
                                        //         prefixIcon: Icon(
                                        //           Icons.person_2_outlined,
                                        //         ),
                                        //         hintText: "Họ và tên")),
                                        // const SizedBox(
                                        //   height: kMinPadding / 2,
                                        // ),
                                        TextFormField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(top: 0),
                                                prefixIcon: Icon(
                                                  Icons.key_outlined,
                                                ),
                                                hintText: "Mật khẩu")),
                                        const SizedBox(
                                          height: kMinPadding / 2,
                                        ),
                                        TextFormField(
                                            controller:
                                                _confirmPasswordController,
                                            obscureText: true,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(top: 0),
                                                prefixIcon: Icon(
                                                  Icons.lock_outline,
                                                ),
                                                hintText: "Xác nhận mật khẩu")),
                                      ],
                                    )),
                                const SizedBox(
                                  height: kDefaultPadding,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      await registerController.register(
                                          _emailController.text,
                                          _passwordController.text);

                                      await Future.delayed(
                                          const Duration(seconds: 3));

                                      registerController.toLogin();
                                    },
                                    child: registerController
                                            .isRegistering.value
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text('Đăng ký')),
                              ],
                            ),
                          )),
                          TextButton(
                            onPressed: () {
                              registerController.toLogin();
                            },
                            child: const Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: "Bạn đã có tài khoản? ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: "Đăng nhập",
                                  style: TextStyle(
                                    color: ColorPalette.primaryColor,
                                  ),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
