import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/grade_controller.dart';
import 'package:mathquiz_mobile/helpers/input_validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _fullNameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    final localDataController = Get.put(LocalDataController());
    final gradeController = Get.put(GradeController());
    int gradeIdValue = -1;
    _emailController.text = localDataController.clientEmail.value == 'null' ||
            localDataController.clientEmail.value.isEmpty
        ? ''
        : localDataController.clientEmail.value;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => gradeController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
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
                                          hintText: "Email",
                                        ),
                                        validator: (value) =>
                                            InputValidator.validateEmail(value),
                                      ),
                                      const SizedBox(
                                        height: kMinPadding / 2,
                                      ),
                                      TextFormField(
                                        controller: _fullNameController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 0),
                                          prefixIcon: Icon(
                                            Icons.person,
                                          ),
                                          hintText: "Họ và tên",
                                        ),
                                        validator: (value) =>
                                            InputValidator.validateFullName(
                                                value),
                                      ),
                                      const SizedBox(
                                        height: kMinPadding / 2,
                                      ),
                                      Obx(() {
                                        gradeIdValue = authController
                                            .registerGradeId.value;
                                        return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Image.asset(
                                                  color: Colors.black,
                                                  'assets/images/grade_icon.png',
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            value:
                                                authController.registerGradeId.value != -1
                                                    ? gradeController.gradeList
                                                        .firstWhere((element) =>
                                                            element.id ==
                                                            authController
                                                                .registerGradeId
                                                                .value)
                                                        .name
                                                    : null,
                                            hint: Text(localDataController
                                                        .clientGradeId.value ==
                                                    -1
                                                ? "Chọn lớp"
                                                : gradeController.gradeList
                                                    .firstWhere((grade) =>
                                                        grade.id ==
                                                        localDataController
                                                            .clientGradeId
                                                            .value)
                                                    .name),
                                            items: gradeController.gradeList
                                                .where((grade) =>
                                                    grade.id <
                                                    16) // Filter out grades with id <= 13
                                                .map((grade) {
                                              return DropdownMenuItem<String>(
                                                value: grade.name,
                                                child: Text(grade.id <= 12
                                                    ? grade.name
                                                    : "Đại học"),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                final selectedGrade =
                                                    gradeController.gradeList
                                                        .firstWhere((grade) =>
                                                            grade.name ==
                                                            newValue);
                                                gradeIdValue = selectedGrade.id;
                                                print(gradeIdValue);
                                              }
                                            });
                                      }),
                                      const SizedBox(
                                        height: kMinPadding / 2,
                                      ),
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
                                          hintText: "Mật khẩu",
                                        ),
                                        validator: (value) =>
                                            InputValidator.validatePassword(
                                                value),
                                      ),
                                      const SizedBox(
                                        height: kMinPadding / 2,
                                      ),
                                      TextFormField(
                                        controller: _confirmPasswordController,
                                        obscureText: true,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 0),
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                          ),
                                          hintText: "Xác nhận mật khẩu",
                                        ),
                                        validator: (value) {
                                          if (value !=
                                              _passwordController.text) {
                                            return 'Mật khẩu không khớp';
                                          }
                                          return InputValidator
                                              .validatePassword(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: kDefaultPadding,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.register(
                                          _emailController.text,
                                          _passwordController.text,
                                          _fullNameController.text,
                                          gradeIdValue);
                                    }
                                  },
                                  child: authController.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text('Đăng ký'),
                                ),
                              ],
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      authController.toLogin();
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
        ],
      ),
    );
  }
}
